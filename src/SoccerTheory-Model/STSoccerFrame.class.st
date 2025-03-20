"
I represent a single two-dimensional snapshot of a soccer game.
A pitch, a ball and two player teams are required for the game.
Furthermore, the play follows a concrete soccer strategy.

The class STSoccerSequence plays a coherent sequence of frames.


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
	#classVars : [
		'UniqueAnnouncer'
	],
	#category : 'SoccerTheory-Model-Operate',
	#package : 'SoccerTheory-Model',
	#tag : 'Operate'
}

{ #category : 'accessing' }
STSoccerFrame class >> announcer [
	"Answer the unique announcer (singleton)"

	UniqueAnnouncer ifNil: [ UniqueAnnouncer := Announcer new ].
	^ UniqueAnnouncer
]

{ #category : 'instance creation' }
STSoccerFrame class >> newWithPitch: aPitch [

	^ self new initializeWithPitch: aPitch
]

{ #category : 'instance creation' }
STSoccerFrame class >> newWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall [
	^ self new initializeWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall
]

{ #category : 'accessing' }
STSoccerFrame >> announcer [ 
	"Answer the unique announcer (singleton)"

	^self class announcer 
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
STSoccerFrame >> initGoalkeeperForTeam: aTeam [
	| keeper |
	keeper := STPlayer
		newWithPosition:
			(Point
				x: (pitch goalLineForDirection: aTeam attackDirection)
				y: pitch middle y)
		team: aTeam
		play: self
		number: 1.
	keeper makeGoalkeeper.
	aTeam addPlayer: keeper.
	^ keeper
]

{ #category : 'initialization' }
STSoccerFrame >> initialize [

	super initialize.
	self class announcer initialize
]

{ #category : 'initialization' }
STSoccerFrame >> initializeWithPitch: aPitch [

	self
		initializeWithTeamLeft: 'Team A'
		teamRight: 'Team B'
		pitch: aPitch
		ball: (STBall newWithPosition: aPitch middle)
]

{ #category : 'initialization' }
STSoccerFrame >> initializeWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall [

	teamLeft := STTeam newLeftToRight: aStringLeft.
	teamRight := STTeam newRightToLeft: aStringRight.
	pitch := aPitch.
	ball := aBall.
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

	strategy := STAncientSoccerStrategy newWithPlay: self
]

{ #category : 'initialization' }
STSoccerFrame >> setClassicSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	strategy := STClassicSoccerStrategy newWithPlay: self
]

{ #category : 'initialization' }
STSoccerFrame >> setModernSoccerStrategy [
	"The play is to be ruled by the modern soccer strategy"

	strategy := STModernSoccerStrategy newWithPlay: self
]

{ #category : 'initialization' }
STSoccerFrame >> setNoOffsideSoccerStrategy [
	"The play is to be ruled with no offside."

	strategy := STNoOffsideSoccerStrategy newWithPlay: self
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
	sortedDefenders := self defendingTeam attackDirection == #toRight
		ifTrue: [ SortedCollection
				sortBlock: [ :p1 :p2 | p1 position x < p2 position x ] ]
		ifFalse: [ SortedCollection
				sortBlock: [ :p1 :p2 | p1 position x > p2 position x ] ].
			sortedDefenders
		addAll: self defendingTeam players.
	^ sortedDefenders
]

{ #category : 'accessing' }
STSoccerFrame >> strategy [ 
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
