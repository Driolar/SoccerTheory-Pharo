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
		'symbolFactory'
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
STPlayerShape >> goalkeeperElement [
	"Answer the goalkeeper BlElement."

	^ symbolFactory goalkeeperElement
]

{ #category : 'initialization' }
STPlayerShape >> initializeForPlayer: aPlayer graphicFactory: aGraphicFactory [
	"Initialize the shape instance for a given STBall and a graphic factory."

	player := aPlayer.
	symbolFactory := aGraphicFactory.
	squareExtent := 18 @ 18.
	self size: squareExtent.
	self background: self jerseyGradient.
	player isGoalkeeper ifTrue: [
		self addChild:
			(self goalkeeperElement position: (Point x: 1 y: 1)) ].
	(player isOffside isNotNil and: [ player isOffside ])
		ifTrue: [ self showOffside ]
		ifFalse: [
			(player isCovered isNotNil and: [ player isCovered not ]) ifTrue: [
				self showUncovered ] ].
	self addEventHandler: BlPullHandler new
]

{ #category : 'showing' }
STPlayerShape >> jerseyGradient [
	"Answer the gradient for the field player jersey."

	^ BlLinearGradientPaint horizontal
		  from: (Color colorFrom: player team color1)
		  to: (Color colorFrom: player team color2)
]

{ #category : 'private' }
STPlayerShape >> offsideElement [ 
	"Answer the offside BlElement."

	^symbolFactory offsideElement 
]

{ #category : 'showing' }
STPlayerShape >> showOffside [
	"Tag me being offside."

	self addChild: self offsideElement 
]

{ #category : 'showing' }
STPlayerShape >> showUncovered [
		"Tag me being uncovered."

	self addChild: self uncoveredElement 
]

{ #category : 'private' }
STPlayerShape >> uncoveredElement [
	"Answer the uncovered BlElement."

	^ symbolFactory uncoveredElement
]
