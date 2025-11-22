"
I represent the pitch where the soccer match takes place.

I know my length and width and also the width of both goals.
"
Class {
	#name : 'STPitch',
	#superclass : 'Object',
	#instVars : [
		'length',
		'width',
		'goalWidth'
	],
	#category : 'SoccerTheory-Model-Game',
	#package : 'SoccerTheory-Model',
	#tag : 'Game'
}

{ #category : 'private' }
STPitch class >> defaultGoalWidth [
	"Answer the default goal width in meters."

	^ 7.32
]

{ #category : 'instance creation' }
STPitch class >> extent: aPoint [
"Answer a new STPitch with the given extent (length@width) and the default goalWidth, all in meters."

	^ self new initializeWithExtent: aPoint goalWidth: self defaultGoalWidth
]

{ #category : 'instance creation' }
STPitch class >> extent: aPoint goalWidth: goalWidth [
"Answer a new STPitch with the given extent (length@width) and goalWidth, all in meters."

	^ self new initializeWithExtent: aPoint goalWidth: goalWidth
]

{ #category : 'instance creation' }
STPitch class >> newDefault [
	"Answer a new STPitch with the standard soccer dimensions in meters."

	^ self extent: 105 @ 68 
]

{ #category : 'accessing' }
STPitch >> extent [

	^ length @ width
]

{ #category : 'accessing' }
STPitch >> goalWidth [

	^ goalWidth
]

{ #category : 'initialization' }
STPitch >> initializeWithExtent: aPoint goalWidth: aNumber [

	self initialize.
	length := aPoint x.
	width := aPoint y.
	goalWidth := aNumber 
]

{ #category : 'accessing' }
STPitch >> leftGoalMiddlePoint [
	"Answer the middle Point of the left goal."

	^ (self extent x / 2) negated @ self middle y
]

{ #category : 'accessing' }
STPitch >> leftLowerGoalPost [
	"Answer the Point where the left lower goal post stands."

	^ self lowerGoalPostFromMiddle: self leftGoalMiddlePoint
]

{ #category : 'accessing' }
STPitch >> leftUpperGoalPost [
	"Answer the Point where the left upper goal post stands."

	^ self upperGoalPostFromMiddle: self leftGoalMiddlePoint
]

{ #category : 'accessing' }
STPitch >> lowerGoalPostFromMiddle: goalMiddlePoint [
	"Answer the Point where the lower goal post stands."

	^ goalMiddlePoint x @ (goalMiddlePoint y - (self goalWidth / 2))
]

{ #category : 'accessing' }
STPitch >> middle [
	^ Point x: 0 y: 0
]

{ #category : 'accessing' }
STPitch >> rightGoalMiddlePoint [
	"Answer the middle Point of the right goal."

	^ (self extent x / 2) @ self middle y
]

{ #category : 'accessing' }
STPitch >> rightLowerGoalPost [
	"Answer the Point where the right lower goal post stands."

	^ self lowerGoalPostFromMiddle: self rightGoalMiddlePoint
]

{ #category : 'accessing' }
STPitch >> rightUpperGoalPost [
	"Answer the Point where the right upper goal post stands."

	^ self upperGoalPostFromMiddle: self rightGoalMiddlePoint
]

{ #category : 'accessing' }
STPitch >> upperGoalPostFromMiddle: goalMiddlePoint [
	"Answer the Point where the upper goal post stands."

	^ goalMiddlePoint x @ (goalMiddlePoint y + (self goalWidth / 2))
]
