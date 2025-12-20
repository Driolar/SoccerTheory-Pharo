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
	self labelNumericalSuperiorityBars
]

{ #category : 'building' }
STPossessionBarChart >> build [

	super build.
	self colorBars.
	self addBarLabels
]

{ #category : 'building' }
STPossessionBarChart >> buildLegend1 [

	| legend |
	legend := RSLegend new
		          text: 'Total ball possession share'
		          withBoxColor: self gradientColorLowOfTeam1;
		          text: 'possession while numerical superiority'
		          withBoxColor: self gradientColorHighOfTeam1;
		          yourself.

	legend beFixedWithTitle: team1Extract team teamName.
	legend container: self canvas.
	legend build
]

{ #category : 'building' }
STPossessionBarChart >> buildLegend2 [

	| legend |
	legend := RSLegend new
		          text: 'Total ball possession share'
		          withBoxColor: self gradientColorLowOfTeam2;
		          text: 'possession while numerical superiority'
		          withBoxColor: self gradientColorHighOfTeam2;
		          yourself.

	legend beFixedWithTitle: team2Extract team teamName.
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

	^ team1Extract team teamName , ' '
	  , team1Extract goalMoments size asString , ' : '
	  , team2Extract goalMoments size asString , ' '
	  , team2Extract team teamName
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
