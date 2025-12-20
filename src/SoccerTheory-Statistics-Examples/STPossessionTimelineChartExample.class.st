"
I provide examples of STBallPossessionBarChart.
"
Class {
	#name : 'STPossessionTimelineChartExample',
	#superclass : 'Object',
	#category : 'SoccerTheory-Statistics-Examples',
	#package : 'SoccerTheory-Statistics-Examples'
}

{ #category : 'examples' }
STPossessionTimelineChartExample >> exampleNemesisVsWE2008 [

	<script: 'self new exampleNemesisVsWE2008 open'>
	| fixture |
	fixture := STMatchEventFixture newNemesisVsWE2008.
	^ STPossessionTimelineChart
		  team1Extract: fixture team1Extract
		  team2Extract: fixture team2Extract
]

{ #category : 'examples' }
STPossessionTimelineChartExample >> exampleOPU_hana_2DvsBrainstormers08 [

	<script: 'self new exampleOPU_hana_2DvsBrainstormers08 open'>
	| fixture |
	fixture := STMatchEventFixture newOPU_hana_2DvsBrainstormers08.
	^ STPossessionTimelineChart
		  team1Extract: fixture team1Extract
		  team2Extract: fixture team2Extract
]
