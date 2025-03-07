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
	#category : 'SoccerTheory-Application',
	#package : 'SoccerTheory-Application'
}

{ #category : 'instance creation' }
STGameCommander class >> newWithFrame: aFrame [
	"Answer a new instance with the given STSoccerFrame."

	^ self new initializeWithFrame: aFrame
]

{ #category : 'initialization' }
STGameCommander >> initializeWithFrame: aFrame [
	"Initialize with the given STSoccerFrame."

	frame := aFrame.
	actionManager := STActionManager newWithPlay: aFrame 
]

{ #category : 'accessing' }
STGameCommander >> strategy [
	"Answer the current STCommonSoccerStrategy."

	^ frame strategy
]
