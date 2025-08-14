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

{ #category : 'naming' }
STClassicSoccerStrategy class >> offsideRuleName [

	^ 'classic offside rule'
]

{ #category : 'flagging' }
STClassicSoccerStrategy >> flagCoveredPlayers [
"With the classic offside rule, the defence zone is normally determined by the third defender from the back. But as soon as the ball moves behind him, the ball determines the defense line. As far as one defender at least is in the defence zone, all attacking players are covered."

	frame sortedDefendingFieldPlayers
		detect: [ :defender | defender isBehindTheBall ]
		ifFound:
			[ self attackingTeam players do: [ :player | player isCovered: true ] ]
		ifNone:
			[ "If no defender is in the defence zone, we must apply man covering." self flagManCoveredPlayers ]
]

{ #category : 'testing' }
STClassicSoccerStrategy >> isOffsidePlayer: aSTPlayer offsideX: xCoordinate [
	"Answer true if aSTPlayer is offside considering offside level at xCoordinate."

	^ aSTPlayer isInOwnHalf not and: [ "Since 1907, a player in the own half (including the middle line) is never offside."
		  aSTPlayer isMoreAdvancedThanCoordinateX: xCoordinate ]
]

{ #category : 'private' }
STClassicSoccerStrategy >> offsideX [

	^ self attackingTeam
		  ifNil: [ nil ]
		  ifNotNil: [
		  self offsideXAccordingToDefender: frame thirdDefenderFromTheBack ]
]

{ #category : 'accessing' }
STClassicSoccerStrategy >> xmlText [
	"Answer the String for my xml tag."

	^ '1866'
]
