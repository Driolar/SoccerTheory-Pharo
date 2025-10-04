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
	#name : 'STPlayerBlElement',
	#superclass : 'STMovableBlElement',
	#instVars : [
		'player'
	],
	#category : 'SoccerTheory-Rendering-Bloc',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Bloc'
}

{ #category : 'instance creation' }
STPlayerBlElement class >> newWithPlayer: aPlayer graphicFactory: aGraphicFactory playFieldExtent: aPoint [
	"Answer a new player shape for the given STPlayer, STGraphicFactory and play field extent."

	^ self new
		  initializeForPlayer: aPlayer
		  graphicFactory: aGraphicFactory
		  playFieldExtent: aPoint
]

{ #category : 'accessing' }
STPlayerBlElement >> ball [

	^ player ball
]

{ #category : 'private' }
STPlayerBlElement >> formattedPlayerPositionString [
	"Answer the formatted string representing the model player's position."

	^ '(' , (player position x printShowingDecimalPlaces: 1) , '@'
	  , (player position y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'private' }
STPlayerBlElement >> goalkeeperElement [
	"Answer the goalkeeper BlElement."

	^ graphicFactory goalkeeperElement
]

{ #category : 'showing' }
STPlayerBlElement >> hideOffside [
	"Remove the offside tag if present."

	self removeChildWithId: #offside
]

{ #category : 'private' }
STPlayerBlElement >> hideShadow [
	"Show my shadow (when being deselected)."

	self effect: nil
]

{ #category : 'showing' }
STPlayerBlElement >> hideUncovered [
		"Remove the uncovered tag if present."

	self removeChildWithId: #uncovered
]

{ #category : 'private' }
STPlayerBlElement >> hoverTextString [
	"Answer the string for the hover text element."

	^ '#',self jerseyString , ' ' , self formattedPlayerPositionString
]

{ #category : 'initialization' }
STPlayerBlElement >> initializeForPlayer: aSTPlayer graphicFactory: aSTGraphicFactory playFieldExtent: aPoint [
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
STPlayerBlElement >> isOffside [
	"Answer whether player is in offside or not."

	^ player isOffside isNotNil and: [ player isOffside ]
]

{ #category : 'private' }
STPlayerBlElement >> jerseyGradient [
	"Answer the gradient for the field player's jersey."

	^ self team jerseyGradient 
]

{ #category : 'private' }
STPlayerBlElement >> jerseyNumber [ 
	"Answer the players jersey number"

	^player jerseyNumber
]

{ #category : 'private' }
STPlayerBlElement >> jerseyString [ 
	"Answer the players jersey number asString"

	^player jerseyNumber asString 
]

{ #category : 'accessing' }
STPlayerBlElement >> name [
	"Answer my name string."

	^ 'Player ' , self jerseyString , ' of ' , player teamName
]

{ #category : 'private' }
STPlayerBlElement >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	"Don't rely on self centerPosition here but use aPoint. Self centerposition may still answer the ancient position even after notifyPositionChanged. Timing problem?"

	^ STPlayerShapeMovedAnnouncement
		  newOnPlayer: player
		  targetPosition: aPoint
]

{ #category : 'private' }
STPlayerBlElement >> offsideElement [
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
STPlayerBlElement >> registerAtAnnouncer [
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
STPlayerBlElement >> showOffside [
	"Tag me being offside."

	self
		childWithId: #offside
		ifNone: [ self addChild: self offsideElement as: #offside ]
]

{ #category : 'private' }
STPlayerBlElement >> showShadow [
	"Show my shadow (when being selected)."

	self effect: (BlSimpleShadowEffect color: Color black offset: 2 @ 2)
]

{ #category : 'showing' }
STPlayerBlElement >> showUncovered [
	"Tag me being uncovered."

	self
		childWithId: #uncovered
		ifNone: [ self addChild: self uncoveredElement as: #uncovered ]
]

{ #category : 'private' }
STPlayerBlElement >> team [
	"Answer my STTeam."

	^ player team
]

{ #category : 'private' }
STPlayerBlElement >> uncoveredElement [
	"Answer the uncovered BlElement."

	^ graphicFactory uncoveredElement
]

{ #category : 'showing' }
STPlayerBlElement >> updateOffside [
	"Show or remove the offside flag reflecting the model."

	self isOffside
		ifTrue: [
			self hideUncovered.
			self showOffside ]
		ifFalse: [ self hideOffside ]
]

{ #category : 'showing' }
STPlayerBlElement >> updateUncovered [
	"Show or remove the uncovered flag reflecting the model."

	self isOffside
		ifTrue: [ self hideUncovered ]
		ifFalse: [
			(player isCovered isNotNil and: [ player isCovered not ])
				ifTrue: [ self showUncovered ]
				ifFalse: [ self hideUncovered ] ]
]
