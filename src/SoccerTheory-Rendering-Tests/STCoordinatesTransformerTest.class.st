Class {
	#name : 'STCoordinatesTransformerTest',
	#superclass : 'TestCase',
	#instVars : [
		'transformer'
	],
	#category : 'SoccerTheory-Rendering-Tests-Tests',
	#package : 'SoccerTheory-Rendering-Tests',
	#tag : 'Tests'
}

{ #category : 'private' }
STCoordinatesTransformerTest >> deviceBottomLeft [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ Point x: 0 y: self deviceExtent y
]

{ #category : 'private' }
STCoordinatesTransformerTest >> deviceBottomRight [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ self deviceExtent 
]

{ #category : 'private' }
STCoordinatesTransformerTest >> deviceExtent [ 
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	 ^transformer deviceExtent 
]

{ #category : 'private' }
STCoordinatesTransformerTest >> deviceMiddle [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ self deviceExtent / 2
]

{ #category : 'private' }
STCoordinatesTransformerTest >> deviceTopLeft [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ Point x: 0 y: 0
]

{ #category : 'private' }
STCoordinatesTransformerTest >> deviceTopRight [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ Point x: self deviceExtent x y: 0
]

{ #category : 'running' }
STCoordinatesTransformerTest >> setUp [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	| pitch |
	super setUp.
	pitch := STPitch newDefault.
	transformer := STCoordinatesTransformer newForSampleWithWorldExtent:
		               pitch extent
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testDeviceToWorldBottomLeft [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toWorld: self deviceBottomLeft)
		equals: self worldBottomLeft
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testDeviceToWorldBottomRight [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toWorld: self deviceBottomRight)
		equals: self worldBottomRight 
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testDeviceToWorldMiddle [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toWorld: self deviceMiddle)
		equals: self worldMiddle
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testDeviceToWorldTopLeft [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toWorld: self deviceTopLeft)
		equals: self worldTopLeft
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testDeviceToWorldTopRight [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toWorld: self deviceTopRight)
		equals: self worldTopRight
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testWorldToDeviceBottomLeft [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toDevice: self worldBottomLeft)
		equals: self deviceBottomLeft
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testWorldToDeviceBottomRight [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toDevice: self worldBottomRight)
		equals: self deviceBottomRight
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testWorldToDeviceMiddle [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toDevice: self worldMiddle)
		equals: self deviceMiddle 
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testWorldToDeviceTopLeft [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toDevice: self worldTopLeft)
		equals: self deviceTopLeft 
]

{ #category : 'tests' }
STCoordinatesTransformerTest >> testWorldToDeviceTopRight [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	self
		assert: (self toDevice: self worldTopRight)
		equals: self deviceTopRight
]

{ #category : 'private' }
STCoordinatesTransformerTest >> toDevice: aWorldPoint [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	 ^transformer toDevice: aWorldPoint 
]

{ #category : 'private' }
STCoordinatesTransformerTest >> toWorld: aDevicePoint [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	 ^transformer toWorld: aDevicePoint 
]

{ #category : 'private' }
STCoordinatesTransformerTest >> worldBottomLeft [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ (self worldExtent / 2) negated
]

{ #category : 'private' }
STCoordinatesTransformerTest >> worldBottomRight [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ Point x: self worldExtent x / 2 y: (self worldExtent y / 2) negated
]

{ #category : 'private' }
STCoordinatesTransformerTest >> worldExtent [ 
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	 ^transformer worldExtent 
]

{ #category : 'private' }
STCoordinatesTransformerTest >> worldMiddle [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ Point x: 0 y: 0
]

{ #category : 'private' }
STCoordinatesTransformerTest >> worldTopLeft [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ Point x: (self worldExtent x / 2) negated y: self worldExtent y / 2
]

{ #category : 'private' }
STCoordinatesTransformerTest >> worldTopRight [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ self worldExtent / 2
]
