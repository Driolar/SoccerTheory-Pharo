"
I set the ancient soccer strategy to be the current strategy.
"
Class {
	#name : 'STAncientStrategyCommand',
	#superclass : 'STSoccerStrategyCommand',
	#category : 'SoccerTheory-Application-Commander',
	#package : 'SoccerTheory-Application',
	#tag : 'Commander'
}

{ #category : 'executing' }
STAncientStrategyCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	self gameCommander setAncientSoccerStrategy
]

{ #category : 'initialization' }
STAncientStrategyCommand >> initialize [

	super initialize.
	self
		name: 'Ancient offside rule';
		description: 'Set the ancient offside rule'
]

{ #category : 'accessing' }
STAncientStrategyCommand >> strategyClass [
	"Answer my strategy class."

	^STAncientSoccerStrategy 
]
