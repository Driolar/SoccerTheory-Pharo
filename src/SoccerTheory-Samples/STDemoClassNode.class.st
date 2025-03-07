Class {
	#name : 'STDemoClassNode',
	#superclass : 'STDemoBasicNode',
	#category : 'SoccerTheory-Samples-Node',
	#package : 'SoccerTheory-Samples',
	#tag : 'Node'
}

{ #category : 'accessing' }
STDemoClassNode >> icon [

	^ #class
]

{ #category : 'accessing' }
STDemoClassNode >> methods [ 
	^ item methods
]
