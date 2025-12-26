"
I am the abstract class for match charts.
"
Class {
	#name : 'STMatchChart',
	#superclass : 'RSCompositeChart',
	#instVars : [
		'team1Extract',
		'team2Extract'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'instance creation' }
STMatchChart class >> team1Extract: aSTMatchEventExtract1 team2Extract: aSTMatchEventExtract2 [

	^ self new
		  initializeTeam1Extract: aSTMatchEventExtract1
		  team2Extract: aSTMatchEventExtract2
]

{ #category : 'private' }
STMatchChart >> gradientColorHighOfTeam1 [

	^ Color fromHexString: team1Extract teamGradientColorHigh
]

{ #category : 'private' }
STMatchChart >> gradientColorHighOfTeam2 [

	^ Color fromHexString: team2Extract teamGradientColorHigh
]

{ #category : 'private' }
STMatchChart >> gradientColorLowOfTeam1 [

	^ Color fromHexString: team1Extract teamGradientColorLow
]

{ #category : 'private' }
STMatchChart >> gradientColorLowOfTeam2 [

	^ Color fromHexString: team2Extract teamGradientColorLow
]

{ #category : 'initialization' }
STMatchChart >> initializeChart [

	self subclassResponsibility
]

{ #category : 'initialization' }
STMatchChart >> initializeTeam1Extract: aSTMatchEventExtract1 team2Extract: aSTMatchEventExtract2 [

	team1Extract := aSTMatchEventExtract1.
	team2Extract := aSTMatchEventExtract2.

	self initializeChart
]
