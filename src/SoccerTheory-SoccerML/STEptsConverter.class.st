"
I convert EPTS into SoccerML via STSoccerFrames.
The EPTS (Electronic Performance and Tracking Systems) format is described [here](https://quality.fifa.com/innovation/standards/epts/research-development-epts-standard-data-format) and also [here](https://gwood.me/epts).

I parse a raw data file according to the accompanying metadata in xml format.
This leads to frames without ball possession information.
Raw data and metadata may be complemented by an event file in json format.
Ball possession could be deduced from the events in this event file.

A real data example can be found [here](https://github.com/metrica-sports/sample-data/tree/master/data/Sample_Game_3). 
"
Class {
	#name : 'STEptsConverter',
	#superclass : 'Object',
	#instVars : [
		'rawDataStream',
		'formatSpecificationNode',
		'splittedRawLine',
		'socMLWriter',
		'lastValidFrameCount',
		'metadata'
	],
	#category : 'SoccerTheory-SoccerML-EPTS',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'EPTS'
}

{ #category : 'instance creation' }
STEptsConverter class >> metadata: aStringOrStream rawData: aReadStream [
	"Answer a new instance of STEptsConverter for the format defined in aStringOrStream (xml) and the raw data stream aReadStream."

	^ self new initializeWithMetadata: aStringOrStream rawData: aReadStream
]

{ #category : 'instance creation' }
STEptsConverter class >> metadataFileNamed: metadataFileName rawDataFileNamed: rawDataFileName [
	"Answer a new instance of STEptsConverter for the existing format and raw data files."

	^ self
		  metadata: metadataFileName asFileReference readStream
		  rawData: rawDataFileName asFileReference readStream
]

{ #category : 'private' }
STEptsConverter >> advanceToNextValidRawLine [
	"Advance to the next valid raw line. Skip lines with invalid ball data. Answer nil if the end is reached."

	rawDataStream atEnd ifTrue: [ ^ nil ].
	self splitNextRawLine.
	[ self ballPosition isNil and: [ rawDataStream atEnd not ] ]
		whileTrue: [ self splitNextRawLine ].
	self ballPosition ifNil: [ ^ nil ]
]

{ #category : 'private' }
STEptsConverter >> ballCoordinatesSeparator [
	"Answer the String that separates the ball coordinates in the raw line."

	^ (formatSpecificationNode elements at: self ballFormatIndex)
		  attributeAt: 'separator'
]

{ #category : 'private' }
STEptsConverter >> ballFormatIndex [
	"Answer the ball's index derived from the formatNode."

	| index |
	index := 1.
	formatSpecificationNode elementsDo: [ :each |
			(each elements anySatisfy: [ :element |
				 element name = 'BallChannelRef' ])
				ifTrue: [ ^ index ]
				ifFalse: [ index := index + 1 ] ].
	^ 0
]

{ #category : 'private' }
STEptsConverter >> ballPosition [
	"Answer the Point where the ball is located in meters. Answer nil if the ball data is missing."

	| ballCoordinates x y |
	ballCoordinates := (splittedRawLine at: self ballFormatIndex)
		                   substrings: self ballCoordinatesSeparator.
	x := ballCoordinates first asNumber.
	y := (ballCoordinates at: 2) asNumber.
	(x isNaN or: [ y isNaN ]) ifTrue: [ ^ nil ].
	^ (self xInMeters: x) @ (self yInMeters: y)
]

{ #category : 'private' }
STEptsConverter >> belongToSameSequenceFrame: oneFrameCount andFrame: otherFrameCount [
	"Answer true if both frames belong to the same sequence."

	| bothFrameCounts |
	metadata hasHalfTime ifFalse: [ ^ true ].
	bothFrameCounts := OrderedCollection
		                   with: oneFrameCount
		                   with: otherFrameCount.
	^ (bothFrameCounts allSatisfy: [ :count |
		   metadata firstHalfInterval rangeIncludes: count asInteger ]) or: [
			  bothFrameCounts allSatisfy: [ :count |
				  metadata secondHalfInterval rangeIncludes: count asInteger ] ]
]

{ #category : 'private' }
STEptsConverter >> checkNewSequence [
	"Start a new sequence if necessary."

	lastValidFrameCount ifNotNil: [ :previousFrameCount |
			(self
				 belongToSameSequenceFrame: previousFrameCount
				 andFrame: self frameCount) ifFalse: [
				socMLWriter startNewSequence ] ].
	lastValidFrameCount := self frameCount
]

{ #category : 'api' }
STEptsConverter >> copyRawDataStartingAtFrameCount: startFrameCount numberOfFrames: numberOfFrames asFileNamed: fileName [
	"Save the given number of consecutive frame lines starting at startFrameCount in a new file named fileName."

	| writeStream lineCounter frameCountMatcher currentLine |
	writeStream := fileName asFileReference writeStream.
	lineCounter := 0.
	rawDataStream position: 0.
	frameCountMatcher := startFrameCount asString
	                     ,
	                     (metadata topSeparatorForFrameCount:
		                      startFrameCount).
	rawDataStream match: (startFrameCount > 1
			 ifTrue: [ String lf , frameCountMatcher ]
			 ifFalse: [ frameCountMatcher ]).
	currentLine := frameCountMatcher , rawDataStream nextLine.

	[ rawDataStream atEnd not and: [ lineCounter < numberOfFrames ] ]
		whileTrue: [
				writeStream nextPutAll: currentLine.
				writeStream lf.
				lineCounter := lineCounter + 1.
				currentLine := rawDataStream nextLine ].
	writeStream close
]

{ #category : 'private' }
STEptsConverter >> fillWriter [
	"Fill the writer with all frames."

	| validFrame |
	self resetWriting.
	validFrame := self nextFrame.
	[ validFrame notNil ] whileTrue: [
			socMLWriter addFrame: validFrame.
			validFrame := self nextFrame ]
]

{ #category : 'private' }
STEptsConverter >> frameCount [
	"Answer the frame count in the current raw line."

	^ splittedRawLine at: self frameCountIndex
]

{ #category : 'private' }
STEptsConverter >> frameCountIndex [
	"Answer the frame count index for the current format specification node."

	^ metadata frameCountIndexOf: formatSpecificationNode
]

{ #category : 'initialization' }
STEptsConverter >> initializeWithMetadata: aStringOrStream rawData: aReadStream [
	"Initialize formatInXml and rawDataStream"

	metadata := STEptsMetadata on: aStringOrStream.
	rawDataStream := aReadStream.
	self resetWriting
]

{ #category : 'private' }
STEptsConverter >> isFirstHalf [
	"Answer true if the frame belongs to the games first half, otherwise false."

	^ metadata firstHalfInterval rangeIncludes: self frameCount asInteger
]

{ #category : 'private' }
STEptsConverter >> isSecondHalf [
	"Answer true if the frame belongs to the games second half, otherwise false."

	^ metadata secondHalfInterval rangeIncludes:
		  self frameCount asInteger
]

{ #category : 'private' }
STEptsConverter >> newFrameBuilder [
	"Answer a new STSoccerFrameBuilder for the current raw line."

	^ (STSoccerFrameBuilder
		   newWithTeamLeft: self teamLeftName
		   teamRight: self teamRightName
		   pitch: metadata pitch
		   ball: (STBall newWithPosition: self ballPosition))
		  setModernSoccerStrategy;
		  officialTime: self frameCount;
		  framesPerSecond: metadata framesPerSecond;
		  yourself
]

{ #category : 'private' }
STEptsConverter >> nextFrame [
	"Answer the next STSoccerFrame from the next raw line. Answer nil if there are no more lines."

	| frameBuilder |
	self advanceToNextValidRawLine ifNil: [ ^ nil ].

	self checkNewSequence.

	frameBuilder := self newFrameBuilder.
	metadata playerNodes do: [ :playerNode |
			| playerId shirtNumber teamId isGoalkeeper |
			playerId := playerNode attributeAt: 'id'.
			teamId := playerNode attributeAt: 'teamId'.
			shirtNumber := playerNode contentStringAt: 'ShirtNumber'.
			isGoalkeeper := metadata isGoalkeeper: playerNode.
			(self playerPositions includesKey: playerId) ifTrue: [
					| playerPosition |
					playerPosition := self playerPositions at: playerId.
					teamId = self teamLeftId ifTrue: [
							isGoalkeeper
								ifTrue: [
										frameBuilder
											createGoalkeeperInTeamLeftAtPosition: playerPosition
											number: shirtNumber ]
								ifFalse: [
										frameBuilder
											createPlayerInTeamLeftAtPosition: playerPosition
											number: shirtNumber ] ].
					teamId = self teamRightId ifTrue: [
							isGoalkeeper
								ifTrue: [
										frameBuilder
											createGoalkeeperInTeamRightAtPosition: playerPosition
											number: shirtNumber ]
								ifFalse: [
										frameBuilder
											createPlayerInTeamRightAtPosition: playerPosition
											number: shirtNumber ] ] ] ].
	^ frameBuilder builtFrame
]

{ #category : 'private' }
STEptsConverter >> playerPositionAssociationIn: playerChannelReferencesNode values: rawValuesChunk [
	"Answer an Association with the player id as key and the player's position Point as value."

	| separator rawValues index indexX indexY playerId |
	separator := playerChannelReferencesNode attributeAt: 'separator'.
	rawValues := rawValuesChunk substrings: separator.

	index := 1.
	playerId := nil.
	indexX := nil.
	indexY := nil.
	playerChannelReferencesNode elementsDo: [ :playerChannelRef |
			metadata playerIdsForXChannels
				at: (playerChannelRef attributeAt: 'playerChannelId')
				ifPresent: [ :value |
						playerId := value.
						indexX := index ].
			metadata playerIdsForYChannels
				at: (playerChannelRef attributeAt: 'playerChannelId')
				ifPresent: [ :value |
						playerId := value.
						indexY := index ].
			index := index + 1 ].

	^ Association new
		  key: playerId
		  value: (self xInMeters: (rawValues at: indexX) asNumber)
			  @ (self yInMeters: (rawValues at: indexY) asNumber);
		  yourself
]

{ #category : 'private' }
STEptsConverter >> playerPositions [
	"Answer a Dictionary with the player id as key and the player's position Point as value."

	| playerChannelRefNodes rawPlayerValues separator playerIndex |
	playerChannelRefNodes := formatSpecificationNode elements at:
		                         self playersFormatIndex.
	separator := playerChannelRefNodes attributeAt: 'separator'.
	rawPlayerValues := (splittedRawLine at: self playersFormatIndex)
		                   substrings: separator.
	playerIndex := 0.
	^ rawPlayerValues
		  inject: Dictionary new
		  into: [ :dictionary :valuesChunk |
				  playerIndex := playerIndex + 1.
				  dictionary
					  add: (self
							   playerPositionAssociationIn:
								   (playerChannelRefNodes elements at: playerIndex)
							   values: valuesChunk);
					  yourself ]
]

{ #category : 'private' }
STEptsConverter >> playersFormatIndex [
	"Answer the players's index derived from the formatNode."

	| index |
	index := 1.
	formatSpecificationNode elementsDo: [ :each |
			(each descendantElements anySatisfy: [ :element |
				 element name = 'PlayerChannelRef' ])
				ifTrue: [ ^ index ]
				ifFalse: [ index := index + 1 ] ].
	^ 0
]

{ #category : 'initialization' }
STEptsConverter >> resetWriting [
	"Reset rawDataStream and socMLWriter."

	rawDataStream position: 0.
	socMLWriter := nil.
	lastValidFrameCount := nil.
	socMLWriter := STSoccerMLWriter
		               pitch: metadata pitch
		               framesPerSecond: metadata framesPerSecond.
	socMLWriter sourceName: 'EPTS converter'
]

{ #category : 'private' }
STEptsConverter >> splitNextRawLine [
	"Split the next raw line into frame count, players and ball. Answer current raw line (unsplitted) as byproduct."

	| currentRawLine topSeparator |
	currentRawLine := rawDataStream nextLine.
	formatSpecificationNode := metadata detectFormatSpecificationFor:
		                           currentRawLine.
	topSeparator := formatSpecificationNode attributeAt: 'separator'.
	splittedRawLine := currentRawLine substrings: topSeparator.
	^ currentRawLine
]

{ #category : 'accessing' }
STEptsConverter >> teamLeftId [
	"Answer the id of team left."

	^ metadata teamIdOf: self teamLeftNode
]

{ #category : 'accessing' }
STEptsConverter >> teamLeftName [
	"Answer the name of team left."

	^ metadata teamNameOf: self teamLeftNode
]

{ #category : 'private' }
STEptsConverter >> teamLeftNode [
	"Answer the team now playing from left to right."

	metadata hasHalfTime ifFalse: [
		^ metadata teamLeftNodeAtFirstHalfTime ].
	self isFirstHalf ifTrue: [ ^ metadata teamLeftNodeAtFirstHalfTime ].
	self isSecondHalf ifTrue: [ ^ metadata teamRightNodeAtFirstHalfTime ]
]

{ #category : 'accessing' }
STEptsConverter >> teamRightId [
	"Answer the id of team right."

	^ metadata teamIdOf: self teamRightNode
]

{ #category : 'accessing' }
STEptsConverter >> teamRightName [
	"Answer the name of team right."

	^ metadata teamNameOf: self teamRightNode
]

{ #category : 'private' }
STEptsConverter >> teamRightNode [
	"Answer the team now playing from right to left."

	metadata hasHalfTime ifFalse: [
		^ metadata teamRightNodeAtFirstHalfTime ].
	self isFirstHalf ifTrue: [ ^ metadata teamRightNodeAtFirstHalfTime ].
	self isSecondHalf ifTrue: [ ^ metadata teamLeftNodeAtFirstHalfTime ]
]

{ #category : 'private' }
STEptsConverter >> topSeparator [

	^ formatSpecificationNode attributeAt: 'separator'
]

{ #category : 'api' }
STEptsConverter >> writeWholeDocument [
	"Answer the whole document after having built it entirely."

	self fillWriter.
	^ socMLWriter ifNotNil: [ :writer | writer writeWholeDocument ]
]

{ #category : 'api' }
STEptsConverter >> writeWholeDocumentToFileNamed: fileName [
	"Write and save the document to a new file named fileName."

	self fillWriter.
	socMLWriter ifNotNil: [ :writer |
		writer writeWholeDocumentToFileNamed: fileName ]
]

{ #category : 'private' }
STEptsConverter >> xInMeters: rawXCoordinate [
	"Answer the raw x-coordinate converted from unit to meters."

	metadata xUnit = 'cm' ifTrue: [ ^ rawXCoordinate / 100 ].
	metadata xUnit = 'normalized' ifTrue: [
		^ (rawXCoordinate - 0.5) * metadata pitch extent x ].
	^ rawXCoordinate
]

{ #category : 'private' }
STEptsConverter >> yInMeters: rawYCoordinate [
	"Answer the raw y-coordinate converted from unit to meters."

	metadata yUnit = 'cm' ifTrue: [ ^ rawYCoordinate / 100 ].
	metadata yUnit = 'normalized' ifTrue: [
		^ (rawYCoordinate - 0.5) * metadata pitch extent y ].
	^ rawYCoordinate
]
