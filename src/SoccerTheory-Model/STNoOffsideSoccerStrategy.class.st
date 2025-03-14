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
STNoOffsideSoccerStrategy >> displayRule [
	^ 'No offside rule'
]

{ #category : 'flagging' }
STNoOffsideSoccerStrategy >> flagCoveredPlayers [
	"With no offside rule, apply man covering."

	self flagManCoveredPlayers
]

{ #category : 'flagging' }
STNoOffsideSoccerStrategy >> flagOffsidePlayers [
	"Do nothing."

	
]
