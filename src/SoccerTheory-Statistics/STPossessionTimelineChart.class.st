"
For every team, I render a line that interpolates the mean possession share of several game periods.
I also mark each goal moment with a vertical line.

Inspired by the chart example at:
https://www.whoscored.com/matches/1821398/live/england-premier-league-2024-2025-manchester-city-liverpool
"
Class {
	#name : 'STPossessionTimelineChart',
	#superclass : 'STMatchChart',
	#instVars : [
		'timelineDivider'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'building' }
STPossessionTimelineChart >> buildLegend1 [

	self buildLegendForTeam: team1Extract team
]

{ #category : 'building' }
STPossessionTimelineChart >> buildLegend2 [

	self buildLegendForTeam: team2Extract team
]

{ #category : 'building' }
STPossessionTimelineChart >> buildLegendForTeam: aSTTeam [

	| legend circleMarker |
	circleMarker := RSMarker new
		                shape: (RSShapeFactory circle
				                 color: aSTTeam gradientColorLow;
				                 yourself);
		                offsetRatio: 0.5;
		                yourself.
	legend := RSLegend new
		          text: 'Ball possession' withShape: (RSLine new
				           startPoint: 0 @ 0;
				           endPoint: 50 @ 0;
				           color: aSTTeam gradientColorLow;
				           markerStart: circleMarker;
				           yourself);
		          text: 'Goal moment' withShape: (RSLine new
			           startPoint: 0 @ 0;
			           endPoint: 50 @ 0;
			           color: aSTTeam gradientColorLow;
			           dashed;
			           yourself);
		          yourself.

	legend beFixedWithTitle: aSTTeam teamName.
	legend container: self canvas.
	legend build
]

{ #category : 'building' }
STPossessionTimelineChart >> goalMomentLinePlots [

	^ self goalMomentLinePlotsTeam1 copyWithAll:
		  self goalMomentLinePlotsTeam2
]

{ #category : 'building' }
STPossessionTimelineChart >> goalMomentLinePlotsTeam1 [

	^ self goalMomentLinePlotsTeamExtract: team1Extract
]

{ #category : 'building' }
STPossessionTimelineChart >> goalMomentLinePlotsTeam2 [

	^ self goalMomentLinePlotsTeamExtract: team2Extract
]

{ #category : 'building' }
STPossessionTimelineChart >> goalMomentLinePlotsTeamExtract: teamExtract [

	^ teamExtract goalMoments collect: [ :frameNumber |
			  (RSLinePlot
				   x: (Array with: frameNumber with: frameNumber)
				   y: (Array with: self minChartValueY with: self maxChartValueY))
				  dashed;
				  color: teamExtract team gradientColorLow;
				  yourself ]
]

{ #category : 'initialization' }
STPossessionTimelineChart >> initializeChart [

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
STPossessionTimelineChart >> maximumFrameNumber [

	^ team1Extract possessionEndpoints last max:
		  team2Extract possessionEndpoints last
]

{ #category : 'private' }
STPossessionTimelineChart >> minimumFrameNumber [

	^ team1Extract possessionEndpoints first min:
		  team2Extract possessionEndpoints first
]

{ #category : 'building' }
STPossessionTimelineChart >> possessionPlotTeam1 [

	^ RSLinePlot new
		  x: self xValues y: self subIntervalPercentsForTeam1;
		  marker: RSShapeFactory circle;
		  color: self gradientColorLowOfTeam1;
		  yourself
]

{ #category : 'building' }
STPossessionTimelineChart >> possessionPlotTeam2 [

	^ RSLinePlot new
		  x: self xValues y: self subIntervalPercentsForTeam2;
		  marker: RSShapeFactory circle;
		  color: self gradientColorLowOfTeam2;
		  yourself
]

{ #category : 'private' }
STPossessionTimelineChart >> subIntervalPercentsForTeam1 [

	^ self subIntervalPercentsForTeamExtract: team1Extract
]

{ #category : 'private' }
STPossessionTimelineChart >> subIntervalPercentsForTeam2 [

	^ self subIntervalPercentsForTeamExtract: team2Extract
]

{ #category : 'private' }
STPossessionTimelineChart >> subIntervalPercentsForTeamExtract: teamExtract [

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
STPossessionTimelineChart >> xValues [

	^ timelineDivider periodRanges collect: [ :periodRange |
		  periodRange sum // 2 ]
]
