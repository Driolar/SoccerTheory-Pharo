"
I represent the spatial relation between to team colleagues.
"
Class {
	#name : 'STPlayerPair',
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
STPlayerPair class >> new [

	self shouldNotImplement
]

{ #category : 'instance creation' }
STPlayerPair class >> newPlayer1: player1 player2: player2 [
	"Answer a new instance of me with the two given STPlayers."

	^ self basicNew initializePlayer1: player1 player2: player2
]

{ #category : 'converting' }
STPlayerPair >> asAssociation [

	^ self player1 -> self player2
]

{ #category : 'accessing' }
STPlayerPair >> distance [
	"Answer the distance between player 1 and 2."

	^ player1 position distanceTo: player2 position
]

{ #category : 'initialization' }
STPlayerPair >> initializePlayer1: playerOne player2: playerTwo [

	self initialize.
	player1 := playerOne.
	player2 := playerTwo
]

{ #category : 'accessing' }
STPlayerPair >> player1 [

	^ player1
]

{ #category : 'accessing' }
STPlayerPair >> player2 [

	^ player2
]
