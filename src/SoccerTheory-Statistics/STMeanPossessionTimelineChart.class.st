"
For every team, I render a line that interpolates the mean possession share of several game periods.
I also mark each goal moment with a vertical line.

Inspired by the chart example at:
https://www.whoscored.com/matches/1821398/live/england-premier-league-2024-2025-manchester-city-liverpool
"
Class {
	#name : 'STMeanPossessionTimelineChart',
	#superclass : 'STMatchChart',
	#instVars : [
		'timelineDivider'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'building' }
STMeanPossessionTimelineChart >> buildLegend1 [

	self buildLegendForTeamExtract: team1Extract
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> buildLegend2 [

	self buildLegendForTeamExtract: team2Extract
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> buildLegendForTeamExtract: aSTMatchEventExtract [

	| legend circleMarker |
	circleMarker := RSMarker new
		                shape: (RSShapeFactory circle
				                 color: aSTMatchEventExtract teamGradientColorLow;
				                 yourself);
		                offsetRatio: 0.5;
		                yourself.
	legend := RSLegend new
		          text: 'Ball possession' withShape: (RSLine new
				           startPoint: 0 @ 0;
				           endPoint: 50 @ 0;
				           color: aSTMatchEventExtract teamGradientColorLow;
				           markerStart: circleMarker;
				           yourself);
		          text: 'Goal moment' withShape: (RSLine new
			           startPoint: 0 @ 0;
			           endPoint: 50 @ 0;
			           color: aSTMatchEventExtract teamGradientColorLow;
			           dashed;
			           yourself);
		          yourself.

	legend beFixedWithTitle: aSTMatchEventExtract teamName.
	legend container: self canvas.
	legend build
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> goalMomentLinePlots [

	^ self goalMomentLinePlotsTeam1 copyWithAll:
		  self goalMomentLinePlotsTeam2
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> goalMomentLinePlotsTeam1 [

	^ self goalMomentLinePlotsTeamExtract: team1Extract
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> goalMomentLinePlotsTeam2 [

	^ self goalMomentLinePlotsTeamExtract: team2Extract
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> goalMomentLinePlotsTeamExtract: teamExtract [

	^ teamExtract goalMoments collect: [ :frameNumber |
			  (RSLinePlot
				   x: (Array with: frameNumber with: frameNumber)
				   y: (Array with: self minChartValueY with: self maxChartValueY))
				  dashed;
				  color: teamExtract teamGradientColorLow;
				  yourself ]
]

{ #category : 'initialization' }
STMeanPossessionTimelineChart >> initializeChart [

	timelineDivider := STTimelineDivider
		                   from: self minimumFrameNumber
		                   to: self maximumFrameNumber
		                   numberOfSubIntervals: 6.

	self title:
		'Possession per '
		, timelineDivider regularSubintervalExtent asString
		, ' frames period'.

	self
		add: self possessionPlotTeam1;
		add: self possessionPlotTeam2;
		addAll: self goalMomentLinePlots.

	self horizontalTick integer.
	self verticalTick labelConversion: [ :val |
		val asInteger asString , '%' ].
	self xlabel: 'Frame sequence number'.
	self ylabel: 'Possession share in percent'.

	self
		buildLegend1;
		buildLegend2
]

{ #category : 'private' }
STMeanPossessionTimelineChart >> maximumFrameNumber [

	^ team1Extract possessionEndpoints last max:
		  team2Extract possessionEndpoints last
]

{ #category : 'private' }
STMeanPossessionTimelineChart >> minimumFrameNumber [

	^ team1Extract possessionEndpoints first min:
		  team2Extract possessionEndpoints first
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> possessionPlotTeam1 [

	^ RSLinePlot new
		  x: self xValues y: self subIntervalPercentsForTeam1;
		  marker: RSShapeFactory circle;
		  color: self gradientColorLowOfTeam1;
		  yourself
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> possessionPlotTeam2 [

	^ RSLinePlot new
		  x: self xValues y: self subIntervalPercentsForTeam2;
		  marker: RSShapeFactory circle;
		  color: self gradientColorLowOfTeam2;
		  yourself
]

{ #category : 'private' }
STMeanPossessionTimelineChart >> subIntervalPercentsForTeam1 [

	^ self subIntervalPercentsForTeamExtract: team1Extract
]

{ #category : 'private' }
STMeanPossessionTimelineChart >> subIntervalPercentsForTeam2 [

	^ self subIntervalPercentsForTeamExtract: team2Extract
]

{ #category : 'private' }
STMeanPossessionTimelineChart >> subIntervalPercentsForTeamExtract: teamExtract [

	| subIntervals |
	subIntervals := timelineDivider divideTimeline:
		                teamExtract possessionEndpoints.

	^ subIntervals collectWithIndex: [ :subInterval :index |
			  | totalOfFrames |
			  totalOfFrames := (timelineDivider periodRanges at: index) second
			                   - (timelineDivider periodRanges at: index) first
			                   + 1.
			  (teamExtract countFramesFromEndpoints: subInterval)
			  / totalOfFrames * 100 ]
]

{ #category : 'building' }
STMeanPossessionTimelineChart >> xValues [

	^ timelineDivider periodRanges collect: [ :periodRange |
		  periodRange sum // 2 ]
]
