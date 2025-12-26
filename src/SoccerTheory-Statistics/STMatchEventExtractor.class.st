"
I extract from a game source for both teams a STMatchEventExtract each.

I rely on `XMLPullParser` for efficient extraction from SoccerML.

Extraction of numerical superiority is not implemented. 
"
Class {
	#name : 'STMatchEventExtractor',
	#superclass : 'Object',
	#instVars : [
		'documentScanner',
		'team1Extract',
		'team2Extract',
		'possessionSeries',
		'goalSeries',
		'frameIndex',
		'leftTeamName',
		'rightTeamName',
		'lastOfficialTime',
		'isInterruptedTime'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'instance creation' }
STMatchEventExtractor class >> onFileNamed: fullFileName [

	^ self new initializeOnString: fullFileName asFileReference contents
]

{ #category : 'instance creation' }
STMatchEventExtractor class >> onString: aString [

	^ self new initializeOnString: aString
]

{ #category : 'adding' }
STMatchEventExtractor >> addPossessionForTeamNamed: teamName [

	isInterruptedTime ifTrue: [ ^ self ].
	(possessionSeries at: teamName) add: frameIndex
]

{ #category : 'extracting' }
STMatchEventExtractor >> checkBallPossession [

	documentScanner if: 'soc:Ball' peek: [ :found |
			| side |
			documentScanner next.
			documentScanner skip: 'soc:X'.
			documentScanner skip: 'soc:Y'.
			side := documentScanner textOf: 'soc:PossessingTeam'.
			side = 'l' ifTrue: [ self addPossessionForTeamNamed: leftTeamName ].
			side = 'r' ifTrue: [ self addPossessionForTeamNamed: rightTeamName ] ]
]

{ #category : 'extracting' }
STMatchEventExtractor >> checkFrameIndex [
	"Check for updating the frame index."

	documentScanner if: 'soc:Frame' peek: [ :found |
			| officialTime |
			officialTime := found at: 'time'.
			(isInterruptedTime := lastOfficialTime = officialTime) ifFalse: [
				frameIndex := frameIndex + 1 ].
			lastOfficialTime := officialTime ]
]

{ #category : 'extracting' }
STMatchEventExtractor >> checkGoals [
	"Check for goal events."

	documentScanner if: 'soc:RobocupPlayMode' peek: [ :found |
			| text |
			documentScanner next.
			text := documentScanner text.
			text = 'goal_l' ifTrue: [
					(goalSeries
						 at: leftTeamName
						 ifAbsentPut: [ SortedCollection new ]) add: frameIndex ].
			text = 'goal_r' ifTrue: [
					(goalSeries
						 at: rightTeamName
						 ifAbsentPut: [ SortedCollection new ]) add: frameIndex ] ]
]

{ #category : 'extracting' }
STMatchEventExtractor >> checkTeam [
	"Identify the teams left and right. Note that this can change during game, typically at half time."

	documentScanner if: 'soc:Team' peek: [ :found |
			documentScanner next.
			(found at: 'side') = 'l' ifTrue: [
					leftTeamName := documentScanner textOf: 'soc:TeamName'.
					team1Extract ifNil: [
							team1Extract := STMatchEventExtract newHomeTeamName:
								                leftTeamName.
							possessionSeries at: leftTeamName put: SortedCollection new ] ].
			(found at: 'side') = 'r' ifTrue: [
					rightTeamName := documentScanner textOf: 'soc:TeamName'.
					team2Extract ifNil: [
							team2Extract := STMatchEventExtract newAwayTeamName:
								                rightTeamName.
							possessionSeries at: rightTeamName put: SortedCollection new ] ] ]
]

{ #category : 'extracting' }
STMatchEventExtractor >> endpointPairsFrom: frameNumberSeries [
	"Answer the sorted endpoints series from the given sorted frame number series."

	| endpointsPairs |
	endpointsPairs := SortedCollection new.
	frameNumberSeries ifNotEmpty: [
			endpointsPairs
				add: frameNumberSeries first;
				add: frameNumberSeries last.
			frameNumberSeries overlappingPairsDo: [ :a :b |
					b - a > 1 ifTrue: [
							endpointsPairs
								add: a;
								add: b ] ] ].
	^ endpointsPairs
]

{ #category : 'api' }
STMatchEventExtractor >> extract [
	"Extract possession endpoints from SoccerML document. 
	In case of a fixture (subclass), that needs no documentScanner, do nothing."

	documentScanner ifNotNil: [ "self initializeExtraction."
			[ documentScanner isEndDocument ] whileFalse: [ "self createTeamExtracts"
					self checkTeam.
					self checkFrameIndex.
					self checkBallPossession.
					self checkGoals.
					documentScanner next ].
			self fillExtracts ]
]

{ #category : 'extracting' }
STMatchEventExtractor >> fillExtracts [

	team1Extract possessionEndpoints:
		(self endpointPairsFrom:
			 (possessionSeries at: team1Extract teamName)).
	team1Extract goalMoments: (goalSeries
			 at: team1Extract teamName
			 ifAbsentPut: [ SortedCollection new ]).

	team2Extract possessionEndpoints:
		(self endpointPairsFrom:
			 (possessionSeries at: team2Extract teamName)).
	team2Extract goalMoments: (goalSeries
			 at: team2Extract teamName
			 ifAbsentPut: [ SortedCollection new ])
]

{ #category : 'initialization' }
STMatchEventExtractor >> initialize [

	super initialize.
	frameIndex := 0.
	possessionSeries := Dictionary new: 2.
	goalSeries := Dictionary new: 2.
	isInterruptedTime := false
]

{ #category : 'initialization' }
STMatchEventExtractor >> initializeOnString: aString [

	documentScanner := XMLPullParser parse: aString
]

{ #category : 'accessing' }
STMatchEventExtractor >> team1Extract [

	^ team1Extract
]

{ #category : 'accessing' }
STMatchEventExtractor >> team2Extract [

	^ team2Extract
]
