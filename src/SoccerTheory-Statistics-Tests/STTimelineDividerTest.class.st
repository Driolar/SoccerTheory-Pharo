Class {
	#name : 'STTimelineDividerTest',
	#superclass : 'TestCase',
	#instVars : [
		'separator'
	],
	#category : 'SoccerTheory-Statistics-Tests',
	#package : 'SoccerTheory-Statistics-Tests'
}

{ #category : 'running' }
STTimelineDividerTest >> setUp [

	super setUp.

	separator := STTimelineDivider
		             from: 1
		             to: 2000
		             numberOfSubIntervals: 2
]

{ #category : 'tests' }
STTimelineDividerTest >> testPeriodRanges [

	self
		assert: separator periodRanges
		equals: #( #( 1 1000 ) #( 1001 2000 ) )
]

{ #category : 'tests' }
STTimelineDividerTest >> testSplitTimeline [

	self
		assert: (separator divideTimeline: #(  ))
		equals: #( #(  ) #(  ) ).

	self
		assert: (separator divideTimeline: #( 500 1001 ))
		equals: #( #( 500 1000 ) #( 1001 1001 ) )
]
