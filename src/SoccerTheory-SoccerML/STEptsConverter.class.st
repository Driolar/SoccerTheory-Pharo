"
I convert EPTS into SoccerML via STSoccerFrames.
The EPTS (Electronic Performance and Tracking Systems) format is described [here](https://quality.fifa.com/innovation/standards/epts/research-development-epts-standard-data-format) and also [here](https://gwood.me/epts).

I parse a raw data file according to the accompanying xml format specification.
This leads to frames without ball possession information.
Raw data and format specification may be complemented by an event file in json format.
Ball possession could be deduced from the events.

A data example can be found [here](https://github.com/metrica-sports/sample-data/tree/master/data/Sample_Game_3). 
"
Class {
	#name : 'STEptsConverter',
	#superclass : 'Object',
	#instVars : [
		'rawDataStream',
		'formatXmlDocument',
		'formatSpecificationNode',
		'splittedRawLine'
	],
	#category : 'SoccerTheory-SoccerML-Base',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'Base'
}

{ #category : 'formatting' }
STEptsConverter class >> format: aStringOrStream rawData: aReadStream [
	"Answer a new instance of STEptsConverter for the format in xml aStringOrStream and the raw data stream aReadStream."

	^ self new initializeWithFormat: aStringOrStream rawData: aReadStream
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
	"Answer the Point where the ball is located in meters."

	| ballCoordinates |
	ballCoordinates := (splittedRawLine at: self ballFormatIndex)
		                   substrings: self ballCoordinatesSeparator.
	^ (self xInMeters: ballCoordinates first asNumber)
	  @ (self xInMeters: (ballCoordinates at: 2) asNumber)
]

{ #category : 'private' }
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

{ #category : 'private' }
STEptsConverter >> formatSpecificationNodes [
	"Answer the data format specification nodes collection."

	^ formatXmlDocument allElementsNamed: 'DataFormatSpecification'
]

{ #category : 'private' }
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

{ #category : 'private' }
STEptsConverter >> inMeters: rawXCoordinate unit: unit [
	"Answer the raw coordinate converted from unit (cm or normalized) to meters."

	unit = 'cm' ifTrue: [ ^ rawXCoordinate / 100 ].
	"	unit = 'normalized'  ifTrue: [ TODO ]."
	^ rawXCoordinate
]

{ #category : 'initialization' }
STEptsConverter >> initializeWithFormat: aStringOrStream rawData: aReadStream [
	"Initialize formatInXml and rawDataStream"

	formatXmlDocument := XMLDOMParser parse: aStringOrStream.
	rawDataStream := aReadStream
]

{ #category : 'private' }
STEptsConverter >> isInFrameCountRange: formatDataSpecification frameCount: aNumber [
	"Answer true if the anInteger is in the frame count range specified by the formataDataSpecification."

	| startFrame endFrame |
	startFrame := (formatDataSpecification attributeAt: 'startFrame')
		              asNumber.
	endFrame := (formatDataSpecification attributeAt: 'endFrame')
		            asNumber.
	^ aNumber between: startFrame and: endFrame
]

{ #category : 'private' }
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

{ #category : 'private' }
STEptsConverter >> playerChannelNodesForChannelId: channelId [
	"Answer a Collection of PlayerChannel elements with the given channelId."

	^ (formatXmlDocument findElementNamed: 'PlayerChannels')
		  descendantElementsSelect: [ :playerChannel |
			  (playerChannel attributeAt: 'channelId') = channelId ]
]

{ #category : 'private' }
STEptsConverter >> playerChannelNodesForX [
	"Answer a Collection of PlayerChannel elements with channelId='x'"

	^ self playerChannelNodesForChannelId: 'x'
]

{ #category : 'private' }
STEptsConverter >> playerChannelNodesForY [
	"Answer a Collection of PlayerChannel elements with channelId='y'"

	^ self playerChannelNodesForChannelId: 'y'
]

{ #category : 'private' }
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

{ #category : 'private' }
STEptsConverter >> playerIdsForXChannels [
	"Answer a Dictionary with x channel id as key and player id as value."

	^ self playerIdsForChannelNodes: self playerChannelNodesForX
]

{ #category : 'private' }
STEptsConverter >> playerIdsForYChannels [
	"Answer a Dictionary with y channel id as key and player id as value."

	^ self playerIdsForChannelNodes: self playerChannelNodesForY
]

{ #category : 'private' }
STEptsConverter >> playerNodes [
	"Answer the player nodes collection."

	^ formatXmlDocument allElementsNamed: 'Player'
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

{ #category : 'private' }
STEptsConverter >> splitNextRawLine [
	"Split the next raw line into frame count, players and ball."

	| currentRawLine topSeparator |
	currentRawLine := rawDataStream nextLine.
	formatSpecificationNode := self detectFormatSpecificationFor: currentRawLine.
	topSeparator := formatSpecificationNode attributeAt: 'separator'.
	splittedRawLine := currentRawLine substrings: topSeparator
]

{ #category : 'private' }
STEptsConverter >> teamNodes [
	"Answer the team nodes collection."

	^ formatXmlDocument allElementsNamed: 'Team'
]

{ #category : 'private' }
STEptsConverter >> unitForAxis: axis [
	"Answer the unit for the given axis 'x', 'y' or 'z'."

	| xChannel |
	xChannel := formatXmlDocument
		            findElementNamed: 'Channel'
		            with: [ :element | (element attributeAt: 'id') = axis ].
	^ xChannel contentStringAt: 'Unit'
]

{ #category : 'private' }
STEptsConverter >> xInMeters: rawXCoordinate [
	"Answer the raw x-coordinate converted from unit to meters."

	^ self inMeters: rawXCoordinate unit: self xUnit
]

{ #category : 'private' }
STEptsConverter >> xUnit [
	"Answer the unit for x coordinates."

	^ self unitForAxis: 'x'
]

{ #category : 'private' }
STEptsConverter >> yInMeters: rawXCoordinate [
	"Answer the raw y-coordinate converted from unit to meters."

	^ self inMeters: rawXCoordinate unit: self yUnit
]

{ #category : 'private' }
STEptsConverter >> yUnit [
	"Answer the unit for y coordinates."

	^ self unitForAxis: 'y'
]
