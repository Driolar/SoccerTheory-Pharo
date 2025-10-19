"
I represent the ball used in a soccer match.

I know my current position on the pitch and the team possessing me, if any.

Furthermore, I provide the global announcer.
"
Class {
	#name : 'STBall',
	#superclass : 'Object',
	#instVars : [
		'position',
		'owningTeam',
		'gameAnnouncer'
	],
	#category : 'SoccerTheory-Model-Game',
	#package : 'SoccerTheory-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
STBall class >> newWithPosition: aPoint [
	^ self new initializeWithPosition: aPoint
]

{ #category : 'accessing' }
STBall >> gameAnnouncer [
	"Answer the unique global announcer (singleton)."

	gameAnnouncer ifNil: [ gameAnnouncer := Announcer new ].
	^ gameAnnouncer
]

{ #category : 'initialization' }
STBall >> initializeWithPosition: aPoint [

	position := aPoint
]

{ #category : 'accessing' }
STBall >> owningTeam [
	"Answer the STTeam in ball possession or nil if possession is neutral."

	^ owningTeam
]

{ #category : 'accessing' }
STBall >> owningTeam: aSTTeam [
	"Set the STTeam in ball possession. Nil means nobody's ball (neutral possession)."

	owningTeam := aSTTeam
]

{ #category : 'accessing' }
STBall >> position [
   ^position
]

{ #category : 'accessing' }
STBall >> position: aPoint [
	position := aPoint
]
