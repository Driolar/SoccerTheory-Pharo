"
I am a line as long as the play field width, perpendicular to the play field length (x-axis) and relevant to the soccer strategy.

The style of the line and the form of my vertices depends on my subclass.

I am slided by the logic of the concrete soccer strategy along the x-axis, parallel to the goal lines.
"
Class {
	#name : 'STBlocStrategicLineShape',
	#superclass : 'BlElement',
	#instVars : [
		'segmentLength'
	],
	#category : 'SoccerTheory-Graphics-Bloc',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Bloc'
}

{ #category : 'instance creation' }
STBlocStrategicLineShape class >> newWithSegmentLength: length strategicX: xCoordinate color: aColor [
	"Answer a new vertical strategic line of given length, initial sliding xCoordinate and color aColor."

	^ self new
		  initializeWithSegmentLength: length
		  strategicX: xCoordinate
		  color: aColor
]

{ #category : 'private' }
STBlocStrategicLineShape >> addEndPoints [
	"Add my end point shapes."

	| topEndPoint bottomEndPoint |
	topEndPoint := self newTopEndPoint.
	topEndPoint position: (self endPointSize / 2) negated @ 0.

	bottomEndPoint := self newBottomEndPoint.
	bottomEndPoint position:
		(self endPointSize / 2) negated
		@ (segmentLength - self endPointSize).

	self clipChildren: false.
	self addChild: topEndPoint as: #topEndPoint.
	self addChild: bottomEndPoint as: #bottomEndPoint
]

{ #category : 'private' }
STBlocStrategicLineShape >> borderBuilder [
	"Answer my border builder."

	^BlBorderBuilder new 
]

{ #category : 'accessing' }
STBlocStrategicLineShape >> color: aColor [

	self border: (self borderBuilder
			 paint: aColor;
			 width: 1;
			 build).
	self childrenDo: [ :endPoint | endPoint background: aColor ]
]

{ #category : 'private' }
STBlocStrategicLineShape >> endPointSize [

	^ 12
]

{ #category : 'initialization' }
STBlocStrategicLineShape >> initializeWithSegmentLength: length strategicX: xCoordinate color: aColor [

	segmentLength := length.
	self geometry: (BlLineGeometry from: 0 @ 0 to: 0 @ segmentLength).
	self addEndPoints.
	self strategicXValue: xCoordinate color: aColor
]

{ #category : 'private' }
STBlocStrategicLineShape >> newBottomEndPoint [
	"Answer the BlElement that decorates the top segment end."

	self subclassResponsibility 
]

{ #category : 'private' }
STBlocStrategicLineShape >> newEndPointCirclePrototype [
	"Answer a circle prototype for building the top or the bottom end point."

	^ BlElement new
		  geometry: BlCircleGeometry new;
		  border: BlBorder empty;
		  extent: self endPointSize asPoint
]

{ #category : 'private' }
STBlocStrategicLineShape >> newEndPointTrianglePrototype [
	"Answer a triangle prototype for building the top or the bottom end point."

	^ BlElement new
		  geometry: BlTriangleGeometry new;
		  border: BlBorder empty;
		  extent: self endPointSize asPoint
]

{ #category : 'private' }
STBlocStrategicLineShape >> newTopEndPoint [
	"Answer the BlElement that decorates the top segment end."

	self subclassResponsibility 
]

{ #category : 'accessing' }
STBlocStrategicLineShape >> strategicXValue: xDeviceCoordinate color: aColor [
	"Set my current (sliding) device x-coordinate and my color."

	self position: xDeviceCoordinate @ 0.
	self color: aColor
]
