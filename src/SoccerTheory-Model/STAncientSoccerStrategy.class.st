"
I represent the Ancient Soccer Strategy.

This strategy is based on the ancient offside rule dated 1863.
"
Class {
	#name : 'STAncientSoccerStrategy',
	#superclass : 'STCommonSoccerStrategy',
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'flagging' }
STAncientSoccerStrategy >> flagCoveredPlayers [
	"With the ancient offside rule, the defence zone is always determined by the ball position.
	As far as one defender at least is in the defence zone, all attacking players are covered."

	play sortedDefendingFieldPlayers
		detect: [ :defender | defender isBehindTheBall ]
		ifFound:
			[ self attackingTeam players do: [ :player | player isCovered: true ] ]
		ifNone: [ "If no defender is in the defence zone, we must apply man covering." self flagManCoveredPlayers ]
]

{ #category : 'flagging' }
STAncientSoccerStrategy >> flagOffsidePlayers [
	self attackingTeam players
		do: [ :player | player isOffside: player isMoreAdvancedThanBall ]
]
