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
		'borderWidth',
		'graphicFactory',
		'playField',
		'gameCommander'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STSoccerScene class >> newApplicationSceneWithGameCommander: aGameCommander graphicFactory: aGraphicFactory [
	"Answer a new instance for application purpose with the given STSoccerFrame and STGraphicFactory."

	^ self new
		  initializeForApplicationWithGameCommander: aGameCommander
		  graphicFactory: aGraphicFactory
]

{ #category : 'instance creation' }
STSoccerScene class >> newSampleSceneWithGameCommander: aGameCommander [
	"Answer a new instance for demo purpose with the given STGameCommander and STGraphicFactory."

	^ self new
		  initializeForSampleWithGameCommander: aGameCommander
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

	self ball ifNotNil: [ :ball | self addNewShapesOnBall: ball ].
	self teamLeft players do: [ :player |
		self addNewShapeOnPlayer: player ].
	self teamRight players do: [ :player |
		self addNewShapeOnPlayer: player ]
]

{ #category : 'accessing' }
STSoccerScene >> announcer [
	"Answer the announcer I register at."

	^ self ball announcer
]

{ #category : 'private' }
STSoccerScene >> attackLine [
	"Answer the attack line if present, otherwise nil."

	^ playField childWithId: #attackLine ifNone: [ nil ]
]

{ #category : 'private' }
STSoccerScene >> attackingTeam [ 
	"Answer the attacking team or nil if ball is neutral."

	^ gameCommander owningTeam
]

{ #category : 'private' }
STSoccerScene >> ball [ 
	"Answer the ball model."

	^ gameCommander ball
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

{ #category : 'private' }
STSoccerScene >> defendingTeam [ 
	"Answer the defending team or nil if ball is neutral."

	^ gameCommander defendingTeam 
]

{ #category : 'initialization' }
STSoccerScene >> initializeForApplicationWithGameCommander: aGameCommander graphicFactory: aGraphicFactory [
	"Initialize for application purpose with the given STSoccerFrame and STGraphicFactory."

	gameCommander := aGameCommander.
	graphicFactory := aGraphicFactory.
	borderWidth := 30.
	transformer := STCoordinatesTransformer
		               newForApplicationWithWorldExtent:
		               aGameCommander pitch extent.
	playField := BlElement new extent: self playFieldExtent.
	self initializeShapes.
	self registerAtAnnouncer.
	gameCommander notifyCovering
]

{ #category : 'initialization' }
STSoccerScene >> initializeForSampleWithGameCommander: aGameCommander graphicFactory: aGraphicFactory [
	"Initialize for demo purpose with the given STSoccerFrame and STGraphicFactory."

	gameCommander := aGameCommander.
	graphicFactory := aGraphicFactory.
	borderWidth := 10.
	transformer := STCoordinatesTransformer newForSampleWithWorldExtent:
		               aGameCommander pitch extent.
	playField := BlElement new extent: self playFieldExtent.
	self initializeShapes.
	self registerAtAnnouncer.
	gameCommander notifyCovering
]

{ #category : 'initialization' }
STSoccerScene >> initializeShapes [
	"Initialize all my shapes."

	self paintPitch.
	self paintGoals.
	self addShapes
]

{ #category : 'private' }
STSoccerScene >> offsideLine [
	"Answer the offside line if present, otherwise nil."

	^ playField childWithId: #offsideLine ifNone: [ nil ]
]

{ #category : 'paint' }
STSoccerScene >> offsideLineColor [
	"Answer the current offside line Color."

	^ self defendingTeam ifNotNil: [ :team |
		  Color colorFrom: team gradientColorHigh ]
]

{ #category : 'paint' }
STSoccerScene >> paintGoals [
	"Paint the left and the right goal on the pitch's border."

	| goalWidth goalDepth goalLeft goalRight goalPosition |
	goalWidth := (transformer scaleWorldPoint: 0 @ self pitch goalWidth)
		             y.
	goalDepth := borderWidth / 2.

	goalPosition := goalDepth negated
	                @ (self playFieldExtent y / 2 - (goalWidth / 2)).
	goalLeft := BlElement new
		            extent: goalDepth @ goalWidth;
		            position: goalPosition;
		            background: self teamLeft jerseyGradient;
		            yourself.

	goalPosition := self playFieldExtent x @ goalPosition y.
	goalRight := BlElement new
		             extent: goalDepth @ goalWidth;
		             position: goalPosition;
		             background: self teamRight jerseyGradient;
		             yourself.

	playField addChild: goalLeft.
	playField addChild: goalRight
]

{ #category : 'paint' }
STSoccerScene >> paintGreen [
	"Paint the green lawn."

	self extent: self playFieldExtent + self borderExtent.
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
	middlePoint := transformer toDevice: self pitch middle.
	startPoint := middlePoint x @ 0.
	endPoint := middlePoint x @ self playFieldExtent y.

	verticalMiddleLine := BlLineGeometry from: startPoint to: endPoint.
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
STSoccerScene >> pitch [
	"Answer the pitch model."

	^ gameCommander pitch
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
		when: STPlayerShapeMovedAnnouncement
		do: [ :ann |
				| player targetWorldPoint |
				player := ann player.
				targetWorldPoint := self toWorld: ann targetDevicePoint.
				gameCommander movePlayer: player toPosition: targetWorldPoint ]
		for: self.

	self announcer
		when: STBallShapeMovedAnnouncement
		do: [ :ann |
				| targetWorldPoint |
				targetWorldPoint := self toWorld: ann targetDevicePoint.
				gameCommander moveBallToPosition: targetWorldPoint.

				self updateAttackLinePositionX: ann targetDevicePoint x ]
		for: self.

	self announcer
		when: STBallPossessionChangedAnnouncement
		do: [ :ann | self updateAttackLineAppearance ]
		for: self.

	self announcer
		when: STOffsideLineChangedAnnouncement
		do: [ :ann | self updateOffsideLinePositionX: ann offsideX ]
		for: self
]

{ #category : 'private' }
STSoccerScene >> teamLeft [ 
	"Answer the team left."

	^ gameCommander teamLeft 
]

{ #category : 'private' }
STSoccerScene >> teamRight [ 
	"Answer the team right."

	^ gameCommander teamRight 
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

{ #category : 'private' }
STSoccerScene >> updateAttackLineAppearance [
	"Update the attack line appearance depending on the attacking team."

	self attackLine changeAppearanceForAttackingTeam: self attackingTeam
]

{ #category : 'paint' }
STSoccerScene >> updateAttackLinePositionX: deviceX [
	"Lazy create and add the attack line shape and update its position."

	playField
		childWithId: #attackLine
		ifFound: [ :attackLine |
			attackLine
				strategicXValue: deviceX
				attackingTeam: self attackingTeam ]
		ifNone: [
			playField
				addChildFirst: (STAttackLineShape
						 newWithSegmentLength: transformer deviceExtent y
						 strategicX: deviceX
						 attackingTeam: self attackingTeam)
				as: #attackLine ]
]

{ #category : 'paint' }
STSoccerScene >> updateOffsideLinePositionX: worldX [
	"Lazy create and add the offside line shape and update its position."

	| deviceX |
	worldX ifNil: [ ^ playField removeChildWithId: #offsideLine ].

	deviceX := (transformer toDevice: worldX asPoint) x.
	playField
		childWithId: #offsideLine
		ifFound: [ :offsideLine |
			offsideLine strategicXValue: deviceX color: self offsideLineColor ]
		ifNone: [
			playField
				addChildFirst: (STOffsideLineShape
						 newWithSegmentLength: transformer deviceExtent y
						 strategicX: deviceX
						 color: self offsideLineColor)
				as: #offsideLine ]
]
