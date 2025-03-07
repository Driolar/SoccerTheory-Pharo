"
I represent the ball used in a soccer match.

I know my current position on the pitch and the team possessing me, if any.
"
Class {
	#name : 'STBall',
	#superclass : 'Object',
	#instVars : [
		'position',
		'owningTeam'
	],
	#classInstVars : [
		'position'
	],
	#category : 'SoccerTheory-Model-Game',
	#package : 'SoccerTheory-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
STBall class >> newWithPosition: aPoint [
	^ self new initializeWithPosition: aPoint
]

{ #category : 'initialization' }
STBall >> initializeWithPosition: aPoint [
	position := aPoint
]

{ #category : 'accessing' }
STBall >> owningTeam [
	^ owningTeam
]

{ #category : 'accessing' }
STBall >> owningTeam: anObject [
	owningTeam := anObject
]

{ #category : 'accessing' }
STBall >> position [
   ^position
]

{ #category : 'accessing' }
STBall >> position: aPoint [
	position := aPoint
]
