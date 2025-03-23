"
I am a line as long as the play field width, perpendicular to the play field length (x-axis) and relevant to the soccer strategy.

The form of my vertices depends on my subclass.

I am slided by the logic of the concrete soccer strategy along the x-axis, parallel to the goal lines.
"
Class {
	#name : 'STStrategicLineShape',
	#superclass : 'BlElement',
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STStrategicLineShape class >> newWithBottomEndPoint: aEndPoint color: aColor [
	"Answer a new strategic line initially with bottom end point at aEndPoint and color aColor."

	^self new initializeWithBottomEndPoint: aEndPoint color: aColor 
]

{ #category : 'accessing' }
STStrategicLineShape >> bottomEndPoint: aEndPoint [

	| startPoint |
	"Perpendicular to x-axis"
	startPoint := Point x: aEndPoint x y: 0.

	self geometry: (BlLineGeometry from: startPoint to: aEndPoint)
]

{ #category : 'accessing' }
STStrategicLineShape >> color: aColor [

	self border: (BlBorder paint: aColor width: 1)
]

{ #category : 'initialization' }
STStrategicLineShape >> initializeWithBottomEndPoint: aEndPoint color: aColor [

	self bottomEndPoint: aEndPoint.
	self color: aColor
]
