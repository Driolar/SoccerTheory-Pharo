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

{ #category : 'naming' }
STModernSoccerStrategy class >> offsideRuleName [

	^ 'modern offside rule'
]

{ #category : 'accessing' }
STModernSoccerStrategy class >> xmlText [
	"Answer the String for my xml tag."

	^ '1925'
]

{ #category : 'flagging' }
STModernSoccerStrategy >> flagCoveredPlayers [
	"With the modern offside rule, there is no defender in the defence zone. The modern offside rule is strategically insuficient. Man coverage must always be applied."

	self flagManCoveredPlayers
]

{ #category : 'testing' }
STModernSoccerStrategy >> isOffsidePlayer: aSTPlayer offsideX: xCoordinate [
	"Answer true if aSTPlayer is offside considering offside level at xCoordinate."

	^ aSTPlayer isInOwnHalf not and: [
		  aSTPlayer isMoreAdvancedThanCoordinateX: xCoordinate ]
]

{ #category : 'private' }
STModernSoccerStrategy >> offsideX [

	^ self attackingTeam
		  ifNil: [ nil ]
		  ifNotNil: [
		  self offsideXAccordingToDefender: frame secondDefenderFromTheBack ]
]

{ #category : 'accessing' }
STModernSoccerStrategy >> xmlText [
	^ self class xmlText
]
