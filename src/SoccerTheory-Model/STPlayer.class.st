"
I represent a soccer player.

I know my jersey number and my current position on the pitch.
I know the team I belong.
May be I am a goalkeeper.

I also know passively my two covering states: 
- isOffside 
- isCovered 
Both states are updated from outside.
"
Class {
	#name : 'STPlayer',
	#superclass : 'Object',
	#instVars : [
		'position',
		'team',
		'play',
		'number',
		'isCovered',
		'isOffside',
		'isGoalkeeper'
	],
	#classInstVars : [
		'isOffside',
		'isCovered'
	],
	#category : 'SoccerTheory-Model-Game',
	#package : 'SoccerTheory-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
STPlayer class >> newWithPosition: aPoint team: aTeam play: aPlay number: aSmallInteger [
	| player |
	player := self new.
	player
		initializeWithPosition: aPoint 
		team: aTeam
		play: aPlay
		number: aSmallInteger.
	^ player
]

{ #category : 'initialization' }
STPlayer >> initializeWithPosition: aPoint team: aTeam play: aPlay number: aSmallInteger [
	position := aPoint.
	team := aTeam.
	play := aPlay.
	number := aSmallInteger.
	isGoalkeeper := false.
]

{ #category : 'accessing' }
STPlayer >> isAttacking [
	^ team == play owningTeam 
]

{ #category : 'accessing' }
STPlayer >> isBehindTheBall [
	team attackDirection == #toRight
		ifTrue: [ ^ position x < play ball position x ]
		ifFalse: [ ^ position x > play ball position x ]
]

{ #category : 'accessing' }
STPlayer >> isCovered [
	^ isCovered
]

{ #category : 'accessing' }
STPlayer >> isCovered: aBoolean [
	isCovered := aBoolean
]

{ #category : 'accessing' }
STPlayer >> isGoalkeeper [
	^ isGoalkeeper
]

{ #category : 'accessing' }
STPlayer >> isMoreAdvancedThanBall [
	^self isMoreAdvancedThanCoordinateX: play ball position x
]

{ #category : 'accessing' }
STPlayer >> isMoreAdvancedThanCoordinateX: anXCoordinate [
	team attackDirection == #toRight
		ifTrue: [ ^ position x > anXCoordinate  ]
		ifFalse: [ ^ position x < anXCoordinate  ]
]

{ #category : 'accessing' }
STPlayer >> isOffside [
	^ isOffside notNil and: [ isOffside ]
]

{ #category : 'accessing' }
STPlayer >> isOffside: aBoolean [
	isOffside := aBoolean 
]

{ #category : 'accessing' }
STPlayer >> jerseyNumber [
	"Answer the number printed on the player's jersey."

	^ number
]

{ #category : 'setting' }
STPlayer >> makeGoalkeeper [
	isGoalkeeper := true
]

{ #category : 'accessing' }
STPlayer >> position [ 
	^ position
]

{ #category : 'accessing' }
STPlayer >> position: aPosition [
	position := aPosition
]

{ #category : 'accessing' }
STPlayer >> team [
	"Answer the STTeam where I belong."

	^ team
]

{ #category : 'accessing' }
STPlayer >> teamName [
	"Answer my team's name"

	^ team teamName
]
