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

{ #category : 'accessing' }
STIndividualCoveragePair >> player1 [

	^ player1
]

{ #category : 'accessing' }
STIndividualCoveragePair >> player2 [

	^ player2
]
