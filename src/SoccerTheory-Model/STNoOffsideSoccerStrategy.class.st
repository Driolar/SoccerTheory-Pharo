"
I represent the no offside strategy.
"
Class {
	#name : 'STNoOffsideSoccerStrategy',
	#superclass : 'STCommonSoccerStrategy',
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'flagging' }
STNoOffsideSoccerStrategy >> flagCoveredPlayers [
	"With no offside rule, apply man covering as well."

	self flagManCoveredPlayers
]

{ #category : 'flagging' }
STNoOffsideSoccerStrategy >> flagOffsidePlayers [

	self attackingTeam players do: [ :player | player isOffside: false ]
]
