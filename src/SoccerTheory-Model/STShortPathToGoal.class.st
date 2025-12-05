"
I compute a favorable combination pass sequence from ball owner to goalgetter.

First, I compute the minimum team spanning tree thanks STTeamSpan.
Then, I compute the shortest path on this tree.
Source: Player nearest to the ball
Sink: Goalgetter, i.e. the player with the biggest shooting angle.

Players in offside are considered the same, it doesn't matter.
"
Class {
	#name : 'STShortPathToGoal',
	#superclass : 'Object',
	#instVars : [
		'teamSpan'
	],
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'instance creation' }
STShortPathToGoal class >> new [

	self shouldNotImplement
]

{ #category : 'instance creation' }
STShortPathToGoal class >> newOnTeam: aSTTeam [

	^ self basicNew initializeOnTeam: aSTTeam
]

{ #category : 'api' }
STShortPathToGoal >> ballOwner [
	"Answer the player in the team span nearest to the ball.
	The pass combination starts at this player."

	^ self playerNearestToBallAmong: teamSpan players
]

{ #category : 'api' }
STShortPathToGoal >> combinePath [
	"Answer the short combination path from ball owner to goalgetter as a LinkedList of STPlayers."

	| shortestPathAlgorithm |
	shortestPathAlgorithm := AIDijkstra new.
	shortestPathAlgorithm nodes: teamSpan players.
	shortestPathAlgorithm
		edges: (self doublePlayerPairs: teamSpan connect)
		from: #player1
		to: #player2
		weight: #distance.
	^ shortestPathAlgorithm runFrom: self ballOwner to: self goalgetter
]

{ #category : 'private' }
STShortPathToGoal >> doublePlayerPairs: undirectedPlayerPairs [
	"Answer the undirectedPlayerPairs augmented by the reverse for every undirectedPlayerPair.
	This is necessary for AIDijstra in case of undirected graphs."

	^ undirectedPlayerPairs
		  addAll: (undirectedPlayerPairs collect: [ :playerPair |
						   STPlayerPair
							   newPlayer1: playerPair player2
							   player2: playerPair player1 ]);
		  yourself
]

{ #category : 'api' }
STShortPathToGoal >> goalgetter [
	"Answer the player in the team span with the greatest chance to score.
	He is the last pass station and will shoot to goal."

	^ self playerWithGreatestShootingAngleAmong: teamSpan players
]

{ #category : 'initialization' }
STShortPathToGoal >> initializeOnTeam: aSTTeam [

	self initialize.
	teamSpan := STTeamSpan newOnTeam: aSTTeam
]

{ #category : 'private' }
STShortPathToGoal >> playerNearestToBallAmong: players [
	"Answer the player nearest to the ball among the given STPlayers."

	^ players detectMin: [ :player | player distanceToBall ]
]

{ #category : 'private' }
STShortPathToGoal >> playerWithGreatestShootingAngleAmong: players [
	"Answer the player with the greatest shooting angle among the given STPlayers."

	^ players detectMax: [ :player | player shootingAngle ]
]
