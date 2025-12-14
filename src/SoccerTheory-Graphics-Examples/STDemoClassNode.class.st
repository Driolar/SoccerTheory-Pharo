Class {
	#name : 'STDemoClassNode',
	#superclass : 'STDemoBasicNode',
	#category : 'SoccerTheory-Graphics-Examples-Node',
	#package : 'SoccerTheory-Graphics-Examples',
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
