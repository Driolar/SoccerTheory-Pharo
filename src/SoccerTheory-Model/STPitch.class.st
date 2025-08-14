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

{ #category : 'instance creation' }
STPitch class >> extent: aPoint goalWidth: goalWidth [
"Answer a new STPitch with the given extent (length@width) and goalWidth, all in meters."

	^ self new initializeWithExtent: aPoint goalWidth: goalWidth
]

{ #category : 'instance creation' }
STPitch class >> newDefault [
	"Answer a new STPitch with the standard soccer dimensions in meters."

	^ self extent: 105 @ 68 goalWidth: 7.32
]

{ #category : 'accessing' }
STPitch >> extent [

	^ Point x: length y: width
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
STPitch >> middle [
	^ Point x: 0 y: 0
]
