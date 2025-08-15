"
I am a façade to operate on the model.

I am used by the STFrameEditor.

I provide access to the model by encapsulating the ActionManager and a current STSoccerFrame.
"
Class {
	#name : 'STGameCommander',
	#superclass : 'Object',
	#instVars : [
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
		          frame: self frame
		          number: aSTTeam nextFreeJerseyNumber.

	actionManager addPlayer: player toTeam: aSTTeam.

	^ player
]

{ #category : 'accessing' }
STGameCommander >> ball [
	"Answer the STBall currently in play."

	^ self frame ball
]

{ #category : 'actions api' }
STGameCommander >> changeBallOwnerToTeam: aSTTeam [
	"Set ball possession to the given STTeam."

	actionManager changeBallOwnerToTeam: aSTTeam
]

{ #category : 'accessing' }
STGameCommander >> defendingTeam [ 
	"Answer the STTeam currently defending."

	^ self frame defendingTeam 
]

{ #category : 'private' }
STGameCommander >> entryPointForPlayerOfTeam: aSTTeam [
	"Answer the pitch point where a new player of aTeam is initially located."

	^ self frame pitch middle x @ self frame pitch extent y / 2
]

{ #category : 'accessing' }
STGameCommander >> frame [

	^ actionManager frame
]

{ #category : 'initialization' }
STGameCommander >> initializeWithFrame: aSTSoccerFrame [
	"Initialize with the given STSoccerFrame."

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

	^ self frame owningTeam 
]

{ #category : 'accessing' }
STGameCommander >> pitch [
	"Answer the STPitch where game takes place."

	^ self frame pitch
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

	^ self frame strategy
]

{ #category : 'accessing' }
STGameCommander >> teamLeft [ 
	"Answer the STTeam playing from left to right."

	^ self frame teamLeft 
]

{ #category : 'accessing' }
STGameCommander >> teamRight [
	"Answer the STTeam playing from right to left."

	^ self frame teamRight
]
