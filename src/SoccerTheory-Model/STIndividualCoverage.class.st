"
I compute an individual coverage (aka (wo)man-to-(wo)man coverage) for the defending team.
This fundamental modern soccer strategy consists in assigning a different opponent to each player of the defending team. 
Each defending player orients his position towards his opponent in order to guarantee that, if his opponent gets the ball, he can hinder him before he can either score or destabilise the defence.

The two teams are considered as a bipartite graph with the players as nodes and the possible coverage relations as weighted edges.
With the help of a greedy graph matching algorithm, I try to pair each defending player to a different attacking player optimally.
I approximate the minimum sum of pair distances as a rough weighting-criterium.
"
Class {
	#name : 'STIndividualCoverage',
	#superclass : 'Object',
	#instVars : [
		'frame'
	],
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'instance creation' }
STIndividualCoverage class >> new [

	self shouldNotImplement
]

{ #category : 'instance creation' }
STIndividualCoverage class >> newWithFrame: aSTSoccerFrame [

	^ self basicNew initializeWithFrame: aSTSoccerFrame
]

{ #category : 'private' }
STIndividualCoverage >> completeBipartitePairs [
	"Answer the STIndividualCoveragePairs generated for the complete bipartite graph."

	^ self leftRelevantPlayers
		  inject: OrderedCollection new
		  into: [ :playerPairs :playerLeft |
				  playerPairs
					  addAll: (self rightRelevantPlayers collect: [ :playerRight |
								   STIndividualCoveragePair
									   newPlayer1: playerLeft
									   player2: playerRight ]);
					  yourself ]
]

{ #category : 'api' }
STIndividualCoverage >> cover [
	"Calculate the individual coverage and return the STIndividualCoveragePairs."

	| matchingAlgorithm |
	matchingAlgorithm := AIGraphMatchingAlgorithm newMinimumWeighted.
	matchingAlgorithm nodes: self relevantPlayers.
	matchingAlgorithm
		edges: self completeBipartitePairs
		from: #player1
		to: #player2
		weight: #distance.
	^ matchingAlgorithm run
]

{ #category : 'initialization' }
STIndividualCoverage >> initializeWithFrame: aSTSoccerFrame [

	self initialize.
	frame := aSTSoccerFrame
]

{ #category : 'private' }
STIndividualCoverage >> leftRelevantPlayers [
	"Answer all the field players of team left relevant for coverage."

	^ self relevantPlayersInTeam: frame teamLeft
]

{ #category : 'private' }
STIndividualCoverage >> relevantPlayers [
	"Answer all the players relevant for coverage."

	^ self leftRelevantPlayers
		  addAll: self rightRelevantPlayers;
		  yourself
]

{ #category : 'private' }
STIndividualCoverage >> relevantPlayersInTeam: aSTTeam [
	"Answer all the players of aSTTeam relevant for coverage."

	| fieldPlayers |
	fieldPlayers := aSTTeam players reject: [ :player |
		                player isGoalkeeper ].
	^ fieldPlayers reject: [ :player |
		  player isAttacking and: [ player isOffside ] ]
]

{ #category : 'private' }
STIndividualCoverage >> rightRelevantPlayers [
	"Answer all the field players of team right relevant for coverage."

	^ self relevantPlayersInTeam: frame teamRight
]
