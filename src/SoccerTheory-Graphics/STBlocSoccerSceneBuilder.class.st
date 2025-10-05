"
I render the soccer pitch including all other soccer game elements on it.

Currently using me: STFrameEditor and STSequencePlayer.

"
Class {
	#name : 'STBlocSoccerSceneBuilder',
	#superclass : 'STSoccerSceneBuilder',
	#instVars : [
		'graphicFactory',
		'surface',
		'playField'
	],
	#category : 'SoccerTheory-Graphics-Bloc',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Bloc'
}

{ #category : 'viewing' }
STBlocSoccerSceneBuilder class >> viewPresenterClass [
	"Answer the SpPresenter class for presenting my views."

	^ SpBlSpaceInMorphPresenter
]

{ #category : 'creation' }
STBlocSoccerSceneBuilder >> addNewShapeOnPlayer: aPlayer [
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

{ #category : 'creation' }
STBlocSoccerSceneBuilder >> addNewShapesOnBall: aBall [
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

{ #category : 'creation' }
STBlocSoccerSceneBuilder >> addShapes [
	"Add all the shapes from the soccer frame."

	self ball ifNotNil: [ :ball | self addNewShapesOnBall: ball ].
	self teamLeft players do: [ :player |
		self addNewShapeOnPlayer: player ].
	self teamRight players do: [ :player |
		self addNewShapeOnPlayer: player ]
]

{ #category : 'paint' }
STBlocSoccerSceneBuilder >> attackLineElement [
	"Answer the attack line BlElement if present, otherwise nil."

	^ playField childWithId: #attackLine ifNone: [ nil ]
]

{ #category : 'private' }
STBlocSoccerSceneBuilder >> ballShape [
	"Answer the ball shape."

	^ playField childWithId: #ballShape
]

{ #category : 'paint' }
STBlocSoccerSceneBuilder >> goalLeftElement [
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
STBlocSoccerSceneBuilder >> goalRightElement [
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
STBlocSoccerSceneBuilder >> hoverTextElementWith: aString [

	^ ((BlRopedText string: aString) fontSize: 11) asElement
		  background: Color white;
		  padding: (BlInsets all: 2)
]

{ #category : 'initialization' }
STBlocSoccerSceneBuilder >> initialize [

	super initialize.
	graphicFactory := STGraphicFactory new.
	surface := BlElement new
]

{ #category : 'initialization' }
STBlocSoccerSceneBuilder >> initializeAnnouncements [
	"Initialize the announcements."

	self registerAtAnnouncer.
	self notifyCovering
]

{ #category : 'initialization' }
STBlocSoccerSceneBuilder >> initializeGraphics [
	"Initialize the graphical components."

	playField := BlElement new extent: self playFieldExtent.
	self initializeShapes.
]

{ #category : 'initialization' }
STBlocSoccerSceneBuilder >> initializeShapes [
	"Initialize all my shapes."

	self paintPitch.
	self paintGoals.
	self addShapes
]

{ #category : 'initialization' }
STBlocSoccerSceneBuilder >> initializeTransformerWithWorldExtent: aPoint [

	super initializeTransformerWithWorldExtent: aPoint.
	transformer setDeviceToBloc
]

{ #category : 'initialization' }
STBlocSoccerSceneBuilder >> initializeWithGameCommander: aSTGameCommander [

	super initializeWithGameCommander: aSTGameCommander.
	self initializeGraphics.
	self initializeAnnouncements
]

{ #category : 'private' }
STBlocSoccerSceneBuilder >> offsideLine [
	"Answer the offside line if present, otherwise nil."

	^ playField childWithId: #offsideLine ifNone: [ nil ]
]

{ #category : 'paint' }
STBlocSoccerSceneBuilder >> paintGoals [
	"Paint the left and the right goal on the pitch's border."

	playField
		addChild: self goalLeftElement;
		addChild: self goalRightElement
]

{ #category : 'paint' }
STBlocSoccerSceneBuilder >> paintGreen [
	"Paint the green lawn."

	surface extent: self playFieldExtent + self borderExtent.
	surface background: (Color fromHexString: '66CC66'). "Moderate lime green border"

	playField background: (Color fromHexString: '009666'). "dark cyan - lime green"
	playField position: self borderExtent / 2.
	playField clipChildren: false.
	surface addChild: playField
]

{ #category : 'paint' }
STBlocSoccerSceneBuilder >> paintMiddleLine [
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
STBlocSoccerSceneBuilder >> paintPitch [
	"Paint the pitch's green and middle line."

	self paintGreen.
	self paintMiddleLine
]

{ #category : 'api' }
STBlocSoccerSceneBuilder >> refreshView: aBlSpace [

	aBlSpace root removeChildren.
	aBlSpace setExtent: self totalExtent.
	aBlSpace root addChild: self surface
]

{ #category : 'initialization' }
STBlocSoccerSceneBuilder >> registerAtAnnouncer [
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

{ #category : 'creation' }
STBlocSoccerSceneBuilder >> surface [
	"Answer the whole surface BlElement."

	^ surface
]

{ #category : 'private' }
STBlocSoccerSceneBuilder >> updateAttackLineAppearance [
	"Update the attack line appearance depending on the attacking team."

	self attackLineElement changeAppearanceForAttackingTeam: self attackingTeam
]

{ #category : 'paint' }
STBlocSoccerSceneBuilder >> updateAttackLinePositionX: deviceX [
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
STBlocSoccerSceneBuilder >> updateOffsideLinePositionX: worldX [
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
