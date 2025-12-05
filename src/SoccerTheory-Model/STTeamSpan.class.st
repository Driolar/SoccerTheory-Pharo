"
I connect all players of a team by a minimum spanning tree.
The spanning tree gives an approach of connectivity, specially of pass opportunities.

Players in offside are considered the same, it doesn't matter.
"
Class {
	#name : 'STTeamSpan',
	#superclass : 'Object',
	#instVars : [
		'team'
	],
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'instance creation' }
STTeamSpan class >> new [

	self shouldNotImplement
]

{ #category : 'instance creation' }
STTeamSpan class >> newOnTeam: aSTTeam [

	^ self basicNew initializeOnTeam: aSTTeam
]

{ #category : 'api' }
STTeamSpan >> allPairs [
	"Answer all possible team player pairs."

	^ team players
		  inject: OrderedCollection new
		  into: [ :allPairs :player1 |
				  allPairs
					  addAll:
						  ((team players copyWithout: player1) collect: [ :player2 |
								   STPlayerPair newPlayer1: player1 player2: player2 ]);
					  yourself ]
]

{ #category : 'api' }
STTeamSpan >> connect [
	"Answer a Collection of STPlayerPair representing the minimum spanning tree that connects the team players."

	| algorithm |
	algorithm := AIKruskal new.
	algorithm nodes: team players.
	algorithm
		edges: self allPairs
		from: #player1
		to: #player2
		weight: #distance.
	^ algorithm run collect: [ :edge | edge model ]
]

{ #category : 'initialization' }
STTeamSpan >> initializeOnTeam: aSTTeam [

	self initialize.
	team := aSTTeam
]

{ #category : 'accessing' }
STTeamSpan >> players [
	"Answer the involved (node) players."

	^ team players
]
