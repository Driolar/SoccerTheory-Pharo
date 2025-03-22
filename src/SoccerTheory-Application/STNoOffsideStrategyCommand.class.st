"
I set the no offside soccer strategy to be the current strategy.
"
Class {
	#name : 'STNoOffsideStrategyCommand',
	#superclass : 'STSoccerStrategyCommand',
	#category : 'SoccerTheory-Application-Commander',
	#package : 'SoccerTheory-Application',
	#tag : 'Commander'
}

{ #category : 'executing' }
STNoOffsideStrategyCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."

	self gameCommander setNoOffsideSoccerStrategy
]

{ #category : 'initialization' }
STNoOffsideStrategyCommand >> initialize [

	super initialize.
	self
		name: 'no offside rule';
		description: 'Set no offside rule'
]

{ #category : 'accessing' }
STNoOffsideStrategyCommand >> strategyClass [
	"Answer my strategy class."

	^ STNoOffsideSoccerStrategy
]
