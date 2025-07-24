"
I set the classic soccer strategy to be the current strategy.
"
Class {
	#name : 'STClassicStrategyCommand',
	#superclass : 'STSoccerStrategyCommand',
	#category : 'SoccerTheory-Application-Commander',
	#package : 'SoccerTheory-Application',
	#tag : 'Commander'
}

{ #category : 'executing' }
STClassicStrategyCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	self gameCommander setClassicSoccerStrategy 
]

{ #category : 'initialization' }
STClassicStrategyCommand >> initialize [

	super initialize.
	self description: 'Set the classic offside rule'
]

{ #category : 'accessing' }
STClassicStrategyCommand >> strategyClass [
	"Answer my strategy class."

	^ STClassicSoccerStrategy
]
