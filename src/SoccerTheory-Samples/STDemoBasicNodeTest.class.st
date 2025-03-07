Class {
	#name : 'STDemoBasicNodeTest',
	#superclass : 'TestCase',
	#instVars : [
		'class',
		'class2'
	],
	#category : 'SoccerTheory-Samples-NodeTests',
	#package : 'SoccerTheory-Samples',
	#tag : 'NodeTests'
}

{ #category : 'tests' }
STDemoBasicNodeTest >> testEnsureClassForWithDifferentClass [

	| demo |
	demo := STDemoCollector new.
	class := demo ensureClassFor: STDemoData.
	class2 := demo ensureClassFor: STDemoData2.
	self deny: class == class2
]

{ #category : 'tests' }
STDemoBasicNodeTest >> testEnsureClassForWithSameClass [

	| demo |
	demo := STDemoCollector new.
	class := demo ensureClassFor: STDemoData.
	class2 := demo ensureClassFor: STDemoData.
	self assert: class == class2
]

{ #category : 'tests' }
STDemoBasicNodeTest >> testEnsurePackageForWithSamePackage [

	| demo package package2 |
	demo := STDemoCollector new.
	package := demo ensurePackageFor: 'Bloc-Demo'.
	package2 := demo ensurePackageFor: 'Bloc-Demo'.
	self assert: package == package2
]

{ #category : 'tests' }
STDemoBasicNodeTest >> testOneClassWithDifferentPragma [

	| collector elt1 classNode |
	
	collector := STDemoCollector new.
	collector pragma: #demo2.
	collector collectClass: STDemoData.
	classNode := collector classes first.
	elt1 := classNode children first.
	self assert: elt1 class equals: STDemoMethodNode.
	
	
]

{ #category : 'tests' }
STDemoBasicNodeTest >> testOneClassWithTwoMethodsHasTwoNodes [

	| collector elt1 elt2 classNode |
	
	collector := STDemoCollector new.
	collector collectClass: STDemoData.
	classNode := collector classes first.
	elt1 := classNode children first.
	self assert: elt1 class equals: STDemoMethodNode.
	elt2 := classNode children second.
	self assert: elt2 class equals: STDemoMethodNode.
	
	
	
]

{ #category : 'tests' }
STDemoBasicNodeTest >> testOneClassWithoutPragma [

	| collector  |
	
	collector := STDemoCollector new.
	collector pragma: #blabla.
	collector collectClass: STDemoData.
	self assert: collector classes isEmpty
]

{ #category : 'tests' }
STDemoBasicNodeTest >> testOnePackageWithTwoClassesHasTwoNodes [

	| collector packages |
	collector := STDemoCollector new
		             pragma: #demo;
		             collectPackage:
			             (self class packageOrganizer packageNamed: #'Bloc-Demo').
	packages := collector packages.
	self assert: packages size equals: 1.

	self assert: packages first class equals: STDemoPackageNode.
	self assert: packages first children size equals: 2.
	self
		assert: packages first children first class
		equals: STDemoClassNode
]

{ #category : 'tests' }
STDemoBasicNodeTest >> testOnePackageWithTwoClassesHasTwoNodesWithSample2 [

	| collector packages |
	collector := STDemoCollector new
		             pragma: #demo2;
		             collectPackage:
			             (self class packageOrganizer packageNamed: #'Bloc-Demo').
	packages := collector packages.
	self assert: packages size equals: 1.

	self assert: packages first class equals: STDemoPackageNode .
	self assert: packages first children size equals: 1
]
