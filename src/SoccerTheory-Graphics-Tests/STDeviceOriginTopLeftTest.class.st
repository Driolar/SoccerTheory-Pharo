"
I test STCoordinatesTransformer for the case that the device origin is top left.
"
Class {
	#name : 'STDeviceOriginTopLeftTest',
	#superclass : 'TestCase',
	#instVars : [
		'transformer'
	],
	#category : 'SoccerTheory-Graphics-Tests-Tests',
	#package : 'SoccerTheory-Graphics-Tests',
	#tag : 'Tests'
}

{ #category : 'private' }
STDeviceOriginTopLeftTest >> deviceBottomLeft [

	^ 0 @ self deviceExtent y
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> deviceBottomRight [

	^ self deviceExtent
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> deviceExtent [

	^ transformer deviceExtent
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> deviceMiddle [

	^ self deviceExtent / 2
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> deviceTopLeft [

	^ 0 @ 0
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> deviceTopRight [

	^ self deviceExtent x @ 0
]

{ #category : 'running' }
STDeviceOriginTopLeftTest >> setUp [

	| pitch |
	super setUp.
	pitch := STPitch newDefault.
	transformer := (STCoordinatesTransformer newWithWorldExtent:
			                pitch extent)
		               setDeviceToBloc;
		               yourself
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testDeviceToWorldBottomLeft [

	self
		assert: (self toWorld: self deviceBottomLeft)
		equals: self worldBottomLeft
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testDeviceToWorldBottomRight [

	self
		assert: (self toWorld: self deviceBottomRight)
		equals: self worldBottomRight
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testDeviceToWorldMiddle [

	self
		assert: (self toWorld: self deviceMiddle)
		equals: self worldMiddle
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testDeviceToWorldTopLeft [

	self
		assert: (self toWorld: self deviceTopLeft)
		equals: self worldTopLeft
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testDeviceToWorldTopRight [

	self
		assert: (self toWorld: self deviceTopRight)
		equals: self worldTopRight
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testWorldToDeviceBottomLeft [

	self
		assert: (self toDevice: self worldBottomLeft)
		equals: self deviceBottomLeft
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testWorldToDeviceBottomRight [

	self
		assert: (self toDevice: self worldBottomRight)
		equals: self deviceBottomRight
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testWorldToDeviceMiddle [

	self
		assert: (self toDevice: self worldMiddle)
		equals: self deviceMiddle
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testWorldToDeviceTopLeft [

	self
		assert: (self toDevice: self worldTopLeft)
		equals: self deviceTopLeft
]

{ #category : 'tests' }
STDeviceOriginTopLeftTest >> testWorldToDeviceTopRight [

	self
		assert: (self toDevice: self worldTopRight)
		equals: self deviceTopRight
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> toDevice: aWorldPoint [

	^ transformer toDevice: aWorldPoint
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> toWorld: aDevicePoint [

	^ transformer toWorld: aDevicePoint
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> worldBottomLeft [

	^ (self worldExtent / 2) negated
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> worldBottomRight [

	^ self worldExtent x / 2 @ (self worldExtent y / 2) negated
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> worldExtent [

	^ transformer worldExtent
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> worldMiddle [

	^ 0 @ 0
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> worldTopLeft [

	^ (self worldExtent x / 2) negated @ (self worldExtent y / 2)
]

{ #category : 'private' }
STDeviceOriginTopLeftTest >> worldTopRight [

	^ self worldExtent / 2
]
