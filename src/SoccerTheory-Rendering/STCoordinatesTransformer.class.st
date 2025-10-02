"
I care for the world to device and viceversa coordinate transformations.

It is assumed that the world coordinates are the classical:
- Origin is the center.
- First quadrant (top right) coordinates x and y are non-negative.

By default, device coordinates are like in Roassal:
- Origin is the center.
- Y-axis is negative in the upper half and positive in the lower half.

The device coordinates can be set to Bloc mode with ```#setDeviceToBloc```:
- Origin is top left.
- x and y coordinates are non-negative.

It is assumed that extents are even to minimize unprecision.


"
Class {
	#name : 'STCoordinatesTransformer',
	#superclass : 'Object',
	#instVars : [
		'deviceExtent',
		'worldExtent',
		'isDeviceOriginTopLeft'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STCoordinatesTransformer class >> newForApplicationWithWorldExtent: aPoint [
	"Answer a new transformer for application purpose."

	^ self new initializeWithWorldExtent: aPoint deviceExtent: 1110 @ 720
]

{ #category : 'instance creation' }
STCoordinatesTransformer class >> newForSampleWithWorldExtent: aPoint [
	"Answer a new transformer for demo purpose."

	^ self new
		  initializeWithWorldExtent: aPoint
		  deviceExtent: self sampleDeviceExtent
]

{ #category : 'accessing' }
STCoordinatesTransformer class >> sampleDeviceExtent [

	^ 556 @ 360
]

{ #category : 'accessing' }
STCoordinatesTransformer >> deviceExtent [
	"Answer the device extent Point."

	^ deviceExtent
]

{ #category : 'initialization' }
STCoordinatesTransformer >> initialize [

	super initialize.
	isDeviceOriginTopLeft := false
]

{ #category : 'initialization' }
STCoordinatesTransformer >> initializeWithWorldExtent: worldPoint deviceExtent: devicePoint [
	"Initialize with world and device extent Points."

	worldExtent := worldPoint.
	deviceExtent := devicePoint 
]

{ #category : 'api - transformation' }
STCoordinatesTransformer >> scaleDevicePoint: aPoint [
	"Scale device Point to world Point."

	^ aPoint * worldExtent / deviceExtent
]

{ #category : 'api - transformation' }
STCoordinatesTransformer >> scaleWorldPoint: aPoint [
		"Scale world Point to device Point."

	^ (aPoint * deviceExtent) / worldExtent
]

{ #category : 'api - transformation' }
STCoordinatesTransformer >> setDeviceToBloc [

	isDeviceOriginTopLeft := true
]

{ #category : 'api - transformation' }
STCoordinatesTransformer >> toDevice: worldPoint [
	"Transform world Point to device Point."

	^ (self scaleWorldPoint: (isDeviceOriginTopLeft
			    ifTrue: [ self translateWorldPoint: worldPoint ]
			    ifFalse: [ worldPoint x @ worldPoint y negated ])) rounded
]

{ #category : 'api - transformation' }
STCoordinatesTransformer >> toWorld: devicePoint [
	"Transform device Point to world Point."

	| worldPoint |
	worldPoint := self scaleDevicePoint: (isDeviceOriginTopLeft
			                     ifTrue: [
			                     self translateDevicePoint: devicePoint ]
			                     ifFalse: [ devicePoint ]).
	^ worldPoint x @ worldPoint y negated
]

{ #category : 'api - transformation' }
STCoordinatesTransformer >> translateDevicePoint: aPoint [
	"Translate device Point to world Point."

	^ aPoint - (deviceExtent / 2)
]

{ #category : 'api - transformation' }
STCoordinatesTransformer >> translateWorldPoint: aPoint [
	"Translate world Point to device Point."

	| halfWorldExtent |
	halfWorldExtent := worldExtent / 2.
	^ aPoint x + halfWorldExtent x
	  @ (aPoint y - halfWorldExtent y) negated
]

{ #category : 'accessing' }
STCoordinatesTransformer >> worldExtent [
	"Answer the world extent Point."

	^worldExtent 
]
