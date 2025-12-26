"
I render a bar chart composed by the following bar for each team:
- total possession share
- possession share while in numerical superiority
"
Class {
	#name : 'STPossessionBarChart',
	#superclass : 'STMatchChart',
	#instVars : [
		'totalPossessionPlot',
		'numericalSuperiorityPlot',
		'totalOfFrames'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'building' }
STPossessionBarChart >> addBarLabels [

	self labelPossessionBars.
	(team1Extract numericalSuperiorityEndPoints notEmpty or: [
		 team2Extract numericalSuperiorityEndPoints notEmpty ]) ifTrue: [
		self labelNumericalSuperiorityBars ]
]

{ #category : 'building' }
STPossessionBarChart >> build [

	super build.
	self colorBars.
	self addBarLabels
]

{ #category : 'building' }
STPossessionBarChart >> buildLegend1 [

	self buildLegendFor: team1Extract
]

{ #category : 'building' }
STPossessionBarChart >> buildLegend2 [

	self buildLegendFor: team2Extract
]

{ #category : 'building' }
STPossessionBarChart >> buildLegendFor: aSTMatchEventExtract [

	| legend |
	legend := RSLegend new.
	legend
		text: 'Total ball possession share'
		withBoxColor: aSTMatchEventExtract teamGradientColorLow.
	team1Extract numericalSuperiorityEndPoints notEmpty ifTrue: [
			legend
				text: 'possession while numerical superiority'
				withBoxColor: aSTMatchEventExtract teamGradientColorHigh ].

	legend beFixedWithTitle: aSTMatchEventExtract teamName.
	legend container: self canvas.
	legend build
]

{ #category : 'building' }
STPossessionBarChart >> colorBars [

	totalPossessionPlot bars first color: self gradientColorLowOfTeam1.
	totalPossessionPlot bars second color: self gradientColorLowOfTeam2.
	numericalSuperiorityPlot bars first color:
		self gradientColorHighOfTeam1.
	numericalSuperiorityPlot bars second color:
		self gradientColorHighOfTeam2
]

{ #category : 'initialization' }
STPossessionBarChart >> endScoreLabel [

	^ team1Extract teamName , ' '
	  , team1Extract goalMoments size asString , ' : '
	  , team2Extract goalMoments size asString , ' '
	  , team2Extract teamName
]

{ #category : 'initialization' }
STPossessionBarChart >> initializeChart [

	totalOfFrames := team1Extract countPossessionFrames
	                 + team2Extract countPossessionFrames.

	self
		title: 'Ball Possession Share';
		padding: 30.

	totalPossessionPlot := RSBarPlot new.
	totalPossessionPlot y: (Array
			 with: team1Extract countPossessionFrames
			 with: team2Extract countPossessionFrames).
	numericalSuperiorityPlot := RSBarPlot new.
	numericalSuperiorityPlot y: (Array
			 with: team1Extract countNumericalSuperiorityFrames
			 with: team2Extract countNumericalSuperiorityFrames).
	self
		add: totalPossessionPlot;
		add: numericalSuperiorityPlot.

	self removeHorizontalTicks.
	self verticalTick integer.
	self ylabel: 'Number of frames'.
	self xlabel: self endScoreLabel.

	self
		buildLegend1;
		buildLegend2
]

{ #category : 'building' }
STPossessionBarChart >> labelNumericalSuperiorityBars [

	numericalSuperiorityPlot bars first @ (RSLabeled new
		 text: [ self percentLabelOfNumericalSuperiorityFor: team1Extract ];
		 lowColor: Color black;
		 locationDo: [ :loc | loc left ]).
	numericalSuperiorityPlot bars second @ (RSLabeled new
		 text: [ self percentLabelOfNumericalSuperiorityFor: team2Extract ];
		 lowColor: Color black;
		 locationDo: [ :loc | loc right ])
]

{ #category : 'building' }
STPossessionBarChart >> labelPossessionBars [

	totalPossessionPlot bars first @ (RSLabeled new
		 text: [ self percentLabelOfPossessionFor: team1Extract ];
		 lowColor: Color black;
		 locationDo: [ :loc | loc above ]).
	totalPossessionPlot bars second @ (RSLabeled new
		 text: [ self percentLabelOfPossessionFor: team2Extract ];
		 lowColor: Color black;
		 locationDo: [ :loc | loc above ])
]

{ #category : 'building' }
STPossessionBarChart >> percentLabelOfNumericalSuperiorityFor: aSTMatchEventExtract [

	^ (aSTMatchEventExtract countNumericalSuperiorityFrames
	   / totalOfFrames * 100 printShowingDecimalPlaces: 1) , '%'
]

{ #category : 'building' }
STPossessionBarChart >> percentLabelOfPossessionFor: aSTMatchEventExtract [

	^ (aSTMatchEventExtract countPossessionFrames / totalOfFrames * 100
		   printShowingDecimalPlaces: 1) , '%'
]
