"
I am the convenience superclass for all the commands of the Soccer Theory application.
"
Class {
	#name : 'STSoccerStrategyCommand',
	#superclass : 'CmCommand',
	#category : 'SoccerTheory-Application-Commander',
	#package : 'SoccerTheory-Application',
	#tag : 'Commander'
}

{ #category : 'executing' }
STSoccerStrategyCommand >> execute [

	self subclassResponsibility
]

{ #category : 'accessing' }
STSoccerStrategyCommand >> gameCommander [
	"Answer the application's game commander."

	^ self context gameCommander
]

{ #category : 'initialization' }
STSoccerStrategyCommand >> initialize [

	super initialize.
	self name: self strategyClass offsideRuleName
]

{ #category : 'accessing' }
STSoccerStrategyCommand >> strategyClass [
	"Answer my strategy class."

	self subclassResponsibility
]
