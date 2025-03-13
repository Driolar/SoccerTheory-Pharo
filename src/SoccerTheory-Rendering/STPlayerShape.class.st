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
	#superclass : 'BlElement',
	#instVars : [
		'player',
		'squareExtent',
		'graphicFactory'
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

{ #category : 'initialization' }
STPlayerShape >> addEventHandlers [
	"Answer the mouseOverEventHandler that shows the hover text."

	self addEventHandler: BlPullHandler new.
	
	self addEventHandler: (BlEventHandler
			 on: BlMouseOverEvent
			 do: [ :anEvent |
				 anEvent currentTarget
					 addChild: self hoverTextElement
					 as: #hovertext ]).
	
	self addEventHandler: (BlEventHandler
			 on: BlMouseOutEvent
			 do: [ :anEvent |
			 anEvent currentTarget removeChildWithId: #hovertext ]).
	
	self addEventHandler: (BlEventHandler
			 on: BlDragStartEvent 
			 do: [ :anEvent |
			 anEvent currentTarget removeChildWithId: #hovertext ]).
	
	self addEventHandler: (BlEventHandler
			 on: BlDragEndEvent 
			 do: [ :anEvent |
				 anEvent currentTarget removeChildWithId: #hovertext.
				 self announcer announce: (STPlayerShapeMovedAnnouncement
						  newOnPlayer: player
						  targetPosition: self centerPosition) ])
]

{ #category : 'private' }
STPlayerShape >> announcer [
	"Answer the announcer to send and receive announcements."

	^ STSoccerFrame announcer
]

{ #category : 'accessing' }
STPlayerShape >> centerPosition [
	"Answer the very center point of the shape."

	"This doesn't always work: self position: aPosition - (self extent / 2). 
	Sometimes self extent returns here 0@0 instead of 18@18.
	For this reason, the variable squareExtent is introduced."

	^ self position + (squareExtent / 2)
]

{ #category : 'accessing' }
STPlayerShape >> centerPosition: aPosition [
	"Set the device origin top left based on the center position point."

	"This doesn't always work: self position: aPosition - (self extent / 2). 
	Sometimes self extent returns here 0@0 instead of 18@18.
	For this reason, the variable squareExtent is introduced."

	self position: aPosition - (squareExtent / 2)
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

{ #category : 'showing' }
STPlayerShape >> hideUncovered [
		"Remove the uncovered tag if present."

	self removeChildWithId: #uncovered
]

{ #category : 'private' }
STPlayerShape >> hoverTextElement [
	"Answer the player's hover text"

	| hoverText |
	hoverText := ((BlRopedText string: self hoverTextString) fontSize: 12)
		             asElement
		             background: Color white;
		             padding: (BlInsets all: 2).
	hoverText position:
		(Point x: self hoverTextPositionX y: self hoverTextPositionY).
	^ hoverText
]

{ #category : 'private' }
STPlayerShape >> hoverTextPositionX [
	"Answer the x coordinate of the hover text."

	^ squareExtent x
]

{ #category : 'private' }
STPlayerShape >> hoverTextPositionY [
	"Answer the y coordinate of the hover text."

	| parentExtent |
	parentExtent := self parent extent.
	^ self centerPosition y < (parentExtent y / 2)
		  ifTrue: [ squareExtent y ]
		  ifFalse: [ 0 ]
]

{ #category : 'private' }
STPlayerShape >> hoverTextString [
	"Answer the string for the hover text element."

	^ self jerseyString , ' ' , self formattedPlayerPositionString
]

{ #category : 'initialization' }
STPlayerShape >> initializeForPlayer: aPlayer graphicFactory: aGraphicFactory [
	"Initialize the shape instance for a given STBall and a graphic factory."

	player := aPlayer.
	graphicFactory := aGraphicFactory.
	squareExtent := 18 @ 18.
	self size: squareExtent.
	self background: self jerseyGradient.
	player isGoalkeeper ifTrue: [
		self addChild: (self goalkeeperElement position: (Point x: 1 y: 1)) ].
	self updateOffside.
	self updateUncovered.
	self addEventHandlers.
	self registerAtAnnouncer.
	self clipChildren: false "for hover text"
]

{ #category : 'private' }
STPlayerShape >> isOffside [
	"Answer whether player is in offside or not."

	^ player isOffside isNotNil and: [ player isOffside ]
]

{ #category : 'private' }
STPlayerShape >> jerseyGradient [
	"Answer the gradient for the field player jersey."

	^ BlLinearGradientPaint horizontal
		  from: (Color colorFrom: player team color1)
		  to: (Color colorFrom: player team color2)
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

	self addChild: self offsideElement as: #offside 
]

{ #category : 'showing' }
STPlayerShape >> showUncovered [
		"Tag me being uncovered."

	self addChild: self uncoveredElement as: #uncovered 
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
