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
	#category : 'SoccerTheory-Application-Basic',
	#package : 'SoccerTheory-Application',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STGameCommander class >> newWithFrame: aFrame [
	"Answer a new instance with the given STSoccerFrame."

	^ self new initializeWithFrame: aFrame
]

{ #category : 'actions api' }
STGameCommander >> changeBallOwnerToTeam: aTeam [
	"Set ball possession to the given STTeam."

	actionManager changeBallOwnerToTeam: aTeam
]

{ #category : 'initialization' }
STGameCommander >> initializeWithFrame: aFrame [
	"Initialize with the given STSoccerFrame."

	frame := aFrame.
	actionManager := STActionManager newWithPlay: aFrame
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
