"
I am the abstract builder of two-dimensional soccer scenes.
Besides building the scene, I am able to render it on the corresponding SpPresenter. 

Current concrete builders: STBlocSoccerSceneBuilder (Bloc) and STRoassalSoccerSceneBuilder (Roassal).
"
Class {
	#name : 'STSoccerSceneBuilder',
	#superclass : 'Object',
	#instVars : [
		'transformer',
		'gameCommander'
	],
	#category : 'SoccerTheory-Application-Builder',
	#package : 'SoccerTheory-Application',
	#tag : 'Builder'
}

{ #category : 'instance creation' }
STSoccerSceneBuilder class >> new [

	self shouldNotImplement
]

{ #category : 'instance creation' }
STSoccerSceneBuilder class >> newWithGameCommander: aGameCommander [
	"Answer a new instance for application purpose with the given STGameCommander."

	^ self basicNew initializeWithGameCommander: aGameCommander
]

{ #category : 'viewing' }
STSoccerSceneBuilder class >> viewPresenterClass [
	"Answer the SpPresenter class for presenting my views."

	self subclassResponsibility
]

{ #category : 'accessing' }
STSoccerSceneBuilder >> announcer [
	"Answer the announcer I register at."

	^ self ball announcer
]

{ #category : 'private' }
STSoccerSceneBuilder >> attackingTeam [
	"Answer the attacking team or nil if ball is neutral."

	^ gameCommander owningTeam
]

{ #category : 'private' }
STSoccerSceneBuilder >> ball [
	"Answer the ball model."

	^ gameCommander ball
]

{ #category : 'paint' }
STSoccerSceneBuilder >> borderExtent [
	"Answer the border extent as a Point."

	^ self borderWidth asPoint * 2
]

{ #category : 'accessing' }
STSoccerSceneBuilder >> borderWidth [

	^ 30
]

{ #category : 'private' }
STSoccerSceneBuilder >> defendingTeam [
	"Answer the defending team or nil if ball is neutral."

	^ gameCommander defendingTeam
]

{ #category : 'paint' }
STSoccerSceneBuilder >> deviceGoalDepth [
	"Answer the goal depth in pixels."

	^ self borderWidth / 2
]

{ #category : 'paint' }
STSoccerSceneBuilder >> deviceGoalWidth [
	"Answer the goal width in pixels."

	^ (transformer scaleWorldPoint: 0 @ self pitch goalWidth) y
]

{ #category : 'initialization' }
STSoccerSceneBuilder >> initializeTransformerWithWorldExtent: aPoint [

	transformer := STCoordinatesTransformer
		               newForApplicationWithWorldExtent: aPoint
]

{ #category : 'initialization' }
STSoccerSceneBuilder >> initializeWithGameCommander: aSTGameCommander [

	self initialize.
	gameCommander := aSTGameCommander.
	self initializeTransformerWithWorldExtent:
		aSTGameCommander pitch extent
]

{ #category : 'private' }
STSoccerSceneBuilder >> notifyCovering [

	gameCommander notifyCovering
]

{ #category : 'paint' }
STSoccerSceneBuilder >> offsideLineColor [
	"Answer the current offside line Color."

	^ self defendingTeam ifNotNil: [ :team |
		  Color colorFrom: team gradientColorHigh ]
]

{ #category : 'private' }
STSoccerSceneBuilder >> pitch [
	"Answer the pitch model."

	^ gameCommander pitch
]

{ #category : 'private' }
STSoccerSceneBuilder >> playFieldExtent [
	"Answer the pitch's device extent."

	^ transformer deviceExtent
]

{ #category : 'api' }
STSoccerSceneBuilder >> refreshViewOnPresenter: aSpPresenter [

	self subclassResponsibility
]

{ #category : 'private' }
STSoccerSceneBuilder >> teamLeft [
	"Answer the team left."

	^ gameCommander teamLeft
]

{ #category : 'private' }
STSoccerSceneBuilder >> teamRight [
	"Answer the team right."

	^ gameCommander teamRight
]

{ #category : 'api' }
STSoccerSceneBuilder >> toWorld: aDevicePoint [
	"Transform device Point to world Point."

	^ transformer toWorld: aDevicePoint
]

{ #category : 'paint' }
STSoccerSceneBuilder >> totalExtent [
	"Answer the total extent including the play field's border"

	^ self playFieldExtent + self borderExtent 
]
