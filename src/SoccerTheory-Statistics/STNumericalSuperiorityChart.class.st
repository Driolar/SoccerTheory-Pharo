"
I render a numerical superiority chart composed by the following frame timelines for each team:
- possession share bars
- numerical superiority bars
- goal moments
"
Class {
	#name : 'STNumericalSuperiorityChart',
	#superclass : 'STMatchChart',
	#instVars : [
		'timeLinePlots'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'adding' }
STNumericalSuperiorityChart >> addIntervalPopups [

	timeLinePlots do: [ :barPlot |
		barPlot bars @ (RSPopup text: [ :assoc | assoc asString ]) ]
]

{ #category : 'adding' }
STNumericalSuperiorityChart >> addPlotsTeam1 [

	self addTimeLinePlot: (RSTimeLinePlot new
			 entries: team1Extract possessionEndpoints at: 4;
			 color: (Color fromHexString: team1Extract team gradientColorLow);
			 yourself).
	self addTimeLinePlot: (RSTimeLinePlot new
			 entries: team1Extract numericalSuperiorityEndPoints at: 5;
			 color: (Color fromHexString: team1Extract team gradientColorHigh);
			 yourself).
	team1Extract goalMoments notEmpty ifTrue: [
			self add: (STGoalTimelinePlot new
					 entries: team1Extract goalMoments at: 6;
					 color:
						 (Color fromHexString: team1Extract team gradientColorHigh);
					 yourself) ]
]

{ #category : 'adding' }
STNumericalSuperiorityChart >> addPlotsTeam2 [

	self addTimeLinePlot: (RSTimeLinePlot new
			 entries: team2Extract possessionEndpoints at: 3;
			 color: (Color fromHexString: team2Extract team gradientColorLow);
			 yourself).
	self addTimeLinePlot: (RSTimeLinePlot new
			 entries: team2Extract numericalSuperiorityEndPoints at: 2;
			 color: (Color fromHexString: team2Extract team gradientColorHigh);
			 yourself).
	team2Extract goalMoments notEmpty ifTrue: [
			self add: (STGoalTimelinePlot new
					 entries: team2Extract goalMoments at: 1;
					 color:
						 (Color fromHexString: team2Extract team gradientColorHigh);
					 yourself) ]
]

{ #category : 'adding' }
STNumericalSuperiorityChart >> addTimeLinePlot: aRSTimeLinePlot [
	"Add timeline plot remembering it."

	timeLinePlots add: aRSTimeLinePlot.
	self add: aRSTimeLinePlot
]

{ #category : 'building' }
STNumericalSuperiorityChart >> build [

	super build.
	self addIntervalPopups
]

{ #category : 'building' }
STNumericalSuperiorityChart >> buildLegend1 [

	| legend |
	legend := RSLegend new
		          text: 'Goals'
		          withCircleColor: self gradientColorHighOfTeam1;
		          text: 'Numerical superiority'
		          withBoxColor: self gradientColorHighOfTeam1;
		          text: 'Ball possession'
		          withBoxColor: self gradientColorLowOfTeam1;
		          yourself.

	legend beFixedWithTitle: team1Extract team teamName.
	legend container: self canvas.
	legend build
]

{ #category : 'building' }
STNumericalSuperiorityChart >> buildLegend2 [

	| legend |
	legend := RSLegend new
		          text: 'Ball possession'
		          withBoxColor: self gradientColorLowOfTeam2;
		          text: 'Numerical superiority'
		          withBoxColor: self gradientColorHighOfTeam2;
		          text: 'Goals'
		          withCircleColor: self gradientColorHighOfTeam2;
		          yourself.

	legend beFixedWithTitle: team2Extract team teamName.
	legend container: self canvas.
	legend build
]

{ #category : 'initialization' }
STNumericalSuperiorityChart >> initialize [

	super initialize.
	timeLinePlots := OrderedCollection new
]

{ #category : 'initialization' }
STNumericalSuperiorityChart >> initializeChart [

	self
		title: 'Timeline of Numerical Superiority';
		extent: 500 @ 200;
		padding: 10 @ 0.

	self
		addPlotsTeam1;
		addPlotsTeam2.

	self removeVerticalTicks.
	self horizontalTick integer.
	self xlabel: 'Frame sequence number'.

	self
		buildLegend1;
		buildLegend2
]
