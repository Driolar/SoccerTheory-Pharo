"
I set the modern soccer strategy to be the current strategy.
"
Class {
	#name : 'STModernStrategyCommand',
	#superclass : 'STSoccerStrategyCommand',
	#category : 'SoccerTheory-Application-Commander',
	#package : 'SoccerTheory-Application',
	#tag : 'Commander'
}

{ #category : 'executing' }
STModernStrategyCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	self gameCommander setModernSoccerStrategy
]

{ #category : 'initialization' }
STModernStrategyCommand >> initialize [

	super initialize.
	self description: 'Set the modern offside rule'
]

{ #category : 'accessing' }
STModernStrategyCommand >> strategyClass [
	"Answer my strategy class."

	^ STModernSoccerStrategy
]
