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
	"With no offside rule, apply man coverage as well."

	self flagManCoveredPlayers
]

{ #category : 'testing' }
STNoOffsideSoccerStrategy >> isOffsidePlayer: aSTPlayer offsideX: xCoordinate [
	"Answer true if aSTPlayer is offside considering offside level at xCoordinate."

	^ false
]

{ #category : 'private' }
STNoOffsideSoccerStrategy >> offsideX [
	"Answer nil since offside rule does not exist."

	^ nil
]
