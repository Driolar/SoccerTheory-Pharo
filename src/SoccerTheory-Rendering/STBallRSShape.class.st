"
I am a visual soccer ball whose model is STBall.

I visualize which one is the owning team.

Also I am draggable.
"
Class {
	#name : 'STBallRSShape',
	#superclass : 'RSCircle',
	#category : 'SoccerTheory-Rendering-Roassal',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
STBallRSShape class >> newForBall: aSTBall [

	^ self new initializeForBall: aSTBall
]

{ #category : 'accessing' }
STBallRSShape >> ball [
	"Answer the STBallRSShape"

	^ self model
]

{ #category : 'initialization' }
STBallRSShape >> initializeForBall: aSTBall [

	self
		size: 9;
		color: Color black;
		model: aSTBall;
		@ RSDraggable
]
