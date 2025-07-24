"
I represent a single two-dimensional snapshot of a soccer game.
A pitch, a ball and two player teams are required for the game.
Furthermore, the game follows a concrete soccer strategy.


"
Class {
	#name : 'STSoccerFrame',
	#superclass : 'Object',
	#instVars : [
		'ball',
		'pitch',
		'teamLeft',
		'strategy',
		'teamRight'
	],
	#category : 'SoccerTheory-Model-Operate',
	#package : 'SoccerTheory-Model',
	#tag : 'Operate'
}

{ #category : 'instance creation' }
STSoccerFrame class >> newWithPitch: aPitch [

	^ self new initializeWithPitch: aPitch
]

{ #category : 'instance creation' }
STSoccerFrame class >> newWithTeamLeft: nameOfTeamLeft teamRight: nameOfTeamRight pitch: aSTPitch ball: aSTBall [
	^ self new initializeWithTeamLeft: nameOfTeamLeft teamRight: nameOfTeamRight pitch: aSTPitch ball: aSTBall
]

{ #category : 'accessing' }
STSoccerFrame >> announcer [ 
	"Answer the unique announcer (singleton)"

	^self ball announcer 
]

{ #category : 'accessing' }
STSoccerFrame >> ball [ 
	^ ball
]

{ #category : 'accessing' }
STSoccerFrame >> defendingTeam [
	self owningTeam ifNil: [ ^ nil ].
	
(self owningTeam == teamLeft) ifTrue:[
	^teamRight] ifFalse: [ ^teamLeft]
]

{ #category : 'initialization' }
STSoccerFrame >> initializeWithPitch: aSTPitch [

	self
		initializeWithTeamLeft: 'Team A'
		teamRight: 'Team B'
		pitch: aSTPitch
		ball: (STBall newWithPosition: aSTPitch middle)
]

{ #category : 'initialization' }
STSoccerFrame >> initializeWithTeamLeft: nameOfTeamLeft teamRight: nameOfTeamRight pitch: aSTPitch ball: aSTBall [

	teamLeft := STTeam newLeftToRight: nameOfTeamLeft.
	teamRight := STTeam newRightToLeft: nameOfTeamRight.
	pitch := aSTPitch.
	ball := aSTBall.
	self setNoOffsideSoccerStrategy
]

{ #category : 'notification' }
STSoccerFrame >> notifyCovering [ 
	"I tell the strategy to update covering"

	strategy updateCovering
]

{ #category : 'accessing' }
STSoccerFrame >> owningTeam [
	^ ball owningTeam 
]

{ #category : 'accessing' }
STSoccerFrame >> pitch [
	^ pitch
]

{ #category : 'accessing' }
STSoccerFrame >> secondDefenderFromTheBack [
	"I provide the second defending player from the back. The goalkeeper is considered."

	^ self sortedDefendingPlayers at: 2 ifAbsent: [ nil ]
]

{ #category : 'initialization' }
STSoccerFrame >> setAncientSoccerStrategy [
	"The play is to be ruled by the ancient soccer strategy"

	strategy := STAncientSoccerStrategy newWithFrame: self
]

{ #category : 'initialization' }
STSoccerFrame >> setClassicSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	strategy := STClassicSoccerStrategy newWithFrame: self
]

{ #category : 'initialization' }
STSoccerFrame >> setModernSoccerStrategy [
	"The play is to be ruled by the modern soccer strategy"

	strategy := STModernSoccerStrategy newWithFrame: self
]

{ #category : 'initialization' }
STSoccerFrame >> setNoOffsideSoccerStrategy [
	"The play is to be ruled with no offside."

	strategy := STNoOffsideSoccerStrategy newWithFrame: self
]

{ #category : 'accessing' }
STSoccerFrame >> sortedDefendingFieldPlayers [
	"I provide the defending field players sorted by x-position, ascending in the own attacking direction."

	^ self sortedDefendingPlayers reject: [ :player | player isGoalkeeper ]

]

{ #category : 'accessing' }
STSoccerFrame >> sortedDefendingPlayers [
	"I provide the defending players sorted by x-position, ascending in the own attacking direction."

	| sortedDefenders |
	sortedDefenders := self defendingTeam isTeamLeft
		                   ifTrue: [
			                   SortedCollection sortBlock: [ :p1 :p2 |
				                   p1 position x < p2 position x ] ]
		                   ifFalse: [
			                   SortedCollection sortBlock: [ :p1 :p2 |
				                   p1 position x > p2 position x ] ].
	sortedDefenders addAll: self defendingTeam players.
	^ sortedDefenders
]

{ #category : 'accessing' }
STSoccerFrame >> strategy [
	"Answer the STCommonSoccerStrategy"

	^ strategy
]

{ #category : 'accessing' }
STSoccerFrame >> teamLeft [
	^teamLeft 
]

{ #category : 'accessing' }
STSoccerFrame >> teamRight [
	^ teamRight
]

{ #category : 'accessing' }
STSoccerFrame >> thirdDefenderFromTheBack [
	"I provide the third defending player from the back. The goalkeeper is considered."

	^self sortedDefendingPlayers at: 3 ifAbsent: [nil]
]
