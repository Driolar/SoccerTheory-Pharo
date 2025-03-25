"
I am a line as long as the play field width, perpendicular to the play field length (x-axis) and relevant to the soccer strategy.

The style of the line and the form of my vertices depends on my subclass.

I am slided by the logic of the concrete soccer strategy along the x-axis, parallel to the goal lines.
"
Class {
	#name : 'STStrategicLineShape',
	#superclass : 'BlElement',
	#instVars : [
		'segmentLength'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STStrategicLineShape class >> newWithSegmentLength: length slideX: slideX color: aColor [
	"Answer a new vertical strategic line of given length, initial sweep x-coordinate xSweep and color aColor."

	^ self new
		  initializeWithSegmentLength: length
		  slideX: slideX
		  color: aColor
]

{ #category : 'private' }
STStrategicLineShape >> addEndPoints [
	"Add my end point shapes."

	| topEndPoint bottomEndPoint |
	topEndPoint := self newEndPointPrototype.
	topEndPoint geometry beTop.
	topEndPoint position: (self endPointSize / 2) negated @ 0.

	bottomEndPoint := self newEndPointPrototype.
	bottomEndPoint geometry beBottom.
	bottomEndPoint position:
		(self endPointSize / 2) negated
		@ (segmentLength - self endPointSize).

	self clipChildren: false.
	self addChild: topEndPoint.
	self addChild: bottomEndPoint
]

{ #category : 'private' }
STStrategicLineShape >> borderBuilder [
	"Answer my border builder."

	^BlBorderBuilder new 
]

{ #category : 'accessing' }
STStrategicLineShape >> color: aColor [

	self border: (self borderBuilder
			 paint: aColor;
			 width: 1;
			 build).
	self childrenDo: [ :endPoint | endPoint background: aColor ]
]

{ #category : 'private' }
STStrategicLineShape >> endPointSize [

	^ 12
]

{ #category : 'initialization' }
STStrategicLineShape >> initializeWithSegmentLength: length slideX: xCoordinate color: aColor [

	segmentLength := length.
	self geometry: (BlLineGeometry from: 0 @ 0 to: 0 @ segmentLength).
	self slideXValue: xCoordinate.
	self addEndPoints.
	self color: aColor
]

{ #category : 'private' }
STStrategicLineShape >> newEndPointPrototype [
	"Answer a prototype for building the top or the bottom end point."

	^ BlElement new
		  geometry: BlTriangleGeometry new;
		  border: BlBorder empty;
		  size: self endPointSize asPoint
]

{ #category : 'accessing' }
STStrategicLineShape >> slideXValue: xCoordinate [

	self position: xCoordinate @ 0
]
