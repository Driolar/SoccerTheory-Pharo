"
I divide a timeline in periods, based on a determined period partition of an overall timeline interval.

I split any timeline subinterval that overlaps a period bound of the period partition.
"
Class {
	#name : 'STTimelineDivider',
	#superclass : 'Object',
	#instVars : [
		'periodRanges'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'instance creation' }
STTimelineDivider class >> from: from to: to numberOfSubIntervals: anInteger [

	^ self new
		  initializeFrom: from
		  to: to
		  numberOfSubIntervals: anInteger
]

{ #category : 'private' }
STTimelineDivider >> divideTimeline: timeline [
	"Answer an Array of timeline subintervals, one for each period.
	The subintervals don't run over any period bound. Some subintervals may be empty."

	| splittedTimeline |
	splittedTimeline := timeline.
	periodRanges allButLast do: [ :interval |
			splittedTimeline := self
				                    splitTimeline: splittedTimeline
				                    overrunningBound: interval last ].

	^ periodRanges collect: [ :periodRange |
			  splittedTimeline select: [ :frameNumber |
				  frameNumber between: periodRange first and: periodRange second ] ]
]

{ #category : 'initialization' }
STTimelineDivider >> initializeFrom: from to: to numberOfSubIntervals: anInteger [

	| subintervalExtent |
	periodRanges := Array new: anInteger.
	subintervalExtent := to - from // anInteger.
	periodRanges
		at: 1
		put: (Array with: from with: from + subintervalExtent).
	2 to: anInteger do: [ :index |
			| previousPeriod |
			previousPeriod := periodRanges at: index - 1.
			periodRanges at: index put: (Array
					 with: previousPeriod last + 1
					 with: previousPeriod last + subintervalExtent) ].
	(periodRanges at: anInteger) at: 2 put: to
]

{ #category : 'api' }
STTimelineDivider >> periodRanges [

	^ periodRanges
]

{ #category : 'api' }
STTimelineDivider >> regularSubintervalExtent [

	^ periodRanges first second - periodRanges first first + 1
]

{ #category : 'private' }
STTimelineDivider >> splitTimeline: timeline overrunningBound: bound [
	"Answer a modified timeline after having possibly splitted a subinterval in the input timeline that overlaps the given bound.
	The timeline is a sorted even array of Integer (frame numbers), where each pair represents a subinterval."

	^ (timeline pairsCollect: [ :from :to |
			   (from <= bound and: [ bound < to ])
				   ifTrue: [
						   Array
							   with: from
							   with: bound
							   with: bound + 1
							   with: to ]
				   ifFalse: [ Array with: from with: to ] ]) flattened
]
