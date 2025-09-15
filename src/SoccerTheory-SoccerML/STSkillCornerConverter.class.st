"
I convert SkillCorner open data into SoccerML via STSoccerFrames.
Real matches in SkillCorner's format are provided [here](https://github.com/SkillCorner/opendata/tree/master).

The data are not providing the teams attack direction explicitely. We make a guess.

"
Class {
	#name : 'STSkillCornerConverter',
	#superclass : 'Object',
	#instVars : [
		'socMLWriter',
		'matchData',
		'structuredData',
		'teamLeftId',
		'teamRightId',
		'lastValidPeriod'
	],
	#category : 'SoccerTheory-SoccerML-SkillCorner',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'SkillCorner'
}

{ #category : 'instance creation' }
STSkillCornerConverter class >> matchData: matchDataStream structuredData: structuredDataStream [
	"Answer a STSkillCornerConverter based on the given ReadStreams."

	^ self new
		  initializeWithMatchData: matchDataStream
		  structuredData: structuredDataStream
]

{ #category : 'instance creation' }
STSkillCornerConverter class >> matchDataFileNamed: matchDataFileName structuredDataFileNamed: structuredDataFileName [
	"Answer a STSkillCornerConverter based on the given files."

	^ self
		  matchData: matchDataFileName asFileReference readStream
		  structuredData: structuredDataFileName asFileReference readStream
]

{ #category : 'private' }
STSkillCornerConverter >> buildFrameFromJsonFrame: jsonFrame [
	"Convert the JSON frame to an STSoccerFrame."

	^ (STSkillCornerFrame jsonFrame: jsonFrame matchData: matchData)
		  buildFrameForLeftTeamId: teamLeftId
		  rightTeamId: teamRightId
]

{ #category : 'private' }
STSkillCornerConverter >> checkNewSequenceOn: jsonFrame [
	"Start a new sequence if necessary."

	| nextPeriod |
	nextPeriod := jsonFrame at: 'period' ifAbsent: [ nil ].
	(lastValidPeriod = 1 and: [ nextPeriod = 2 ]) ifTrue: [
			| switchId |
			switchId := teamLeftId.
			teamLeftId := teamRightId.
			teamRightId := switchId.
			socMLWriter startNewSequence ].
	nextPeriod ifNotNil: [ lastValidPeriod := nextPeriod ]
]

{ #category : 'private' }
STSkillCornerConverter >> fillWriter [
	"Fill the writer with all valid frames."

	self resetWriting.
	self guessAttackDirection.
	structuredData do: [ :jsonFrame |
			| skillCornerFrame |
			skillCornerFrame := STSkillCornerFrame
				                    jsonFrame: jsonFrame
				                    matchData: matchData.
			skillCornerFrame isValid ifTrue: [
					self checkNewSequenceOn: jsonFrame.
					socMLWriter addFrame: (skillCornerFrame
							 buildFrameForLeftTeamId: teamLeftId
							 rightTeamId: teamRightId) ] ]
]

{ #category : 'private' }
STSkillCornerConverter >> guessAttackDirection [
	"Guess the team's attack direction."

	| firstValidFrame |
	firstValidFrame := structuredData
		                   detect: [ :jsonFrame |
			                   (STSkillCornerFrame
				                    jsonFrame: jsonFrame
				                    matchData: matchData) isValid ]
		                   ifNone: [ nil ].
	firstValidFrame ifNotNil: [
			teamLeftId := (STSkillCornerFrame
				               jsonFrame: firstValidFrame
				               matchData: matchData) leftmostPlayer at: 'team_id'.
			teamRightId := teamLeftId = matchData homeTeamId
				               ifTrue: [ matchData awayTeamId ]
				               ifFalse: [ matchData homeTeamId ] ]
]

{ #category : 'initialization' }
STSkillCornerConverter >> initializeWithMatchData: matchDataStream structuredData: structuredDataStream [

	matchData := STSkillCornerMatchData on: matchDataStream.
	structuredData := (NeoJSONReader on: structuredDataStream) next
]

{ #category : 'initialization' }
STSkillCornerConverter >> resetWriting [
	"Reset socMLWriter."

	socMLWriter := STSoccerMLWriter
		               pitch: matchData pitch
		               framesPerSecond: matchData framesPerSecond.
	socMLWriter sourceName: 'SkillCorner converter'.
	lastValidPeriod := nil.
	teamLeftId := nil.
	teamRightId := nil
]

{ #category : 'api' }
STSkillCornerConverter >> writeWholeDocument [
	"Answer the whole document after having built it entirely."

	self fillWriter.
	^ socMLWriter ifNotNil: [ :writer | writer writeWholeDocument ]
]

{ #category : 'api' }
STSkillCornerConverter >> writeWholeDocumentToFileNamed: fileName [
	"Write and save the document to a new file named fileName."

	self fillWriter.
	socMLWriter ifNotNil: [ :writer |
		writer writeWholeDocumentToFileNamed: fileName ]
]
