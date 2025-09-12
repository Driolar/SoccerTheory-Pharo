"
I am a wrapper for the EPTS metadata.
"
Class {
	#name : 'STEptsMetadata',
	#superclass : 'Object',
	#instVars : [
		'xmlDocument'
	],
	#category : 'SoccerTheory-SoccerML-Base',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'Base'
}

{ #category : 'instance creation' }
STEptsMetadata class >> on: aStringOrStream [
	"Answer an instance of mine wrapping the metadata defined in aStringOrStream xml."

	^ self new initializeWith: aStringOrStream
]

{ #category : 'api' }
STEptsMetadata >> detectFormatSpecificationFor: rawLine [
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

{ #category : 'accessing' }
STEptsMetadata >> firstHalfInterval [
	"Answer the frame count interval for the game's first half. Answer nil if not available."

	| startValue endValue |
	startValue := self providerParameterValueAt: 'first_half_start'.
	endValue := self providerParameterValueAt: 'first_half_end'.
	(startValue isNil or: [ endValue isNil ]) ifTrue: [ ^ nil ].
	^ Interval from: startValue asInteger to: endValue asInteger
]

{ #category : 'private' }
STEptsMetadata >> formatSpecificationNodes [
	"Answer the data format specification nodes collection."

	^ xmlDocument allElementsNamed: 'DataFormatSpecification'
]

{ #category : 'api' }
STEptsMetadata >> frameCountIndexOf: formatNode [
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
STEptsMetadata >> framesPerSecond [

	^ (xmlDocument findElementNamed: 'FrameRate') contentString
]

{ #category : 'api' }
STEptsMetadata >> hasHalfTime [
	"Answer true if there is a half time, otherwise false."

	^ self firstHalfInterval notNil and: [
		  self secondHalfInterval notNil ]
]

{ #category : 'initialization' }
STEptsMetadata >> initializeWith: aStringOrStream [
	"Initialize xml document defining the EPTS metadata."

	xmlDocument := XMLDOMParser parse: aStringOrStream
]

{ #category : 'api' }
STEptsMetadata >> isGoalkeeper: playerElement [
	"Answer true if the player element represents a goalkeeper, else false."

	^ (self
		   providerParameterValueAt: 'position_type'
		   inElement: playerElement) = 'Goalkeeper'
]

{ #category : 'private' }
STEptsMetadata >> isInFrameCountRange: formatDataSpecification frameCount: aNumber [
	"Answer true if the anInteger is in the frame count range specified by the formataDataSpecification."

	| startFrame endFrame |
	startFrame := (formatDataSpecification attributeAt: 'startFrame')
		              asNumber.
	endFrame := (formatDataSpecification attributeAt: 'endFrame')
		            asNumber.
	^ aNumber between: startFrame and: endFrame
]

{ #category : 'accessing' }
STEptsMetadata >> pitch [
	"Answer the pitch specified in the format file or the default pitch if not specified."

	| fieldSizeNode |
	fieldSizeNode := xmlDocument elementAt: 'FieldSize'.

	^ fieldSizeNode ifNil: [ STPitch newDefault ] ifNotNil: [
			  | width height |
			  width := fieldSizeNode elementAt: 'Width'.
			  height := fieldSizeNode elementAt: 'Height'.
			  STPitch extent: width asNumber @ height asNumber ]
]

{ #category : 'private' }
STEptsMetadata >> playerChannelNodesForChannelId: channelId [
	"Answer a Collection of PlayerChannel elements with the given channelId."

	^ (xmlDocument findElementNamed: 'PlayerChannels')
		  descendantElementsSelect: [ :playerChannel |
			  (playerChannel attributeAt: 'channelId') = channelId ]
]

{ #category : 'private' }
STEptsMetadata >> playerChannelNodesForX [
	"Answer a Collection of PlayerChannel elements with channelId='x'"

	^ self playerChannelNodesForChannelId: 'x'
]

{ #category : 'private' }
STEptsMetadata >> playerChannelNodesForY [
	"Answer a Collection of PlayerChannel elements with channelId='y'"

	^ self playerChannelNodesForChannelId: 'y'
]

{ #category : 'private' }
STEptsMetadata >> playerIdsForChannelNodes: chanelNode [
	"Answer a Dictionary with channel id as key and player id as value."

	^ chanelNode
		  inject: Dictionary new
		  into: [ :dictionary :channelNode |
				  dictionary
					  at: (channelNode attributeAt: 'id')
					  put: (channelNode attributeAt: 'playerId');
					  yourself ]
]

{ #category : 'accessing' }
STEptsMetadata >> playerIdsForXChannels [
	"Answer a Dictionary with x channel id as key and player id as value."

	^ self playerIdsForChannelNodes: self playerChannelNodesForX
]

{ #category : 'accessing' }
STEptsMetadata >> playerIdsForYChannels [
	"Answer a Dictionary with y channel id as key and player id as value."

	^ self playerIdsForChannelNodes: self playerChannelNodesForY
]

{ #category : 'accessing' }
STEptsMetadata >> playerNodes [
	"Answer the player nodes collection."

	^ xmlDocument allElementsNamed: 'Player'
]

{ #category : 'private' }
STEptsMetadata >> providerParameterValueAt: parameterName [
	"Answer the provider parameter value for the parameterName. Answer nil if not exisiting."

	^ self
		  providerParameterValueAt: parameterName
		  inElement: xmlDocument
]

{ #category : 'private' }
STEptsMetadata >> providerParameterValueAt: parameterName inElement: topElement [
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

{ #category : 'accessing' }
STEptsMetadata >> secondHalfInterval [
	"Answer the frame count interval for the game's second half. Answer nil if not available."

	| startValue endValue |
	startValue := self providerParameterValueAt: 'second_half_start'.
	endValue := self providerParameterValueAt: 'second_half_end'.
	(startValue isNil or: [ endValue isNil ]) ifTrue: [ ^ nil ].
	^ Interval from: startValue asInteger to: endValue asInteger
]

{ #category : 'private' }
STEptsMetadata >> teamIdOf: teamElement [
	"Answer the id of the given team element."

	^ teamElement attributeAt: 'id'
]

{ #category : 'private' }
STEptsMetadata >> teamLeftNodeAtFirstHalfTime [
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

{ #category : 'private' }
STEptsMetadata >> teamNameOf: teamElement [
	"Answer the team name of the given team element."

	^ teamElement contentStringAt: 'Name'
]

{ #category : 'private' }
STEptsMetadata >> teamNodes [
	"Answer the team nodes collection."

	^ xmlDocument allElementsNamed: 'Team'
]

{ #category : 'private' }
STEptsMetadata >> teamRightNodeAtFirstHalfTime [
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

{ #category : 'api' }
STEptsMetadata >> topSeparatorForFrameCount: aNumber [
	"Answer the top separator for the given frame count."

	| formatSpecificationNode |
	formatSpecificationNode := self formatSpecificationNodes detect: [
		                           :specNode |
		                           self
			                           isInFrameCountRange: specNode
			                           frameCount: aNumber ].
	^ formatSpecificationNode attributeAt: 'separator'
]

{ #category : 'private' }
STEptsMetadata >> unitForAxis: axis [
	"Answer the unit for the given axis 'x', 'y' or 'z'."

	| xChannel |
	xChannel := xmlDocument
		            findElementNamed: 'Channel'
		            with: [ :element | (element attributeAt: 'id') = axis ].
	^ xChannel contentStringAt: 'Unit'
]

{ #category : 'accessing' }
STEptsMetadata >> xUnit [
	"Answer the unit for x coordinates."

	^ self unitForAxis: 'x'
]

{ #category : 'accessing' }
STEptsMetadata >> yUnit [
	"Answer the unit for y coordinates."

	^ self unitForAxis: 'y'
]
