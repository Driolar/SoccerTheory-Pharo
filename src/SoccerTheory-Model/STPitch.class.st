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
STPitch class >> newDefault [
	^ self new
]

{ #category : 'accessing' }
STPitch >> extent [

	^ Point x: length y: width
]

{ #category : 'accessing' }
STPitch >> goalLineForDirection: aDirection [
	self shouldBeImplemented
]

{ #category : 'accessing' }
STPitch >> goalWidth [

	^ goalWidth
]

{ #category : 'initialization' }
STPitch >> initialize [
	super initialize.
	length := 105.
	width := 68.
	goalWidth := 7.32
]

{ #category : 'accessing' }
STPitch >> middle [
	^ Point x: 0 y: 0
]
