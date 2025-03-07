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
STModernSoccerStrategy >> displayRule [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ 'Modern offside rule'
]

{ #category : 'flagging' }
STModernSoccerStrategy >> flagCoveredPlayers [
	"With the modern offside rule, there is no defender in the defence zone. The modern offside rule is strategically insuficient. Man covering must always be applied."

	self flagManCoveredPlayers
]

{ #category : 'flagging' }
STModernSoccerStrategy >> flagOffsidePlayers [
	| defenseLineX |
	defenseLineX := (play secondDefenderFromTheBack notNil
		and: [ play secondDefenderFromTheBack isBehindTheBall ])
		ifTrue: [ play secondDefenderFromTheBack position x ]
		ifFalse: [ play ball position x ].
	self attackingTeam players
		do:
			[ :player | player isOffside: (player isMoreAdvancedThanCoordinateX: defenseLineX) ]
]
