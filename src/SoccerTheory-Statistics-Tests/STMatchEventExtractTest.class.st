Class {
	#name : 'STMatchEventExtractTest',
	#superclass : 'TestCase',
	#instVars : [
		'extract'
	],
	#category : 'SoccerTheory-Statistics-Tests',
	#package : 'SoccerTheory-Statistics-Tests'
}

{ #category : 'running' }
STMatchEventExtractTest >> setUp [

	super setUp.
	extract := STMatchEventExtract new
]

{ #category : 'tests' }
STMatchEventExtractTest >> testNumericalSuperiorityFramesCount [

	extract numericalSuperiorityEndPoints: #(  ).
	self assert: extract countNumericalSuperiorityFrames equals: 0.

	extract numericalSuperiorityEndPoints: #( 1 1 ).
	self assert: extract countNumericalSuperiorityFrames equals: 1.

	extract numericalSuperiorityEndPoints: #( 1 5 9 20 ).
	self assert: extract countNumericalSuperiorityFrames equals: 17
]

{ #category : 'tests' }
STMatchEventExtractTest >> testPossessionFramesCount [

	extract possessionEndpoints: #(  ).
	self assert: extract countPossessionFrames equals: 0.

	extract possessionEndpoints: #( 1 1 ).
	self assert: extract countPossessionFrames equals: 1.

	extract possessionEndpoints: #( 1 5 9 20 ).
	self assert: extract countPossessionFrames equals: 17
]
