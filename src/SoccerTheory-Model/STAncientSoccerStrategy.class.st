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

	frame sortedDefendingFieldPlayers
		detect: [ :defender | defender isBehindTheBall ]
		ifFound:
			[ self attackingTeam players do: [ :player | player isCovered: true ] ]
		ifNone: [ "If no defender is in the defence zone, we must apply man coverage." self flagManCoveredPlayers ]
]

{ #category : 'accessing' }
STAncientSoccerStrategy >> isAncient [
	"Answer that I am the ancient soccer strategy."

	^ true
]

{ #category : 'testing' }
STAncientSoccerStrategy >> isOffsidePlayer: aSTPlayer offsideX: xCoordinate [
	"Answer true if aSTPlayer is offside considering offside level at xCoordinate."

	^ aSTPlayer isMoreAdvancedThanCoordinateX: xCoordinate
]

{ #category : 'private' }
STAncientSoccerStrategy >> offsideX [
	"Answer the current offside line's x-coordinate. For the ancient rule, this is by rule definition the ball x-coordinate."

	^ self attackingTeam
		  ifNil: [ nil ]
		  ifNotNil: [ frame ball position x ]
]
