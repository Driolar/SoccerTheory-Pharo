"
I provide examples of STNumericalSuperiorityChart.
"
Class {
	#name : 'STFramePossessionTimelineChartExample',
	#superclass : 'Object',
	#category : 'SoccerTheory-Statistics-Examples',
	#package : 'SoccerTheory-Statistics-Examples'
}

{ #category : 'examples' }
STFramePossessionTimelineChartExample >> exampleNemesisVsWE2008 [

	<script: 'self new exampleNemesisVsWE2008 open'>
	| fixture |
	fixture := STMatchEventFixture newNemesisVsWE2008.
	^ STContinuousPossessionTimelineChart
		  team1Extract: fixture team1Extract
		  team2Extract: fixture team2Extract
]

{ #category : 'examples' }
STFramePossessionTimelineChartExample >> exampleOPU_hana_2DvsBrainstormers08 [

	<script: 'self new exampleOPU_hana_2DvsBrainstormers08 open'>
	| fixture |
	fixture := STMatchEventFixture newOPU_hana_2DvsBrainstormers08.
	^ STContinuousPossessionTimelineChart
		  team1Extract: fixture team1Extract
		  team2Extract: fixture team2Extract
]

{ #category : 'examples' }
STFramePossessionTimelineChartExample >> exampleWithoutNumericalSuperiority [

	<script: 'self new exampleWithoutNumericalSuperiority open'>
	| fixture |
	fixture := STMatchEventFixture newNemesisVsWE2008.
	fixture team1Extract numericalSuperiorityEndPoints removeAll.
	fixture team2Extract numericalSuperiorityEndPoints removeAll.
	^ STContinuousPossessionTimelineChart
		  team1Extract: fixture team1Extract
		  team2Extract: fixture team2Extract
]
