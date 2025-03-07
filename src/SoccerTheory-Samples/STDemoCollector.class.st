Class {
	#name : 'STDemoCollector',
	#superclass : 'Object',
	#instVars : [
		'packageDict',
		'classDict',
		'pragma'
	],
	#category : 'SoccerTheory-Samples-Node',
	#package : 'SoccerTheory-Samples',
	#tag : 'Node'
}

{ #category : 'instance creation' }
STDemoCollector class >> collectClass: aClass [ 
	^ self new collectClass: aClass.
]

{ #category : 'instance creation' }
STDemoCollector class >> collectPackage: aPackage [

	^ self new collectPackage: aPackage
]

{ #category : 'as yet unclassified' }
STDemoCollector class >> collectPragma: aSymbol fromClass: aClass [

	^ self new
		  pragma: aSymbol;
		  collectClass: aClass 
]

{ #category : 'as yet unclassified' }
STDemoCollector class >> collectPragma: aSymbol fromPackage: aPackage [ 
	^ self new pragma: aSymbol; collectPackage: aPackage 
]

{ #category : 'accessing' }
STDemoCollector >> classes [
	^ classDict values
]

{ #category : 'instanceCreation' }
STDemoCollector >> collectClass: aClass [

	| node pragmas |
	pragmas := Pragma allNamed: pragma in: aClass.
	pragmas ifEmpty: [ ^ self ].
	node := self ensureClassFor: aClass.
	(pragmas asSortedCollection: [ :a :b |
		 a method displayString <= b method displayString ]) do: [ :prag |
		node addChild: (STDemoMethodNode new item: prag method) ]
]

{ #category : 'instanceCreation' }
STDemoCollector >> collectPackage: aRPackage [

	| node classes |
	classes := OrderedCollection new.
	aRPackage classes do: [ :class |
		| temp |
		self collectClass: class.
		temp := classDict at: class ifAbsent: [  ].
		temp ifNotNil: [ classes add: temp ] ].
	classes ifEmpty: [ ^ self ].
	node := self ensurePackageFor: aRPackage.
	classes do: [ :classNode | node addChild: classNode ]
]

{ #category : 'as yet unclassified' }
STDemoCollector >> collectPackages: anOrderedCollection [

	anOrderedCollection do: [ :each | self collectPackage: each ].
]

{ #category : 'as yet unclassified' }
STDemoCollector >> ensureClassFor: aClass [

	^ classDict at: aClass ifAbsentPut: [STDemoClassNode new item: aClass; yourself]
]

{ #category : 'as yet unclassified' }
STDemoCollector >> ensurePackageFor: aPackage [ 

	^ packageDict at: aPackage ifAbsentPut: [ STDemoPackageNode new item: aPackage; yourself]
]

{ #category : 'initialization' }
STDemoCollector >> initialize [
	super initialize.
	pragma := #demo.
	packageDict := IdentityDictionary new.
	classDict := IdentityDictionary new
]

{ #category : 'accessing' }
STDemoCollector >> packages [
	^ packageDict values
]

{ #category : 'accessing' }
STDemoCollector >> pragma: aString [ 
	pragma := aString
]
