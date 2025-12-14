Class {
	#name : 'STDemoBasicNode',
	#superclass : 'Object',
	#instVars : [
		'item',
		'parent',
		'children'
	],
	#category : 'SoccerTheory-Graphics-Examples-Node',
	#package : 'SoccerTheory-Graphics-Examples',
	#tag : 'Node'
}

{ #category : 'as yet unclassified' }
STDemoBasicNode class >> withItem: anObject [

	^ self new item: anObject 
	
]

{ #category : 'adding' }
STDemoBasicNode >> addChild: aNode [ 
	
	self children add: aNode
]

{ #category : 'accessing' }
STDemoBasicNode >> children [ 
	^ children
]

{ #category : 'accessing' }
STDemoBasicNode >> children: anOrderedCollection [

	children :=anOrderedCollection 
]

{ #category : 'initialization' }
STDemoBasicNode >> initialize [

	super initialize.
	children := OrderedCollection new
]

{ #category : 'accessing' }
STDemoBasicNode >> item [ 
	^ item
]

{ #category : 'accessing' }
STDemoBasicNode >> item: anObject [

	item := anObject 
]

{ #category : 'accessing' }
STDemoBasicNode >> name [ 
	^ item name
]

{ #category : 'accessing' }
STDemoBasicNode >> parent [ 
	^ parent
]

{ #category : 'accessing' }
STDemoBasicNode >> parent: aNode [

	parent := aNode 
]
