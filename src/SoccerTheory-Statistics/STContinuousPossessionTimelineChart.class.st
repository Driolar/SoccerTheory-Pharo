"
I render a possession share chart composed by the following frame timelines for each team:
- possession share bars
- numerical superiority bars
- goal moments
"
Class {
	#name : 'STContinuousPossessionTimelineChart',
	#superclass : 'STMatchChart',
	#instVars : [
		'timeLinePlots'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'adding' }
STContinuousPossessionTimelineChart >> addIntervalPopups [

	timeLinePlots do: [ :barPlot |
		barPlot bars @ (RSPopup text: [ :assoc | assoc asString ]) ]
]

{ #category : 'adding' }
STContinuousPossessionTimelineChart >> addPlotsTeam1 [

	team1Extract possessionEndpoints notEmpty ifTrue: [
			self addTimeLinePlot: (RSTimeLinePlot new
					 entries: team1Extract possessionEndpoints at: 4;
					 color: (Color fromHexString: team1Extract teamGradientColorLow);
					 yourself) ].
	team1Extract numericalSuperiorityEndPoints notEmpty ifTrue: [
			self addTimeLinePlot: (RSTimeLinePlot new
					 entries: team1Extract numericalSuperiorityEndPoints at: 5;
					 color: (Color fromHexString: team1Extract teamGradientColorHigh);
					 yourself) ].
	team1Extract goalMoments notEmpty ifTrue: [
			self add: (STGoalTimelinePlot new
					 entries: team1Extract goalMoments at: 6;
					 color: (Color fromHexString: team1Extract teamGradientColorHigh);
					 yourself) ]
]

{ #category : 'adding' }
STContinuousPossessionTimelineChart >> addPlotsTeam2 [

	team1Extract possessionEndpoints notEmpty ifTrue: [
			self addTimeLinePlot: (RSTimeLinePlot new
					 entries: team2Extract possessionEndpoints at: 3;
					 color: (Color fromHexString: team2Extract teamGradientColorLow);
					 yourself) ].
	team1Extract numericalSuperiorityEndPoints notEmpty ifTrue: [
			self addTimeLinePlot: (RSTimeLinePlot new
					 entries: team2Extract numericalSuperiorityEndPoints at: 2;
					 color: (Color fromHexString: team2Extract teamGradientColorHigh);
					 yourself) ].
	team2Extract goalMoments notEmpty ifTrue: [
			self add: (STGoalTimelinePlot new
					 entries: team2Extract goalMoments at: 1;
					 color: (Color fromHexString: team2Extract teamGradientColorHigh);
					 yourself) ]
]

{ #category : 'adding' }
STContinuousPossessionTimelineChart >> addTimeLinePlot: aRSTimeLinePlot [
	"Add timeline plot remembering it."

	timeLinePlots add: aRSTimeLinePlot.
	self add: aRSTimeLinePlot
]

{ #category : 'building' }
STContinuousPossessionTimelineChart >> build [

	super build.
	self addIntervalPopups
]

{ #category : 'building' }
STContinuousPossessionTimelineChart >> buildLegend1 [

	| legend |
	legend := RSLegend new.
	legend text: 'Goals' withCircleColor: self gradientColorHighOfTeam1.
	team1Extract numericalSuperiorityEndPoints notEmpty ifTrue: [
			legend
				text: 'Numerical superiority'
				withBoxColor: self gradientColorHighOfTeam1 ].
	legend
		text: 'Ball possession'
		withBoxColor: self gradientColorLowOfTeam1.

	legend beFixedWithTitle: team1Extract teamName.
	legend container: self canvas.
	legend build
]

{ #category : 'building' }
STContinuousPossessionTimelineChart >> buildLegend2 [

	| legend |
	legend := RSLegend new.
	legend
		text: 'Ball possession'
		withBoxColor: self gradientColorLowOfTeam2.
	team2Extract numericalSuperiorityEndPoints notEmpty ifTrue: [
			legend
				text: 'Numerical superiority'
				withBoxColor: self gradientColorHighOfTeam2 ].
	legend text: 'Goals' withCircleColor: self gradientColorHighOfTeam2.

	legend beFixedWithTitle: team2Extract teamName.
	legend container: self canvas.
	legend build
]

{ #category : 'initialization' }
STContinuousPossessionTimelineChart >> initialize [

	super initialize.
	timeLinePlots := OrderedCollection new
]

{ #category : 'initialization' }
STContinuousPossessionTimelineChart >> initializeChart [

	self
		title: 'Continuous Possession Timeline';
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
