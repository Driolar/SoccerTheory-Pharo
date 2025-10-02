"
I act as a framework for rendering two-dimensional soccer scenes with the support of a determined graphics package like Bloc or Roassal.

Currently using me: STSoccerSceneBlElement (Bloc) and STSoccerSceneRSShape (Roassal).
"
Class {
	#name : 'STSoccerScene',
	#superclass : 'Object',
	#instVars : [
		'transformer',
		'gameCommander'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STSoccerScene class >> new [

	self shouldNotImplement
]

{ #category : 'instance creation' }
STSoccerScene class >> newWithGameCommander: aGameCommander [
	"Answer a new instance for application purpose with the given STGameCommander."

	^ self basicNew initializeWithGameCommander: aGameCommander
]

{ #category : 'accessing' }
STSoccerScene >> announcer [
	"Answer the announcer I register at."

	^ self ball announcer
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

{ #category : 'paint' }
STSoccerScene >> borderExtent [
	"Answer the border extent as a Point."

	^ self borderWidth asPoint * 2
]

{ #category : 'accessing' }
STSoccerScene >> borderWidth [

	^ 30
]

{ #category : 'private' }
STSoccerScene >> defendingTeam [
	"Answer the defending team or nil if ball is neutral."

	^ gameCommander defendingTeam
]

{ #category : 'paint' }
STSoccerScene >> deviceGoalDepth [
	"Answer the goal depth in pixels."

	^ self borderWidth / 2
]

{ #category : 'paint' }
STSoccerScene >> deviceGoalWidth [
	"Answer the goal width in pixels."

	^ (transformer scaleWorldPoint: 0 @ self pitch goalWidth) y
]

{ #category : 'initialization' }
STSoccerScene >> initializeTransformerWithWorldExtent: aPoint [

	transformer := STCoordinatesTransformer
		               newForApplicationWithWorldExtent: aPoint
]

{ #category : 'initialization' }
STSoccerScene >> initializeWithGameCommander: aSTGameCommander [

	self initialize.
	gameCommander := aSTGameCommander.
	self initializeTransformerWithWorldExtent:
		aSTGameCommander pitch extent
]

{ #category : 'private' }
STSoccerScene >> notifyCovering [

	gameCommander notifyCovering
]

{ #category : 'paint' }
STSoccerScene >> offsideLineColor [
	"Answer the current offside line Color."

	^ self defendingTeam ifNotNil: [ :team |
		  Color colorFrom: team gradientColorHigh ]
]

{ #category : 'private' }
STSoccerScene >> pitch [
	"Answer the pitch model."

	^ gameCommander pitch
]

{ #category : 'private' }
STSoccerScene >> playFieldExtent [
	"Answer the pitch's device extent."

	^ transformer deviceExtent
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
