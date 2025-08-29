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
STEptsConverter >> ballIndex [
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
STEptsConverter >> detectFormatFor: rawLine [
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
STEptsConverter >> playerNodes [
	"Answer the player nodes collection."

	^ formatXmlDocument allElementsNamed: 'Player'
]

{ #category : 'private' }
STEptsConverter >> playersIndex [
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
	formatSpecificationNode := self detectFormatFor: currentRawLine.
	topSeparator := formatSpecificationNode attributeAt: 'separator'.
	splittedRawLine := currentRawLine substrings: topSeparator
]

{ #category : 'private' }
STEptsConverter >> teamNodes [
	"Answer the team nodes collection."

	^ formatXmlDocument allElementsNamed: 'Team'
]
