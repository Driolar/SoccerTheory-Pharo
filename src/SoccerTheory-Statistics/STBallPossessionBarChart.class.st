"
I render a bar chart composed by the following bar for each team:
- total possession share
- possession share while in numerical superiority
"
Class {
	#name : 'STBallPossessionBarChart',
	#superclass : 'STMatchChart',
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'initialization' }
STBallPossessionBarChart >> initializeChart [

	| team1Bar team2Bar |
	team1Bar := RSBarPlot new.
	team2Bar := RSBarPlot new
]
