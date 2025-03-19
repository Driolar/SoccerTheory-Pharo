"
I represent the Classic Soccer Strategy.

This strategy is based on the classic rule dated 1866.
"
Class {
	#name : 'STClassicSoccerStrategy',
	#superclass : 'STCommonSoccerStrategy',
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'flagging' }
STClassicSoccerStrategy >> flagCoveredPlayers [
"With the classic offside rule, the defence zone is normally determined by the third defender from the back. But as soon as the ball moves behind him, the ball determines the defense line. As far as one defender at least is in the defence zone, all attacking players are covered."

	play sortedDefendingFieldPlayers
		detect: [ :defender | defender isBehindTheBall ]
		ifFound:
			[ self attackingTeam players do: [ :player | player isCovered: true ] ]
		ifNone:
			[ "If no defender is in the defence zone, we must apply man covering." self flagManCoveredPlayers ]
]

{ #category : 'flagging' }
STClassicSoccerStrategy >> flagOffsidePlayers [

	| defenseLineX |
	defenseLineX := (play thirdDefenderFromTheBack notNil and: [
		                 play thirdDefenderFromTheBack isBehindTheBall ])
		                ifTrue: [ play thirdDefenderFromTheBack position x ]
		                ifFalse: [ play ball position x ].
	self attackingTeam players do: [ :player |
		player isOffside: (player isInOwnHalf not and: [
				 player isMoreAdvancedThanCoordinateX: defenseLineX ]) ]
]
