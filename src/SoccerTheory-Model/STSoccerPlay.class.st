"
I represent a soccer play.
The play is the running of the game in frame sequences. 
To play the game, a pitch, a ball and two teams are required.
Furthermore, the play follows a concrete soccer strategy.

According to the composite pattern, STSoccerPlay is an abstract class.
Its subclasses are STSoccerFrame and STSoccerSequence.


"
Class {
	#name : 'STSoccerPlay',
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
	#classInstVars : [
		'ball',
		'pitch',
		'teamA',
		'teamB',
		'strategy'
	],
	#category : 'SoccerTheory-Model-Operate',
	#package : 'SoccerTheory-Model',
	#tag : 'Operate'
}

{ #category : 'accessing' }
STSoccerPlay class >> announcer [
	"Answer the unique announcer (singleton)"

	UniqueAnnouncer ifNil: [ UniqueAnnouncer := Announcer new ].
	^ UniqueAnnouncer
]

{ #category : 'instance creation' }
STSoccerPlay class >> newWithPitch: aPitch [

	^ self new initializeWithPitch: aPitch
]

{ #category : 'instance creation' }
STSoccerPlay class >> newWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall [
	^ self new initializeWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall
]

{ #category : 'accessing' }
STSoccerPlay >> announcer [ 
	"Answer the unique announcer (singleton)"

	^self class announcer 
]

{ #category : 'accessing' }
STSoccerPlay >> ball [ 
	^ ball
]

{ #category : 'accessing' }
STSoccerPlay >> defendingTeam [
	self owningTeam ifNil: [ ^ nil ].
	
(self owningTeam == teamLeft) ifTrue:[
	^teamRight] ifFalse: [ ^teamLeft]
]

{ #category : 'initialization' }
STSoccerPlay >> initGoalkeeperForTeam: aTeam [
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
STSoccerPlay >> initialize [

	super initialize.
	self class announcer initialize
]

{ #category : 'initialization' }
STSoccerPlay >> initializeWithPitch: aPitch [

	self
		initializeWithTeamLeft: 'Team A'
		teamRight: 'Team B'
		pitch: aPitch
		ball: (STBall newWithPosition: aPitch middle)
]

{ #category : 'initialization' }
STSoccerPlay >> initializeWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall [

	teamLeft := STTeam newLeftToRight: aStringLeft.
	teamRight := STTeam newRightToLeft: aStringRight.
	pitch := aPitch.
	ball := aBall.
	self setNoOffsideSoccerStrategy
]

{ #category : 'notification' }
STSoccerPlay >> notifyCovering [ 
	"I tell the strategy to update covering"

	strategy updateCovering
]

{ #category : 'accessing' }
STSoccerPlay >> owningTeam [
	^ ball owningTeam 
]

{ #category : 'accessing' }
STSoccerPlay >> pitch [
	^ pitch
]

{ #category : 'accessing' }
STSoccerPlay >> secondDefenderFromTheBack [
	"I provide the second defending player from the back. The goalkeeper is considered."

	^ self sortedDefendingPlayers at: 2 ifAbsent: [ nil ]
]

{ #category : 'initialization' }
STSoccerPlay >> setAncientSoccerStrategy [
	"The play is to be ruled by the ancient soccer strategy"

	strategy := STAncientSoccerStrategy newWithPlay: self
]

{ #category : 'initialization' }
STSoccerPlay >> setClassicSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	strategy := STClassicSoccerStrategy newWithPlay: self
]

{ #category : 'initialization' }
STSoccerPlay >> setModernSoccerStrategy [
	"The play is to be ruled by the modern soccer strategy"

	strategy := STModernSoccerStrategy newWithPlay: self
]

{ #category : 'initialization' }
STSoccerPlay >> setNoOffsideSoccerStrategy [
	"The play is to be ruled with no offside."

	strategy := STNoOffsideSoccerStrategy newWithPlay: self
]

{ #category : 'accessing' }
STSoccerPlay >> sortedDefendingFieldPlayers [
	"I provide the defending field players sorted by x-position, ascending in the own attacking direction."

	^ self sortedDefendingPlayers reject: [ :player | player isGoalkeeper ]

]

{ #category : 'accessing' }
STSoccerPlay >> sortedDefendingPlayers [
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
STSoccerPlay >> strategy [ 
	^ strategy
]

{ #category : 'accessing' }
STSoccerPlay >> teamLeft [
	^teamLeft 
]

{ #category : 'accessing' }
STSoccerPlay >> teamRight [
	^ teamRight
]

{ #category : 'accessing' }
STSoccerPlay >> thirdDefenderFromTheBack [
	"I provide the third defending player from the back. The goalkeeper is considered."

	^self sortedDefendingPlayers at: 3 ifAbsent: [nil]
]
