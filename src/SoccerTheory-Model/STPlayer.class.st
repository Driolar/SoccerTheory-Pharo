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
		'number',
		'isCovered',
		'isOffside',
		'isGoalkeeper',
		'frame'
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
STPlayer class >> newWithPosition: aPoint team: aTeam frame: aPlay number: aSmallInteger [
	| player |
	player := self new.
	player
		initializeWithPosition: aPoint 
		team: aTeam
		frame: aPlay
		number: aSmallInteger.
	^ player
]

{ #category : 'accessing' }
STPlayer >> ball [

	^ frame ball
]

{ #category : 'accessing' }
STPlayer >> distanceToBall [
	"Answer my distance to the ball in meters."

	^ self position distanceTo: self ball position
]

{ #category : 'initialization' }
STPlayer >> initializeWithPosition: aPoint team: aSTTeam frame: aSTSoccerFrame number: aSmallInteger [
	position := aPoint.
	team := aSTTeam.
	frame := aSTSoccerFrame.
	number := aSmallInteger.
	isGoalkeeper := false.
]

{ #category : 'accessing' }
STPlayer >> isAttacking [
	^ team == frame owningTeam 
]

{ #category : 'accessing' }
STPlayer >> isBehindTheBall [

	^ team isTeamLeft
		  ifTrue: [ position x < self ball position x ]
		  ifFalse: [ position x > self ball position x ]
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
STPlayer >> isInOwnHalf [
	"Answer true if I am in my own pitch half, including the middle line. Answer false if not.
	This is relevant for the offside rule. Since 1907, a player in the own half (including the middle line) is never offside."

	^ team isTeamLeft
		  ifTrue: [ position x <= frame pitch middle x ]
		  ifFalse: [ position x >= frame pitch middle x ]
]

{ #category : 'accessing' }
STPlayer >> isMoreAdvancedThanCoordinateX: xCoordinate [

	team isTeamLeft
		ifTrue: [ ^ position x > xCoordinate ]
		ifFalse: [ ^ position x < xCoordinate ]
]

{ #category : 'accessing' }
STPlayer >> isOffside [

	^ isOffside
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
STPlayer >> position: aPoint [

	position := aPoint
]

{ #category : 'accessing' }
STPlayer >> shootingAngle [
	"I answer my shooting angle in degrees.
	I calculate it by the cosine rule, as illustrated in https://www.geogebra.org/m/war79au3#material/gz8zwy9e (german).
	Alternative calculations by tangens are shown in:
	- https://marclamberts.medium.com/correlation-between-shooting-angles-and-expected-goals-xg-68db6f2e6045
	- https://soccermatics.readthedocs.io/en/latest/lesson2/GeometryOfShooting.html"

	| distanceToUpperTargetGoalPost distanceToLowerTargetGoalPost |
	distanceToUpperTargetGoalPost := self position distanceTo: self targetGoalUpperPost.
	distanceToLowerTargetGoalPost := self position distanceTo: self targetGoalLowerPost.
	^ (distanceToUpperTargetGoalPost squared + distanceToLowerTargetGoalPost squared - frame pitch goalWidth squared
	   / (2 * distanceToUpperTargetGoalPost * distanceToLowerTargetGoalPost)) arcCos radiansToDegrees
]

{ #category : 'accessing' }
STPlayer >> targetGoalLowerPost [
	"I answer the Point where my target goal's lower post stands."

	^ self team isTeamLeft
		  ifTrue: [ frame pitch rightLowerGoalPost ]
		  ifFalse: [ frame pitch leftLowerGoalPost ]
]

{ #category : 'accessing' }
STPlayer >> targetGoalUpperPost [
	"I answer the Point where my target goal's upper post stands."

	^ self team isTeamLeft
		  ifTrue: [ frame pitch rightUpperGoalPost ]
		  ifFalse: [ frame pitch leftUpperGoalPost ]
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
