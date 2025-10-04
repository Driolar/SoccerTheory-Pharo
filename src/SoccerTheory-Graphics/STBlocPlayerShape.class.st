"
I am a visual player whose model is STPlayer.

I visualize 
- my team color
- my jersey number
- if I am offside
- if I am uncovered
- if I am goalkeeper.

Also I am pullable.
"
Class {
	#name : 'STBlocPlayerShape',
	#superclass : 'STBlocMovableShape',
	#instVars : [
		'player'
	],
	#category : 'SoccerTheory-Graphics-Bloc',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Bloc'
}

{ #category : 'instance creation' }
STBlocPlayerShape class >> newWithPlayer: aPlayer graphicFactory: aGraphicFactory playFieldExtent: aPoint [
	"Answer a new player shape for the given STPlayer, STGraphicFactory and play field extent."

	^ self new
		  initializeForPlayer: aPlayer
		  graphicFactory: aGraphicFactory
		  playFieldExtent: aPoint
]

{ #category : 'accessing' }
STBlocPlayerShape >> ball [

	^ player ball
]

{ #category : 'private' }
STBlocPlayerShape >> formattedPlayerPositionString [
	"Answer the formatted string representing the model player's position."

	^ '(' , (player position x printShowingDecimalPlaces: 1) , '@'
	  , (player position y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'private' }
STBlocPlayerShape >> goalkeeperElement [
	"Answer the goalkeeper BlElement."

	^ graphicFactory goalkeeperElement
]

{ #category : 'showing' }
STBlocPlayerShape >> hideOffside [
	"Remove the offside tag if present."

	self removeChildWithId: #offside
]

{ #category : 'private' }
STBlocPlayerShape >> hideShadow [
	"Show my shadow (when being deselected)."

	self effect: nil
]

{ #category : 'showing' }
STBlocPlayerShape >> hideUncovered [
		"Remove the uncovered tag if present."

	self removeChildWithId: #uncovered
]

{ #category : 'private' }
STBlocPlayerShape >> hoverTextString [
	"Answer the string for the hover text element."

	^ '#',self jerseyString , ' ' , self formattedPlayerPositionString
]

{ #category : 'initialization' }
STBlocPlayerShape >> initializeForPlayer: aSTPlayer graphicFactory: aSTGraphicFactory playFieldExtent: aPoint [
	"Initialize the shape instance for a given STPlayer and a graphic factory."

	player := aSTPlayer.
	graphicFactory := aSTGraphicFactory.
	playFieldExtent := aPoint.
	self initializeEventHandling.

	squareExtent := 18 @ 18.
	self extent: squareExtent.
	self background: self jerseyGradient.
	player isGoalkeeper ifTrue: [
		self addChild: (self goalkeeperElement position: 1 @ 1) ].
	self updateOffside.
	self updateUncovered
]

{ #category : 'private' }
STBlocPlayerShape >> isOffside [
	"Answer whether player is in offside or not."

	^ player isOffside isNotNil and: [ player isOffside ]
]

{ #category : 'private' }
STBlocPlayerShape >> jerseyGradient [
	"Answer the gradient for the field player's jersey."

	^ self team jerseyGradient 
]

{ #category : 'private' }
STBlocPlayerShape >> jerseyNumber [ 
	"Answer the players jersey number"

	^player jerseyNumber
]

{ #category : 'private' }
STBlocPlayerShape >> jerseyString [ 
	"Answer the players jersey number asString"

	^player jerseyNumber asString 
]

{ #category : 'accessing' }
STBlocPlayerShape >> name [
	"Answer my name string."

	^ 'Player ' , self jerseyString , ' of ' , player teamName
]

{ #category : 'private' }
STBlocPlayerShape >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	"Don't rely on self centerPosition here but use aPoint. Self centerposition may still answer the ancient position even after notifyPositionChanged. Timing problem?"

	^ STPlayerShapeMovedAnnouncement
		  newOnPlayer: player
		  targetPosition: aPoint
]

{ #category : 'private' }
STBlocPlayerShape >> offsideElement [
	"Answer the offside BlElement."

	^ self team isTeamLeft
		  ifTrue: [ graphicFactory offsideElement ]
		  ifFalse: [
				  graphicFactory offsideElement transform
					  flipY;
					  apply;
					  target ]
]

{ #category : 'initialization' }
STBlocPlayerShape >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self announcer
		when: STOffsideSwitchedAnnouncement
		do: [ :ann | self updateOffside ]
		for: self.
	self announcer
		when: STUncoveredSwitchedAnnouncement
		do: [ :ann | self updateUncovered ]
		for: self
]

{ #category : 'showing' }
STBlocPlayerShape >> showOffside [
	"Tag me being offside."

	self
		childWithId: #offside
		ifNone: [ self addChild: self offsideElement as: #offside ]
]

{ #category : 'private' }
STBlocPlayerShape >> showShadow [
	"Show my shadow (when being selected)."

	self effect: (BlSimpleShadowEffect color: Color black offset: 2 @ 2)
]

{ #category : 'showing' }
STBlocPlayerShape >> showUncovered [
	"Tag me being uncovered."

	self
		childWithId: #uncovered
		ifNone: [ self addChild: self uncoveredElement as: #uncovered ]
]

{ #category : 'private' }
STBlocPlayerShape >> team [
	"Answer my STTeam."

	^ player team
]

{ #category : 'private' }
STBlocPlayerShape >> uncoveredElement [
	"Answer the uncovered BlElement."

	^ graphicFactory uncoveredElement
]

{ #category : 'showing' }
STBlocPlayerShape >> updateOffside [
	"Show or remove the offside flag reflecting the model."

	self isOffside
		ifTrue: [
			self hideUncovered.
			self showOffside ]
		ifFalse: [ self hideOffside ]
]

{ #category : 'showing' }
STBlocPlayerShape >> updateUncovered [
	"Show or remove the uncovered flag reflecting the model."

	self isOffside
		ifTrue: [ self hideUncovered ]
		ifFalse: [
			(player isCovered isNotNil and: [ player isCovered not ])
				ifTrue: [ self showUncovered ]
				ifFalse: [ self hideUncovered ] ]
]
