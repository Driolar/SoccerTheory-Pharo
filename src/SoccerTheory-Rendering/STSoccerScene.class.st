"
I render the soccer pitch including all other soccer game elements on it.

The STFrameEditor shows me.

I access to the soccer model through STSoccerFrame.

"
Class {
	#name : 'STSoccerScene',
	#superclass : 'BlElement',
	#instVars : [
		'transformer',
		'soccerFrame',
		'borderWidth',
		'graphicFactory',
		'playField'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STSoccerScene class >> newApplicationSceneWithFrame: aFrame graphicFactory: aGraphicFactory [
	"Answer a new instance for application purpose with the given STSoccerFrame and STGraphicFactory."

	^ self new
		  initializeForApplicationWithFrame: aFrame
		  graphicFactory: aGraphicFactory
]

{ #category : 'instance creation' }
STSoccerScene class >> newSampleSceneWithFrame: aFrame [
	"Answer a new instance for demo purpose with the given STSoccerFrame and STGraphicFactory."

	^ self new
		  initializeForSampleWithFrame: aFrame
		  graphicFactory: STGraphicFactory new
]

{ #category : 'creation' }
STSoccerScene >> addNewShapeOnPlayer: aPlayer [
	"Add a new STBallPlayer on a STPlayer."

	| playerShape centerPoint |
	playerShape := STPlayerShape
		               newWithPlayer: aPlayer
		               graphicFactory: graphicFactory.
	centerPoint := transformer toDevice: aPlayer position.
	playField
		addChild: (playerShape
				 centerPosition: centerPoint;
				 yourself)
		before: self ballShape "The ball must always be visible."
]

{ #category : 'creation' }
STSoccerScene >> addNewShapesOnBall: aBall [
	"Add a new STBallShape on a STBall and also the corresponding attack line."

	| centerPoint ballShape |
	ballShape := STBallShape
		             newForBall: aBall
		             graphicFactory: graphicFactory.
	centerPoint := transformer toDevice: aBall position.
	playField
		addChild: (ballShape centerPosition: centerPoint)
		as: #ballShape.
		
   self updateAttackLinePositionX: centerPoint x

]

{ #category : 'creation' }
STSoccerScene >> addShapes [
	"Add all the shapes from the soccer frame."

	soccerFrame ball ifNotNil: [ :ball | self addNewShapesOnBall: ball ].
	soccerFrame teamLeft players do: [ :player |
		self addNewShapeOnPlayer: player ].
	soccerFrame teamRight players do: [ :player |
		self addNewShapeOnPlayer: player ]
]

{ #category : 'accessing' }
STSoccerScene >> announcer [
	"Answer the announcer I register at."

	^ soccerFrame announcer
]

{ #category : 'private' }
STSoccerScene >> attackLine [
	"Answer the attack line."

	^ playField childWithId: #attackLine
]

{ #category : 'paint' }
STSoccerScene >> attackLineColor [
	"Answer the current attackLineColor"

	^ soccerFrame owningTeam
		  ifNotNil: [ :team | Color colorFrom: team gradientColorHigh ]
		  ifNil: [ Color yellow ]
]

{ #category : 'private' }
STSoccerScene >> ballShape [
	"Answer the ball shape."

	^ playField childWithId: #ballShape
]

{ #category : 'paint' }
STSoccerScene >> borderExtent [
	"Answer the border extent as a Point."

	^ borderWidth asPoint * 2
]

{ #category : 'initialization' }
STSoccerScene >> initializeForApplicationWithFrame: aFrame graphicFactory: aGraphicFactory [
	"Initialize for application purpose with the given STSoccerFrame and STGraphicFactory."

	soccerFrame := aFrame.
	graphicFactory := aGraphicFactory.
	borderWidth := 30.
	transformer := STCoordinatesTransformer
		               newForApplicationWithWorldExtent: aFrame pitch extent.
	playField := BlElement new size: self playFieldExtent.
	self initializeShapes.
	self registerAtAnnouncer
]

{ #category : 'initialization' }
STSoccerScene >> initializeForSampleWithFrame: aFrame graphicFactory: aGraphicFactory [
	"Initialize for demo purpose with the given STSoccerFrame and STGraphicFactory."

	soccerFrame := aFrame.
	graphicFactory := aGraphicFactory.
	borderWidth := 10.
	transformer := STCoordinatesTransformer newForSampleWithWorldExtent:
		               aFrame pitch extent.
	playField := BlElement new size: self playFieldExtent.
	self initializeShapes.
	self registerAtAnnouncer
]

{ #category : 'initialization' }
STSoccerScene >> initializeShapes [
	"Initialize all my shapes."

	self paintPitch.
	self paintGoals.
	self addShapes
]

{ #category : 'paint' }
STSoccerScene >> paintGoals [
	"Paint the left and the right goal on the pitch's border."

	| goalWidth goalDepth goalLeft goalRight goalPosition |
	goalWidth := (transformer scaleWorldPoint:
		              (Point x: 0 y: soccerFrame pitch goalWidth)) y.
	goalDepth := borderWidth / 2.

	goalPosition := Point
		                x: goalDepth negated
		                y: self playFieldExtent y / 2 - (goalWidth / 2).
	goalLeft := BlElement new
		            size: (Point x: goalDepth y: goalWidth);
		            position: goalPosition;
		            background: soccerFrame teamLeft jerseyGradient;
		            yourself.

	goalPosition := Point x: self playFieldExtent x y: goalPosition y.
	goalRight := BlElement new
		             size: (Point x: goalDepth y: goalWidth);
		             position: goalPosition;
		             background: soccerFrame teamRight jerseyGradient;
		             yourself.

	playField addChild: goalLeft.
	playField addChild: goalRight
]

{ #category : 'paint' }
STSoccerScene >> paintGreen [
	"Paint the green lawn."

	self size: self playFieldExtent + self borderExtent.
	self background: (Color fromHexString: '66CC66'). "Moderate lime green border"

	playField background: (Color fromHexString: '009666'). "dark cyan - lime green"
	playField position: self borderExtent / 2.
	playField clipChildren: false.
	self addChild: playField
]

{ #category : 'paint' }
STSoccerScene >> paintMiddleLine [
	"Paint the middle line of the soccer pitch."

	| verticalMiddleLine horizontalMiddleLine middlePoint startPoint endPoint |
	middlePoint := transformer toDevice: soccerFrame pitch middle.
	startPoint := Point x: middlePoint x y: 0.
	endPoint := Point x: middlePoint x y: self playFieldExtent y.

	verticalMiddleLine := BlLineGeometry
		                      from: startPoint
		                      to: endPoint.
	playField addChild: (verticalMiddleLine asElement border:
			 (BlBorder paint: Color white width: 1)).

	horizontalMiddleLine := BlLineGeometry
		                        from: middlePoint - (4 @ 0) 
		                        to: middlePoint + (4 @ 0).
	playField addChild: (horizontalMiddleLine asElement border:
			 (BlBorder paint: Color white width: 1))
]

{ #category : 'paint' }
STSoccerScene >> paintPitch [
	"Paint the pitch's green and middle line."

	self paintGreen.
	self paintMiddleLine
]

{ #category : 'private' }
STSoccerScene >> playFieldExtent [ 
	"Answer the pitch's device extent."

	^transformer deviceExtent 
]

{ #category : 'initialization' }
STSoccerScene >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self announcer
		when: STBallShapeMovedAnnouncement
		do: [ :ann |
		self updateAttackLinePositionX: ann targetDevicePoint x ]
		for: self.

	self announcer
		when: STBallPossessionChangedAnnouncement
		do: [ :ann | self updateAttackLineColor ]
		for: self.

	self announcer
		when: STSoccerStrategyChangedAnnouncement
		do: [ :ann | self updateAttackLineVisibility ]
		for: self
]

{ #category : 'api - transformation' }
STSoccerScene >> toWorld: aDevicePoint [
	"Transform device Point to world Point."

	^ transformer toWorld: aDevicePoint
]

{ #category : 'paint' }
STSoccerScene >> totalExtent [
	"Answer the total extent including the play field's border"

	^ self playFieldExtent + self borderExtent 
]

{ #category : 'paint' }
STSoccerScene >> updateAttackLineColor [
	"Update the attack line with the correct color."

	playField
		childWithId: #attackLine
		ifFound: [ :attackLine | attackLine color: self attackLineColor ]
]

{ #category : 'paint' }
STSoccerScene >> updateAttackLinePositionX: deviceX [
	"Lazy create and add the attack line shape and update its position."

	playField
		childWithId: #attackLine
		ifFound: [ :attackLine | attackLine slideXValue: deviceX ]
		ifNone: [
			playField
				addChildFirst: (STAttackLineShape
						 newWithSegmentLength: transformer deviceExtent y
						 slideX: deviceX
						 color: self attackLineColor)
				as: #attackLine ]
]

{ #category : 'paint' }
STSoccerScene >> updateAttackLineVisibility [
	"Hide or show the attack line shape depending on the current soccer strategy."

	^ soccerFrame strategy isAncient
		  ifTrue: [ self attackLine visibility: BlVisibility gone ]
		  ifFalse: [ self attackLine visibility: BlVisibility visible ]
]
