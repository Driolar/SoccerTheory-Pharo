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
		'formatXmlDocument',
		'formatSpecificationNode',
		'splittedRawLine',
		'socMLWriter'
	],
	#category : 'SoccerTheory-SoccerML-Base',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'Base'
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

{ #category : 'private - rawdata' }
STEptsConverter >> advanceToNextValidRawLine [
	"Advance to the next valid raw line. Skip lines with invalid ball data. Answer nil if the end is reached."

	rawDataStream atEnd ifTrue: [ ^ nil ].
	self splitNextRawLine.
	[ self ballPosition isNil and: [ rawDataStream atEnd not ] ]
		whileTrue: [ self splitNextRawLine ].
	self ballPosition ifNil: [ ^ nil ]
]

{ #category : 'private - metadata' }
STEptsConverter >> ballCoordinatesSeparator [
	"Answer the String that separates the ball coordinates in the raw line."

	^ (formatSpecificationNode elements at: self ballFormatIndex)
		  attributeAt: 'separator'
]

{ #category : 'private - metadata' }
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

{ #category : 'private - rawdata' }
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

{ #category : 'api' }
STEptsConverter >> copyRawDataStartingAtFrameCount: startFrameCount numberOfFrames: numberOfFrames asFileNamed: fileName [
	"Save the given number of consecutive frame lines starting at startFrameCount in a new file named fileName."

	| writeStream lineCounter frameCountMatcher currentLine |
	writeStream := fileName asFileReference writeStream.
	lineCounter := 0.
	rawDataStream position: 0.
	frameCountMatcher := startFrameCount asString , self topSeparator.
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

{ #category : 'private - metadata' }
STEptsConverter >> detectFormatSpecificationFor: rawLine [
	"Detect the right data format specification node for the given ByteString (rawLine) depending on the frame count bounds."

	^ self formatSpecificationNodes detect: [ :formatNode |
			  | topSeparator rawSublines frameCountString |
			  topSeparator := formatNode attributeAt: 'separator'.
			  rawSublines := rawLine substrings: topSeparator.
			  frameCountString := rawSublines at:
				                      (self frameCountIndexOf: formatNode).
			  self
				  isInFrameCountRange: formatNode
				  frameCount: frameCountString asNumber ]
]

{ #category : 'private - rawdata' }
STEptsConverter >> fillWriter [
	"Fill the writer with all frames."

	| validFrame |
	self reset.
	validFrame := self nextFrame.
	[ validFrame notNil ] whileTrue: [
			socMLWriter addFrame: validFrame.
			validFrame := self nextFrame ]
]

{ #category : 'private - metadata' }
STEptsConverter >> firstHalfInterval [
	"Answer the frame count interval for the game's first half. Answer nil if not available."

	| startValue endValue |
	startValue := self providerParameterValueAt: 'first_half_start'.
	endValue := self providerParameterValueAt: 'first_half_end'.
	(startValue isNil or: [ endValue isNil ]) ifTrue: [ ^ nil ].
	^ Interval from: startValue asInteger to: endValue asInteger
]

{ #category : 'private - metadata' }
STEptsConverter >> formatSpecificationNodes [
	"Answer the data format specification nodes collection."

	^ formatXmlDocument allElementsNamed: 'DataFormatSpecification'
]

{ #category : 'private - rawdata' }
STEptsConverter >> frameCount [
	"Answer the frame count in the current raw line."

	^ splittedRawLine at: self frameCountIndex
]

{ #category : 'private - metadata' }
STEptsConverter >> frameCountIndex [
	"Answer the frame count index for the current format specification node."

	^ self frameCountIndexOf: formatSpecificationNode
]

{ #category : 'private - metadata' }
STEptsConverter >> frameCountIndexOf: formatNode [
	"Answer the frame count's index derived from the formatNode."

	| index |
	index := 1.
	formatNode elementsDo: [ :element |
			(element name = 'StringRegister' and: [
				 (element attributeAt: 'name') = 'frameCount' ])
				ifTrue: [ ^ index ]
				ifFalse: [ index := index + 1 ] ].
	^ 0
]

{ #category : 'accessing' }
STEptsConverter >> framesPerSecond [

	^ (formatXmlDocument findElementNamed: 'FrameRate') contentString
]

{ #category : 'private - metadata' }
STEptsConverter >> hasHalfTime [
	"Answer true if there is a half time, otherwise false."

	^ self firstHalfInterval notNil and: [
		  self secondHalfInterval notNil ]
]

{ #category : 'initialization' }
STEptsConverter >> initializeWithMetadata: aStringOrStream rawData: aReadStream [
	"Initialize formatInXml and rawDataStream"

	formatXmlDocument := XMLDOMParser parse: aStringOrStream.
	rawDataStream := aReadStream.
	self reset.
]

{ #category : 'private - rawdata' }
STEptsConverter >> isFirstHalf [
	"Answer true if the frame belongs to the games first half, otherwise false."

	^ self firstHalfInterval rangeIncludes: self frameCount asInteger
]

{ #category : 'private - metadata' }
STEptsConverter >> isGoalkeeper: playerElement [
	"Answer true if the player element represents a goalkeeper, else false."

	^ (self
		   providerParameterValueAt: 'position_type'
		   inElement: playerElement) = 'Goalkeeper'
]

{ #category : 'private - metadata' }
STEptsConverter >> isInFrameCountRange: formatDataSpecification frameCount: aNumber [
	"Answer true if the anInteger is in the frame count range specified by the formataDataSpecification."

	| startFrame endFrame |
	startFrame := (formatDataSpecification attributeAt: 'startFrame')
		              asNumber.
	endFrame := (formatDataSpecification attributeAt: 'endFrame')
		            asNumber.
	^ aNumber between: startFrame and: endFrame
]

{ #category : 'private - rawdata' }
STEptsConverter >> isSecondHalf [
	"Answer true if the frame belongs to the games second half, otherwise false."

	^ self secondHalfInterval rangeIncludes: self frameCount asInteger
]

{ #category : 'private - rawdata' }
STEptsConverter >> newFrameBuilder [
	"Answer a new STSoccerFrameBuilder for the current raw line."

	"TODO: Changing fields at half time --> new Sequence element."

	^ (STSoccerFrameBuilder
		   newWithTeamLeft: (self teamNameOf: self teamLeftNode)
		   teamRight: (self teamNameOf: self teamRightNode)
		   pitch: self pitch
		   ball: (STBall newWithPosition: self ballPosition))
		  setModernSoccerStrategy;
		  officialTime: self frameCount;
		  framesPerSecond: self framesPerSecond;
		  yourself
]

{ #category : 'private - rawdata' }
STEptsConverter >> nextFrame [
	"Answer the next STSoccerFrame from the next raw line. Answer nil if there are no more lines."

	| frameBuilder |
	self advanceToNextValidRawLine ifNil: [ ^ nil ].

	frameBuilder := self newFrameBuilder.
	self playerNodes do: [ :playerNode |
			| playerId shirtNumber teamId isGoalkeeper |
			playerId := playerNode attributeAt: 'id'.
			teamId := playerNode attributeAt: 'teamId'.
			shirtNumber := playerNode contentStringAt: 'ShirtNumber'.
			isGoalkeeper := self isGoalkeeper: playerNode.
			(self playerPositions includesKey: playerId) ifTrue: [
					| playerPosition |
					playerPosition := self playerPositions at: playerId.
					teamId = (self teamIdOf: self teamLeftNode) ifTrue: [
							isGoalkeeper
								ifTrue: [
										frameBuilder
											createGoalkeeperInTeamLeftAtPosition: playerPosition
											number: shirtNumber ]
								ifFalse: [
										frameBuilder
											createPlayerInTeamLeftAtPosition: playerPosition
											number: shirtNumber ] ].
					teamId = (self teamIdOf: self teamRightNode) ifTrue: [
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

{ #category : 'private - metadata' }
STEptsConverter >> pitch [
	"Answer the pitch specified in the format file or the default pitch if not specified."

	| fieldSizeNode |
	fieldSizeNode := formatXmlDocument elementAt: 'FieldSize'.

	^ fieldSizeNode ifNil: [ STPitch newDefault ] ifNotNil: [
			  | width height |
			  width := fieldSizeNode elementAt: 'Width'.
			  height := fieldSizeNode elementAt: 'Height'.
			  STPitch extent: width asNumber @ height asNumber ]
]

{ #category : 'private - metadata' }
STEptsConverter >> playerChannelNodesForChannelId: channelId [
	"Answer a Collection of PlayerChannel elements with the given channelId."

	^ (formatXmlDocument findElementNamed: 'PlayerChannels')
		  descendantElementsSelect: [ :playerChannel |
			  (playerChannel attributeAt: 'channelId') = channelId ]
]

{ #category : 'private - metadata' }
STEptsConverter >> playerChannelNodesForX [
	"Answer a Collection of PlayerChannel elements with channelId='x'"

	^ self playerChannelNodesForChannelId: 'x'
]

{ #category : 'private - metadata' }
STEptsConverter >> playerChannelNodesForY [
	"Answer a Collection of PlayerChannel elements with channelId='y'"

	^ self playerChannelNodesForChannelId: 'y'
]

{ #category : 'private - metadata' }
STEptsConverter >> playerIdsForChannelNodes: chanelNode [
	"Answer a Dictionary with channel id as key and player id as value."

	^ chanelNode
		  inject: Dictionary new
		  into: [ :dictionary :channelNode |
				  dictionary
					  at: (channelNode attributeAt: 'id')
					  put: (channelNode attributeAt: 'playerId');
					  yourself ]
]

{ #category : 'private - metadata' }
STEptsConverter >> playerIdsForXChannels [
	"Answer a Dictionary with x channel id as key and player id as value."

	^ self playerIdsForChannelNodes: self playerChannelNodesForX
]

{ #category : 'private - metadata' }
STEptsConverter >> playerIdsForYChannels [
	"Answer a Dictionary with y channel id as key and player id as value."

	^ self playerIdsForChannelNodes: self playerChannelNodesForY
]

{ #category : 'private - metadata' }
STEptsConverter >> playerNodes [
	"Answer the player nodes collection."

	^ formatXmlDocument allElementsNamed: 'Player'
]

{ #category : 'private - rawdata' }
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
			self playerIdsForXChannels
				at: (playerChannelRef attributeAt: 'playerChannelId')
				ifPresent: [ :value |
						playerId := value.
						indexX := index ].
			self playerIdsForYChannels
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

{ #category : 'private - rawdata' }
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

{ #category : 'private - metadata' }
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

{ #category : 'private - metadata' }
STEptsConverter >> providerParameterValueAt: parameterName [
	"Answer the provider parameter value for the parameterName. Answer nil if not exisiting."

	^ self
		  providerParameterValueAt: parameterName
		  inElement: formatXmlDocument
]

{ #category : 'private - metadata' }
STEptsConverter >> providerParameterValueAt: parameterName inElement: topElement [
	"Answer the provider parameter value for the parameterName under topElement. Answer nil if not exisiting."

	| parameterElement |
	parameterElement := topElement
		                    findElementNamed: 'ProviderParameter'
		                    with: [ :element |
		                    (element contentStringAt: 'Name')
		                    = parameterName ].
	^ parameterElement ifNotNil: [
		  parameterElement contentStringAt: 'Value' ]
]

{ #category : 'initialization' }
STEptsConverter >> reset [
	"Reset rawDataStream and socMLWriter."

	rawDataStream position: 0.
	socMLWriter := nil.
	self nextFrame ifNotNil: [ :firstFrame |
			socMLWriter := STSoccerMLWriter onFirstFrame: firstFrame.
			socMLWriter sourceName: 'EPTS converter' ]
]

{ #category : 'private - metadata' }
STEptsConverter >> secondHalfInterval [
	"Answer the frame count interval for the game's second half. Answer nil if not available."

	| startValue endValue |
	startValue := self providerParameterValueAt: 'second_half_start'.
	endValue := self providerParameterValueAt: 'second_half_end'.
	(startValue isNil or: [ endValue isNil ]) ifTrue: [ ^ nil ].
	^ Interval from: startValue asInteger to: endValue asInteger
]

{ #category : 'private - rawdata' }
STEptsConverter >> splitNextRawLine [
	"Split the next raw line into frame count, players and ball."

	| currentRawLine topSeparator |
	currentRawLine := rawDataStream nextLine.
	formatSpecificationNode := self detectFormatSpecificationFor: currentRawLine.
	topSeparator := formatSpecificationNode attributeAt: 'separator'.
	splittedRawLine := currentRawLine substrings: topSeparator
]

{ #category : 'private - metadata' }
STEptsConverter >> teamIdOf: teamElement [
	"Answer the id of the given team element."

	^ teamElement attributeAt: 'id'
]

{ #category : 'private - rawdata' }
STEptsConverter >> teamLeftNode [
	"Answer the team now playing from left to right."

	self hasHalfTime ifFalse: [ ^ self teamLeftNodeAtFirstHalfTime ].
	self isFirstHalf ifTrue: [ ^ self teamLeftNodeAtFirstHalfTime ].
	self isSecondHalf ifTrue: [ ^ self teamRightNodeAtFirstHalfTime ]
]

{ #category : 'private - metadata' }
STEptsConverter >> teamLeftNodeAtFirstHalfTime [
	"Answer the team node for the team playing from left to right at the first half time or ever if no half time."

	^ self teamNodes
		  detect: [ :teamNode |
				  (teamNode
					   findElementNamed: 'ProviderParameter'
					   with: [ :parameter |
					   (parameter contentStringAt: 'Value') = 'left_to_right' ])
					  isNotNil ]
		  ifNone: [ self teamNodes first "guess" ]
]

{ #category : 'private - metadata' }
STEptsConverter >> teamNameOf: teamElement [
	"Answer the team name of the given team element."

	^ teamElement contentStringAt: 'Name'
]

{ #category : 'private - metadata' }
STEptsConverter >> teamNodes [
	"Answer the team nodes collection."

	^ formatXmlDocument allElementsNamed: 'Team'
]

{ #category : 'private - rawdata' }
STEptsConverter >> teamRightNode [
	"Answer the team now playing from right to left."

	self hasHalfTime ifFalse: [ ^ self teamRightNodeAtFirstHalfTime ].
	self isFirstHalf ifTrue: [ ^ self teamRightNodeAtFirstHalfTime ].
	self isSecondHalf ifTrue: [ ^ self teamLeftNodeAtFirstHalfTime ]
]

{ #category : 'private - metadata' }
STEptsConverter >> teamRightNodeAtFirstHalfTime [
	"Answer the team node for the team playing from right to left at the first half time or ever if no half time."

	^ self teamNodes
		  detect: [ :teamNode |
				  (teamNode
					   findElementNamed: 'ProviderParameter'
					   with: [ :parameter |
					   (parameter contentStringAt: 'Value') = 'right_to_left' ])
					  isNotNil ]
		  ifNone: [ self teamNodes last "guess" ]
]

{ #category : 'private - metadata' }
STEptsConverter >> topSeparator [

	^ formatSpecificationNode attributeAt: 'separator'
]

{ #category : 'private - metadata' }
STEptsConverter >> unitForAxis: axis [
	"Answer the unit for the given axis 'x', 'y' or 'z'."

	| xChannel |
	xChannel := formatXmlDocument
		            findElementNamed: 'Channel'
		            with: [ :element | (element attributeAt: 'id') = axis ].
	^ xChannel contentStringAt: 'Unit'
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

{ #category : 'private - rawdata' }
STEptsConverter >> xInMeters: rawXCoordinate [
	"Answer the raw x-coordinate converted from unit to meters."

	self xUnit = 'cm' ifTrue: [ ^ rawXCoordinate / 100 ].
	self xUnit = 'normalized' ifTrue: [
		^ (rawXCoordinate - 0.5) * self pitch extent x ].
	^ rawXCoordinate
]

{ #category : 'private - metadata' }
STEptsConverter >> xUnit [
	"Answer the unit for x coordinates."

	^ self unitForAxis: 'x'
]

{ #category : 'private - rawdata' }
STEptsConverter >> yInMeters: rawYCoordinate [
	"Answer the raw y-coordinate converted from unit to meters."

	self yUnit = 'cm' ifTrue: [ ^ rawYCoordinate / 100 ].
	self yUnit = 'normalized' ifTrue: [
		^ (rawYCoordinate - 0.5) * self pitch extent y ].
	^ rawYCoordinate
]

{ #category : 'private - metadata' }
STEptsConverter >> yUnit [
	"Answer the unit for y coordinates."

	^ self unitForAxis: 'y'
]
