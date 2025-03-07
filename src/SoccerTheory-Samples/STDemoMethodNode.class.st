Class {
	#name : 'STDemoMethodNode',
	#superclass : 'STDemoBasicNode',
	#category : 'SoccerTheory-Samples-Node',
	#package : 'SoccerTheory-Samples',
	#tag : 'Node'
}

{ #category : 'execution' }
STDemoMethodNode >> execute [
	
	
	^ item methodClass new perform: item selector
]

{ #category : 'accessing' }
STDemoMethodNode >> icon [

	^ #glamorousGrayCircle
]

{ #category : 'accessing' }
STDemoMethodNode >> name [ 
	^ self selector
]

{ #category : 'accessing' }
STDemoMethodNode >> selector [ 
	^ item selector
]

{ #category : 'accessing' }
STDemoMethodNode >> sourceCode [ 
	^ item sourceCode
]
