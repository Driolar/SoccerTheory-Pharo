"
I represent a soccer team.

I consist of all my players.
I know my name and my attack direction.
"
Class {
	#name : 'STTeam',
	#superclass : 'Object',
	#instVars : [
		'teamName',
		'players',
		'attackDirection',
		'color1',
		'color2'
	],
	#category : 'SoccerTheory-Model-Game',
	#package : 'SoccerTheory-Model',
	#tag : 'Game'
}

{ #category : 'instance creation' }
STTeam class >> newLeftToRight: aString [
	^ self new initializeLeftToRight: aString
]

{ #category : 'instance creation' }
STTeam class >> newRightToLeft: aString [
	^self new initializeRightToLeft: aString 
]

{ #category : 'accessing' }
STTeam >> addPlayer: aPlayer [
	players add: aPlayer
]

{ #category : 'accessing' }
STTeam >> attackDirection [
	^ attackDirection
]

{ #category : 'accessing' }
STTeam >> color1 [

	^ color1
]

{ #category : 'accessing' }
STTeam >> color2 [

	^ color2
]

{ #category : 'initialization' }
STTeam >> initialize [
	players := OrderedCollection new
]

{ #category : 'initialization' }
STTeam >> initializeLeftToRight: aString [
	teamName := aString.
	attackDirection := #toRight.
	color1 := '#0000FF'.
	color2 := '#00FFFF'
]

{ #category : 'initialization' }
STTeam >> initializeRightToLeft: aString [
	teamName := aString.
	attackDirection := #toLeft.
	color1 := '#FF00FF'.
	color2 := '#FF0000'
]

{ #category : 'accessing' }
STTeam >> isTeamLeft [

	"Answer true if the team attacks from left to right. Otherwise, answer false."

	^ attackDirection == #toRight
]

{ #category : 'accessing' }
STTeam >> jerseyGradient [
	"Answer the gradient for my field player jerseys."

	^ BlLinearGradientPaint horizontal
		  from: (Color colorFrom: self color1)
		  to: (Color colorFrom: self color2)
]

{ #category : 'accessing' }
STTeam >> nextFreeJerseyNumber [
	"Answer the next free jersey number for a new field player."

	| assignedNumbers candidateNumber |
	assignedNumbers := self players
		                   collect: [ :player | player jerseyNumber ]
		                   into: Set new.
	candidateNumber := 1. "Reserve number 1 for goalkeeper."
	[ candidateNumber := candidateNumber + 1 ] doWhileTrue: [
		assignedNumbers includes: candidateNumber ].
	^ candidateNumber
]

{ #category : 'accessing' }
STTeam >> playerWithJerseyNumber: aJerseyNumber [

	^ players
		  detect: [ :aPlayer | aPlayer jerseyNumber = aJerseyNumber ]
		  ifNone: [ nil ]
]

{ #category : 'accessing' }
STTeam >> players [
	^ players
]

{ #category : 'accessing' }
STTeam >> teamName [
	"Answer my team name."

	^teamName 
]
