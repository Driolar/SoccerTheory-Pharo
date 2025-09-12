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
		'gradientColorHigh',
		'gradientColorLow'
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
STTeam >> addPlayer: aSTPlayer [

	players add: aSTPlayer
]

{ #category : 'accessing' }
STTeam >> attackDirection [
	^ attackDirection
]

{ #category : 'accessing' }
STTeam >> gradientColorHigh [
	"Answer the hexadecimal string for the high gradient color."

	^ gradientColorHigh
]

{ #category : 'accessing' }
STTeam >> gradientColorHigh: aString [
	"Set the hexadecimal string for the high gradient color."

	gradientColorHigh := aString
]

{ #category : 'accessing' }
STTeam >> gradientColorLow [
	"Answer the hexadecimal string for the low gradient color."

	^ gradientColorLow
]

{ #category : 'accessing' }
STTeam >> gradientColorLow: aString [
	"Set the hexadecimal string for the low gradient color."

	gradientColorLow := aString
]

{ #category : 'initialization' }
STTeam >> initialize [
	players := OrderedCollection new
]

{ #category : 'initialization' }
STTeam >> initializeLeftToRight: aString [
	teamName := aString.
	attackDirection := #toRight.
	gradientColorHigh := '#0000FF'. "blue"
	gradientColorLow := '#00FFFF' "aqua"
]

{ #category : 'initialization' }
STTeam >> initializeRightToLeft: aString [
	teamName := aString.
	attackDirection := #toLeft.
	gradientColorHigh := '#FF0000'. "red" 
	gradientColorLow := '#FF00FF' "fuchsia"
]

{ #category : 'accessing' }
STTeam >> isTeamLeft [

	"Answer true if the team attacks from left to right. Otherwise, answer false."

	^ attackDirection == #toRight
]

{ #category : 'accessing' }
STTeam >> jerseyGradient [
	"Answer the gradient for my field player jerseys."

	| gradientColorFrom gradientColorTo |
	gradientColorFrom := self isTeamLeft
		                     ifTrue: [ self gradientColorHigh ]
		                     ifFalse: [ self gradientColorLow ].
	gradientColorTo := self isTeamLeft
		                   ifTrue: [ self gradientColorLow ]
		                   ifFalse: [ self gradientColorHigh ].


	^ BlLinearGradientPaint horizontal
		  from: (Color colorFrom: gradientColorFrom)
		  to: (Color colorFrom: gradientColorTo)
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
STTeam >> playerWithJerseyNumber: aSmallInteger [

	^ players
		  detect: [ :aPlayer | aPlayer jerseyNumber = aSmallInteger ]
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

{ #category : 'accessing' }
STTeam >> xmlSideCode [

	^ self isTeamLeft
		  ifTrue: [ 'l' ]
		  ifFalse: [ 'r' ]
]
