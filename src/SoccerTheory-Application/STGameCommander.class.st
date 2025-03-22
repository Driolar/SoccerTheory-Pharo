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
STGameCommander >> addNewPlayerToTeam: aTeam [
	"Create a new player for aTeam and let it add to aTeam. Answer the new player."

	| player |
	player := STPlayer
		          newWithPosition: (self entryPointForPlayerOfTeam: aTeam)
		          team: aTeam
		          frame: frame
		          number: aTeam nextFreeJerseyNumber.

	actionManager addPlayer: player toTeam: aTeam.

	^ player
]

{ #category : 'actions api' }
STGameCommander >> changeBallOwnerToTeam: aTeam [
	"Set ball possession to the given STTeam."

	actionManager changeBallOwnerToTeam: aTeam
]

{ #category : 'private' }
STGameCommander >> entryPointForPlayerOfTeam: aTeam [
	"Answer the pitch point where a new player of aTeam is initially located."

	^ Point x: frame pitch middle x y: frame pitch extent y / 2
]

{ #category : 'initialization' }
STGameCommander >> initializeWithFrame: aFrame [
	"Initialize with the given STSoccerFrame."

	frame := aFrame.
	actionManager := STActionManager newWithFrame: aFrame
]

{ #category : 'actions api' }
STGameCommander >> moveBallToPosition: aPosition [
	"Move the ball to the given world point."

	actionManager moveBallToPosition: aPosition
]

{ #category : 'actions api' }
STGameCommander >> movePlayer: aPlayer toPosition: aPosition [
	"Move the given model player to the given world point."

	actionManager movePlayer: aPlayer toPosition: aPosition
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
