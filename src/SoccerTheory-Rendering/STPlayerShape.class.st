"
I am a visual player whose model is STPlayer.

I visualize 
- my team color
- my jersey number
- if I am offside
- if I am uncovered
- if I am goalkeeper.

I am also pullable.
"
Class {
	#name : 'STPlayerShape',
	#superclass : 'STMovableShape',
	#instVars : [
		'player'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STPlayerShape class >> newWithPlayer: aPlayer graphicFactory: aGraphicFactory [
	"Answer a new player shape for the given STPlayer and STGraphicFactory."

	^ self new
		  initializeForPlayer: aPlayer
		  graphicFactory: aGraphicFactory
]

{ #category : 'private' }
STPlayerShape >> formattedPlayerPositionString [
	"Answer the formatted string representing the model player's position."

	^ '(' , (player position x printShowingDecimalPlaces: 1) , '@'
	  , (player position y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'private' }
STPlayerShape >> goalkeeperElement [
	"Answer the goalkeeper BlElement."

	^ graphicFactory goalkeeperElement
]

{ #category : 'showing' }
STPlayerShape >> hideOffside [
	"Remove the offside tag if present."

	self removeChildWithId: #offside
]

{ #category : 'private' }
STPlayerShape >> hideShadow [
	"Show my shadow (when being deselected)."

	self effect: nil
]

{ #category : 'showing' }
STPlayerShape >> hideUncovered [
		"Remove the uncovered tag if present."

	self removeChildWithId: #uncovered
]

{ #category : 'private' }
STPlayerShape >> hoverTextString [
	"Answer the string for the hover text element."

	^ '#',self jerseyString , ' ' , self formattedPlayerPositionString
]

{ #category : 'initialization' }
STPlayerShape >> initializeForPlayer: aSTPlayer graphicFactory: aSTGraphicFactory [
	"Initialize the shape instance for a given STBall and a graphic factory."

	player := aSTPlayer.
	graphicFactory := aSTGraphicFactory.
	squareExtent := 18 @ 18.
	self size: squareExtent.
	self background: self jerseyGradient.
	player isGoalkeeper ifTrue: [
		self addChild: (self goalkeeperElement position: (Point x: 1 y: 1)) ].
	self updateOffside.
	self updateUncovered.
]

{ #category : 'private' }
STPlayerShape >> isOffside [
	"Answer whether player is in offside or not."

	^ player isOffside isNotNil and: [ player isOffside ]
]

{ #category : 'private' }
STPlayerShape >> jerseyGradient [
	"Answer the gradient for the field player's jersey."

	^ player team jerseyGradient 
]

{ #category : 'private' }
STPlayerShape >> jerseyNumber [ 
	"Answer the players jersey number"

	^player jerseyNumber
]

{ #category : 'private' }
STPlayerShape >> jerseyString [ 
	"Answer the players jersey number asString"

	^player jerseyNumber asString 
]

{ #category : 'accessing' }
STPlayerShape >> name [
	"Answer my name string."

	^ 'Player ' , self jerseyString , ' of ' , player teamName
]

{ #category : 'private' }
STPlayerShape >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	"Don't rely on self centerPosition here but use aPosition. Self centerposition may still answer the ancient position even after notifyPositionChanged. Timing problem?"

	^ STPlayerShapeMovedAnnouncement
		  newOnPlayer: player
		  targetPosition: aPoint
]

{ #category : 'private' }
STPlayerShape >> offsideElement [ 
	"Answer the offside BlElement."

	^graphicFactory offsideElement 
]

{ #category : 'initialization' }
STPlayerShape >> registerAtAnnouncer [
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
STPlayerShape >> showOffside [
	"Tag me being offside."

	self
		childWithId: #offside
		ifNone: [ self addChild: self offsideElement as: #offside ]
]

{ #category : 'private' }
STPlayerShape >> showShadow [
	"Show my shadow (when being selected)."

	self effect: (BlSimpleShadowEffect color: Color black offset: 2 @ 2)
]

{ #category : 'showing' }
STPlayerShape >> showUncovered [
	"Tag me being uncovered."

	self
		childWithId: #uncovered
		ifNone: [ self addChild: self uncoveredElement as: #uncovered ]
]

{ #category : 'private' }
STPlayerShape >> uncoveredElement [
	"Answer the uncovered BlElement."

	^ graphicFactory uncoveredElement
]

{ #category : 'showing' }
STPlayerShape >> updateOffside [
	"Show or remove the offside flag reflecting the model."

	self isOffside
		ifTrue: [
			self hideUncovered.
			self showOffside ]
		ifFalse: [ self hideOffside ]
]

{ #category : 'showing' }
STPlayerShape >> updateUncovered [
	"Show or remove the uncovered flag reflecting the model."

	self isOffside
		ifTrue: [ self hideUncovered ]
		ifFalse: [
			(player isCovered isNotNil and: [ player isCovered not ])
				ifTrue: [ self showUncovered ]
				ifFalse: [ self hideUncovered ] ]
]
