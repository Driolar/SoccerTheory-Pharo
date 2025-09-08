"
I care for the world to device and viceversa coordinate transformations.

It is assumed that
- the world origin is the center
- the device origin is top left.

It is also assumed that extents are even.


"
Class {
	#name : 'STCoordinatesTransformer',
	#superclass : 'Object',
	#instVars : [
		'deviceExtent',
		'worldExtent'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STCoordinatesTransformer class >> newForApplicationWithWorldExtent: aPoint [
	"Answer a new transformer for application purpose."

	^ self new
		  initializeWithWorldExtent: aPoint
		  deviceExtent: (Point x: 1110 y: 720)
]

{ #category : 'instance creation' }
STCoordinatesTransformer class >> newForSampleWithWorldExtent: aPoint [
	"Answer a new transformer for demo purpose."

	^ self new
		  initializeWithWorldExtent: aPoint
		  deviceExtent: (Point x: 556 y: 360) 
]

{ #category : 'accessing' }
STCoordinatesTransformer >> deviceExtent [
	"Answer the device extent Point."

	^ deviceExtent
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
STCoordinatesTransformer >> toDevice: worldPoint [
	"Transform world Point to device Point."

	^ (self scaleWorldPoint: (self translateWorldPoint: worldPoint)) rounded
]

{ #category : 'api - transformation' }
STCoordinatesTransformer >> toWorld: devicePoint [
	"Transform device Point to world Point."

	| transformedPoint |
	transformedPoint := self scaleDevicePoint:
		                    (self translateDevicePoint: devicePoint).
	^ transformedPoint x @ transformedPoint y negated
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
	^ Point
		  x: aPoint x + halfWorldExtent x
		  y: (aPoint y - halfWorldExtent y) negated 
]

{ #category : 'accessing' }
STCoordinatesTransformer >> worldExtent [
	"Answer the world extent Point."

	^worldExtent 
]
