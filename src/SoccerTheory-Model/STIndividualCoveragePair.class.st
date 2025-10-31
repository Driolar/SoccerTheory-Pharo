"
I am a pair of field players, each one belonging to another team.

I am responsible for providing the pair's coverage weight.
In a first approach, the weight is the distance to each other.
Thus for this first approach, it doesn't matter which team is ever attacking.  
"
Class {
	#name : 'STIndividualCoveragePair',
	#superclass : 'Object',
	#instVars : [
		'player1',
		'player2'
	],
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'instance creation' }
STIndividualCoveragePair class >> new [

	self shouldNotImplement
]

{ #category : 'instance creation' }
STIndividualCoveragePair class >> newPlayer1: player1 player2: player2 [
	"Answer a new instance of me with the two given STPlayers."

	^ self basicNew initializePlayer1: player1 player2: player2
]

{ #category : 'accessing' }
STIndividualCoveragePair >> coverageRotation [
	"Answer the radians that the defending (covering) player must rotate in order to point directly towards her opponent."

	| x y arctan |
	x := player2 position x - player1 position x.
	y := player2 position y - player1 position y.
	arctan := y arcTan: x.
	^ arctan
]

{ #category : 'accessing' }
STIndividualCoveragePair >> defendingPlayer [
	"Answer the defending player or nil if no team is possessing the ball."

	player1 isAttacking ifTrue: [ ^ player2 ].
	player2 isAttacking ifTrue: [ ^ player1 ].
	^ nil
]

{ #category : 'accessing' }
STIndividualCoveragePair >> distance [
	"Answer the distance between player 1 and 2."

	^ player1 position distanceTo: player2 position
]

{ #category : 'initialization' }
STIndividualCoveragePair >> initializePlayer1: playerOne player2: playerTwo [

	self initialize.
	player1 := playerOne.
	player2 := playerTwo
]

{ #category : 'testing' }
STIndividualCoveragePair >> isMisplaced [
	"Answer true if the players are misplaced to cover each other:
	Each of both players is nearer to the opponent goal line than his respective opponent.
	In such a situation, most possibly the one cannot hinder the other when needing to defend."

	^ self player1 isMoreAdvancedThanCoordinateX: self player2 position x
]

{ #category : 'accessing' }
STIndividualCoveragePair >> player1 [

	^ player1
]

{ #category : 'accessing' }
STIndividualCoveragePair >> player2 [

	^ player2
]
