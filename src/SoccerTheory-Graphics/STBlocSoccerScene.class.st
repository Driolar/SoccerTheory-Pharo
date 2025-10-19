"
I render the soccer pitch including all other soccer game elements on it.

Currently using me: STFrameEditor and STSequencePlayer.

"
Class {
	#name : 'STBlocSoccerScene',
	#superclass : 'STSoccerScene',
	#instVars : [
		'graphicFactory',
		'playField',
		'sceneView'
	],
	#category : 'SoccerTheory-Graphics-Bloc',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Bloc'
}

{ #category : 'viewing' }
STBlocSoccerScene class >> viewPresenterClass [
	"Answer the SpPresenter class for presenting my views."

	^ SpBlSpaceInMorphPresenter
]

{ #category : 'creation' }
STBlocSoccerScene >> addNewShapeOnBall: aBall [
	"Add a new STBallShape on a STBall and also the corresponding attack line."

	| centerPoint ballShape |
	ballShape := STBlocBallShape
		             newForBall: aBall
		             graphicFactory: graphicFactory
		             playFieldExtent: self playFieldExtent.
	centerPoint := transformer toDevice: aBall position.
	playField
		addChild: (ballShape centerPosition: centerPoint)
		as: #ballShape.

	self updateAttackLinePositionX: centerPoint x
]

{ #category : 'api' }
STBlocSoccerScene >> addNewShapeOnPlayer: aPlayer [
	"Add a new STPlayerBlElement on a STPlayer."

	| playerShape centerPoint |
	playerShape := STBlocPlayerShape
		               newWithPlayer: aPlayer
		               graphicFactory: graphicFactory
		               playFieldExtent: self playFieldExtent.
	centerPoint := transformer toDevice: aPlayer position.
	playField
		addChild: (playerShape
				 centerPosition: centerPoint;
				 yourself)
		before: self ballShape "The ball must always be visible."
]

{ #category : 'paint' }
STBlocSoccerScene >> attackLineElement [
	"Answer the attack line BlElement if present, otherwise nil."

	^ playField childWithId: #attackLine ifNone: [ nil ]
]

{ #category : 'private' }
STBlocSoccerScene >> ballShape [
	"Answer the ball shape."

	^ playField childWithId: #ballShape
]

{ #category : 'paint' }
STBlocSoccerScene >> goalLeftElement [
	"Answer the BlElement representing the left goal."

	| goalPosition hoverOverEventHandler hoverOutEventHandler hoverText |
	goalPosition := self deviceGoalDepth negated
	                @
	                (self playFieldExtent y / 2
	                 - (self deviceGoalWidth / 2)).

	hoverText := self hoverTextElementWith: self teamLeft teamName.
	hoverText position: 0 @ 0.

	hoverOverEventHandler := BlEventHandler
		                         on: BlMouseOverEvent
		                         do: [ :anEvent |
		                         anEvent currentTarget
			                         addChild: hoverText
			                         as: #goalLeft ].

	hoverOutEventHandler := BlEventHandler
		                        on: BlMouseOutEvent
		                        do: [ :anEvent |
		                        anEvent currentTarget removeChildWithId:
			                        #goalLeft ].

	^ BlElement new
		  extent: self deviceGoalDepth @ self deviceGoalWidth;
		  position: goalPosition;
		  background: self teamLeft jerseyGradient;
		  addEventHandler: hoverOverEventHandler;
		  addEventHandler: hoverOutEventHandler;
		  clipChildren: false;
		  yourself
]

{ #category : 'paint' }
STBlocSoccerScene >> goalRightElement [
	"Answer the BlElement representing the right goal."

	| goalPosition hoverOverEventHandler hoverOutEventHandler hoverText |
	goalPosition := self playFieldExtent x
	                @
	                (self playFieldExtent y / 2
	                 - (self deviceGoalWidth / 2)).

	hoverText := self hoverTextElementWith: self teamRight teamName.
	hoverText position: (self teamRight teamName size * 5) negated @ 0.

	hoverOverEventHandler := BlEventHandler
		                         on: BlMouseOverEvent
		                         do: [ :anEvent |
		                         anEvent currentTarget
			                         addChild: hoverText
			                         as: #goalRight ].

	hoverOutEventHandler := BlEventHandler
		                        on: BlMouseOutEvent
		                        do: [ :anEvent |
		                        anEvent currentTarget removeChildWithId:
			                        #goalRight ].

	^ BlElement new
		  extent: self deviceGoalDepth @ self deviceGoalWidth;
		  position: goalPosition;
		  background: self teamRight jerseyGradient;
		  addEventHandler: hoverOverEventHandler;
		  addEventHandler: hoverOutEventHandler;
		  clipChildren: false;
		  yourself
]

{ #category : 'paint' }
STBlocSoccerScene >> hoverTextElementWith: aString [

	^ ((BlRopedText string: aString) fontSize: 11) asElement
		  background: Color white;
		  padding: (BlInsets all: 2)
]

{ #category : 'initialization' }
STBlocSoccerScene >> initialize [

	super initialize.
	graphicFactory := STGraphicFactory new.
	sceneView := BlElement new
]

{ #category : 'initialization' }
STBlocSoccerScene >> initializeTransformerWithWorldExtent: aPoint [

	super initializeTransformerWithWorldExtent: aPoint.
	transformer setDeviceToBloc
]

{ #category : 'private' }
STBlocSoccerScene >> offsideLine [
	"Answer the offside line if present, otherwise nil."

	^ playField childWithId: #offsideLine ifNone: [ nil ]
]

{ #category : 'paint' }
STBlocSoccerScene >> paintGoals [
	"Paint the left and the right goal on the pitch's border."

	playField
		addChild: self goalLeftElement;
		addChild: self goalRightElement
]

{ #category : 'paint' }
STBlocSoccerScene >> paintGreen [
	"Paint the green lawn."

	sceneView extent: self totalExtent.
	sceneView background: self pitchSurroundingColor.

	playField background: self pitchColor.
	playField position: self borderExtent / 2.
	playField clipChildren: false.
	sceneView addChild: playField
]

{ #category : 'paint' }
STBlocSoccerScene >> paintMiddleLine [
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
STBlocSoccerScene >> paintPitch [
	"Paint the pitch's green and middle line."

	self paintGreen.
	self paintMiddleLine
]

{ #category : 'creation' }
STBlocSoccerScene >> renderMovableShapes [
	"Add all the shapes from the soccer frame."

	self ball ifNotNil: [ :ball | self addNewShapeOnBall: ball ].
	self teamLeft players do: [ :player |
		self addNewShapeOnPlayer: player ].
	self teamRight players do: [ :player |
		self addNewShapeOnPlayer: player ]
]

{ #category : 'initialization' }
STBlocSoccerScene >> renderShapes [
	"Render all my shapes."

	playField := BlElement new extent: self playFieldExtent.
	self paintPitch.
	self paintGoals.
	self renderMovableShapes
]

{ #category : 'api' }
STBlocSoccerScene >> renderViewIn: aBlSpace [
	"Repopulate the play field with the current shapes."

	aBlSpace root removeChildren.
	aBlSpace setExtent: self totalExtent.
	aBlSpace root addChild: self sceneView.
	self renderShapes.
	self startAnnouncements
]

{ #category : 'creation' }
STBlocSoccerScene >> sceneView [
	"Answer the whole rendered view as BlElement."

	^ sceneView
]

{ #category : 'paint' }
STBlocSoccerScene >> updateAttackLineAppearance [
	"Update the attack line appearance depending on the attacking team."

	self attackLineElement changeAppearanceForAttackingTeam: self attackingTeam
]

{ #category : 'paint' }
STBlocSoccerScene >> updateAttackLinePositionX: deviceX [
	"Lazy create and add the attack line shape and update its position."

	playField
		childWithId: #attackLine
		ifFound: [ :attackLine |
			attackLine
				strategicXValue: deviceX
				attackingTeam: self attackingTeam ]
		ifNone: [
				playField
					addChildFirst: (STBlocAttackLineShape
							 newWithSegmentLength: self playFieldExtent y
							 strategicX: deviceX
							 attackingTeam: self attackingTeam)
					as: #attackLine ]
]

{ #category : 'paint' }
STBlocSoccerScene >> updateOffsideLinePositionX: worldX [
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
					addChildFirst: (STBlocOffsideLineShape
							 newWithSegmentLength: self playFieldExtent y
							 strategicX: deviceX
							 color: self offsideLineColor)
					as: #offsideLine ]
]
