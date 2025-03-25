"
I am a façade to operate on the model.

I am used by the STFrameEditor.

I provide access to the model by encapsulating the ActionManager and a current STSoccerFrame.
"
Class {
	#name : 'STGameCommander',
	#superclass : 'Object',
	#instVars : [
		'frame',
		'actionManager'
	],
	#classInstVars : [
		'frame',
		'actionManager'
	],
	#category : 'SoccerTheory-Application-Commander',
	#package : 'SoccerTheory-Application',
	#tag : 'Commander'
}

{ #category : 'instance creation' }
STGameCommander class >> newWithFrame: aFrame [
	"Answer a new instance with the given STSoccerFrame."

	^ self new initializeWithFrame: aFrame
]

{ #category : 'actions api' }
STGameCommander >> addNewPlayerToTeam: aSTTeam [
	"Create a new player for aTeam and let it add to aTeam. Answer the new player."

	| player |
	player := STPlayer
		          newWithPosition: (self entryPointForPlayerOfTeam: aSTTeam)
		          team: aSTTeam
		          frame: frame
		          number: aSTTeam nextFreeJerseyNumber.

	actionManager addPlayer: player toTeam: aSTTeam.

	^ player
]

{ #category : 'actions api' }
STGameCommander >> changeBallOwnerToTeam: aSTTeam [
	"Set ball possession to the given STTeam."

	actionManager changeBallOwnerToTeam: aSTTeam
]

{ #category : 'private' }
STGameCommander >> entryPointForPlayerOfTeam: aSTTeam [
	"Answer the pitch point where a new player of aTeam is initially located."

	^ Point x: frame pitch middle x y: frame pitch extent y / 2
]

{ #category : 'initialization' }
STGameCommander >> initializeWithFrame: aSTSoccerFrame [
	"Initialize with the given STSoccerFrame."

	frame := aSTSoccerFrame.
	actionManager := STActionManager newWithFrame: aSTSoccerFrame
]

{ #category : 'actions api' }
STGameCommander >> moveBallToPosition: aPoint [
	"Move the ball to the given world point."

	actionManager moveBallToPosition: aPoint
]

{ #category : 'actions api' }
STGameCommander >> movePlayer: aSTPlayer toPosition: aPoint [
	"Move the given model player to the given world point."

	actionManager movePlayer: aSTPlayer toPosition: aPoint
]

{ #category : 'accessing' }
STGameCommander >> owningTeam [ 
	"Answer the STTeam currently owning the ball."

	^ frame owningTeam 
]

{ #category : 'actions api' }
STGameCommander >> setAncientSoccerStrategy [

	^ actionManager setAncientSoccerStrategy
]

{ #category : 'actions api' }
STGameCommander >> setClassicSoccerStrategy [ 

	^ actionManager setClassicSoccerStrategy
]

{ #category : 'actions api' }
STGameCommander >> setModernSoccerStrategy [ 

	^ actionManager setModernSoccerStrategy
]

{ #category : 'actions api' }
STGameCommander >> setNoOffsideSoccerStrategy [ 

	^ actionManager setNoOffsideSoccerStrategy
]

{ #category : 'accessing' }
STGameCommander >> strategy [
	"Answer the current STCommonSoccerStrategy."

	^ frame strategy
]

{ #category : 'accessing' }
STGameCommander >> teamLeft [ 
	"Answer the STTeam playing from left to right."

	^ frame teamLeft 
]

{ #category : 'accessing' }
STGameCommander >> teamRight [
	"Answer the STTeam playing from right to left."

	^ frame teamRight
]
