"
I represent the Modern Soccer Strategy.

This strategy considers the modern offside rule dated 1925.
"
Class {
	#name : 'STModernSoccerStrategy',
	#superclass : 'STCommonSoccerStrategy',
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'flagging' }
STModernSoccerStrategy >> flagCoveredPlayers [
	"With the modern offside rule, there is no defender in the defence zone. The modern offside rule is strategically insuficient. Man covering must always be applied."

	self flagManCoveredPlayers
]

{ #category : 'flagging' }
STModernSoccerStrategy >> flagOffsidePlayers [

	| defenseLineX |
	defenseLineX := (frame secondDefenderFromTheBack notNil and: [
		                 frame secondDefenderFromTheBack isBehindTheBall ])
		                ifTrue: [ frame secondDefenderFromTheBack position x ]
		                ifFalse: [ frame ball position x ].
	self attackingTeam players do: [ :player |
		player isOffside: (player isInOwnHalf not and: [
				 player isMoreAdvancedThanCoordinateX: defenseLineX ]) ]
]
