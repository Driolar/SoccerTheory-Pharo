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
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
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

{ #category : 'accessing' }
STGameCommander >> ball [
	"Answer the STBall currently in play."

	^ frame ball
]

{ #category : 'actions api' }
STGameCommander >> changeBallOwnerToTeam: aSTTeam [
	"Set ball possession to the given STTeam."

	actionManager changeBallOwnerToTeam: aSTTeam
]

{ #category : 'accessing' }
STGameCommander >> defendingTeam [ 
	"Answer the STTeam currently defending."

	^ frame defendingTeam 
]

{ #category : 'private' }
STGameCommander >> entryPointForPlayerOfTeam: aSTTeam [
	"Answer the pitch point where a new player of aTeam is initially located."

	^ frame pitch middle x @ frame pitch extent y / 2
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

{ #category : 'actions api' }
STGameCommander >> notifyCovering [

	actionManager notifyCovering
]

{ #category : 'accessing' }
STGameCommander >> owningTeam [ 
	"Answer the STTeam currently owning the ball."

	^ frame owningTeam 
]

{ #category : 'accessing' }
STGameCommander >> pitch [
	"Answer the STPitch where game takes place."

	^ frame pitch
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
