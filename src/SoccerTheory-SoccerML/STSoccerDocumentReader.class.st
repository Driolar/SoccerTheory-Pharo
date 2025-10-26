"
I read SoccerML to build corresponding STSoccerFrame instances.
"
Class {
	#name : 'STSoccerDocumentReader',
	#superclass : 'Object',
	#instVars : [
		'domParser',
		'frameBuilder',
		'currentFrameIndex',
		'teamColorGradientsHigh',
		'teamColorGradientsLow'
	],
	#category : 'SoccerTheory-SoccerML-Base',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'Base'
}

{ #category : 'instance creation' }
STSoccerDocumentReader class >> on: aStringOrStream [
	"Answer a new instance to read given SoccerML string or stream."

	^ self new initializeWith: (XMLDOMParser on: aStringOrStream)
]

{ #category : 'instance creation' }
STSoccerDocumentReader class >> onFileNamed: aFileName [
	"Answer a new instance to read the SoccerML file named aFileName."

	| domParser |
	domParser := XMLDOMParser onFileNamed: aFileName.

	"Undo the setting in #onFileNamed: for not searching soccerML.dtd at aFileName\soccerML.dtd."
	domParser documentURI: ''.

	^ self new initializeWith: domParser
]

{ #category : 'instance creation' }
STSoccerDocumentReader class >> parse: aStringOrStream [
	"Answer a new instance with parsed SoccerML."

	^ (self on: aStringOrStream) parse
]

{ #category : 'instance creation' }
STSoccerDocumentReader class >> parseFileNamed: aFileName [
	"Answer a new instance with parsed SoccerML."

	^ (self onFileNamed: aFileName) parse
]

{ #category : 'private - building' }
STSoccerDocumentReader >> addPlayers [
	"Add all players to the current STSoccerFrame being built."

	self currentFrameNode allElementsNamed: 'Player' do: [ :playerNode |
			| position playerNumber isGoalkeeper side |
			position := (playerNode contentStringAt: 'X') asNumber
			            @ (playerNode contentStringAt: 'Y') asNumber.
			playerNumber := (playerNode attributeAt: 'number') asNumber.
			isGoalkeeper := (playerNode attributeAt: 'isGoalie') = 'true'.
			side := playerNode attributeAt: 'team'.
			side = 'l' ifTrue: [
					isGoalkeeper
						ifFalse: [
								frameBuilder
									createPlayerInTeamLeftAtPosition: position
									number: playerNumber ]
						ifTrue: [
								frameBuilder
									createGoalkeeperInTeamLeftAtPosition: position
									number: playerNumber ] ].
			side = 'r' ifTrue: [
					isGoalkeeper
						ifFalse: [
								frameBuilder
									createPlayerInTeamRightAtPosition: position
									number: playerNumber ]
						ifTrue: [
								frameBuilder
									createGoalkeeperInTeamRightAtPosition: position
									number: playerNumber ] ] ]
]

{ #category : 'private - building' }
STSoccerDocumentReader >> createCurrentFrameBuilder [
	"Answer a new STSoccerFrameBuilder to begin the current frame element translation."

	| builder |
	self teamLeftName = self teamRightName ifTrue: [
		self error: 'Please ensure different team names.' ].


	builder := STSoccerFrameBuilder
		           newWithTeamLeft: self teamLeftName
		           teamRight: self teamRightName
		           pitch: self pitch
		           ball: (STBall newWithPosition: self currentBallPosition).

	"In case of switching fields at half time."
	teamColorGradientsLow
		at: self teamLeftName
		ifPresent: [ :gradient | builder teamLeftColorGradientLow: gradient ]
		ifAbsentPut: [ builder builtFrame teamLeft gradientColorLow ].

	teamColorGradientsLow
		at: self teamRightName
		ifPresent: [ :gradient |
		builder teamRightColorGradientLow: gradient ]
		ifAbsentPut: [ builder builtFrame teamRight gradientColorLow ].

	teamColorGradientsHigh
		at: self teamLeftName
		ifPresent: [ :gradient |
		builder teamLeftColorGradientHigh: gradient ]
		ifAbsentPut: [ builder builtFrame teamLeft gradientColorHigh ].

	teamColorGradientsHigh
		at: self teamRightName
		ifPresent: [ :gradient |
		builder teamRightColorGradientHigh: gradient ]
		ifAbsentPut: [ builder builtFrame teamRight gradientColorHigh ].

	^ builder
]

{ #category : 'private - traversing' }
STSoccerDocumentReader >> currentBallPosition [
	"Answer the ball position for the current frame node."

	| ballElement |
	ballElement := self currentFrameNode elementAt: 'Ball'.
	^ (ballElement contentStringAt: 'X') asNumber
	  @ (ballElement contentStringAt: 'Y') asNumber
]

{ #category : 'api' }
STSoccerDocumentReader >> currentFrameIndex: anInteger [

	currentFrameIndex := anInteger
]

{ #category : 'private - traversing' }
STSoccerDocumentReader >> currentFrameNode [
	"Answer the current soc:Frame node."

	^ self frameNodes at: currentFrameIndex
]

{ #category : 'api' }
STSoccerDocumentReader >> currentSoccerFrame [
	"Answer the current STsoccerFrame out of the document."

	frameBuilder := self createCurrentFrameBuilder.
	self setBallPossession.
	self setStrategy.
	self addPlayers.
	self setOfficialTime. 

	^ frameBuilder builtFrame
]

{ #category : 'private - traversing' }
STSoccerDocumentReader >> document [
	"Answer the parsed document."

	^ domParser document
]

{ #category : 'private - traversing' }
STSoccerDocumentReader >> frameNodes [
	"Answer the soc:Frame nodes."

	^ self document allElementsNamed: 'Frame'
]

{ #category : 'initialization' }
STSoccerDocumentReader >> initialize [

	super initialize.
	currentFrameIndex := 1.
	teamColorGradientsLow := Dictionary new.
	teamColorGradientsHigh := Dictionary new
]

{ #category : 'initialization' }
STSoccerDocumentReader >> initializeWith: aXMLDOMParser [
	"Initialize with the given parser."

	self initialize.
	domParser := aXMLDOMParser.
	domParser
		resolvesExternalEntities: true;
		usesNamespaces: true;
		isValidating: true
]

{ #category : 'api' }
STSoccerDocumentReader >> numberOfFrames [

	^ self frameNodes size
]

{ #category : 'initialization' }
STSoccerDocumentReader >> optimizeForLargeDocuments [
	"Disable usesNamespaces, isValidating and the document security read limit."

	domParser optimizeForLargeDocuments
]

{ #category : 'api' }
STSoccerDocumentReader >> parse [
	"Parse my document."

	domParser parseDocument
]

{ #category : 'api' }
STSoccerDocumentReader >> parseFirstFrame [
	"Parse the first frame of my document."

	domParser parseDocumentUntil: [
		self document notNil and: [ self numberOfFrames > 1 ] ]
]

{ #category : 'private - traversing' }
STSoccerDocumentReader >> pitch [
	"Answer the STPitch derived from the document."

	| pitchNode |
	pitchNode := self document findElementNamed: 'Pitch'.
	^ STPitch
		  extent: (pitchNode contentStringAt: 'Length') asNumber
			  @ (pitchNode contentStringAt: 'Width') asNumber
		  goalWidth: (pitchNode contentStringAt: 'GoalWidth') asNumber
]

{ #category : 'private - building' }
STSoccerDocumentReader >> setBallPossession [
	"Set the ball possession for the current STSoccerFrame being built."

	| ballElement |
	ballElement := self currentFrameNode elementAt: 'Ball'.

	(ballElement contentStringAt: 'PossessingTeam') = 'l' ifTrue: [
		frameBuilder setBallPosessionLeft ].
	(ballElement contentStringAt: 'PossessingTeam') = 'r' ifTrue: [
		frameBuilder setBallPosessionRight ]
]

{ #category : 'private - building' }
STSoccerDocumentReader >> setOfficialTime [

	frameBuilder officialTime:
		(self currentFrameNode attributeAt: 'time')
]

{ #category : 'private - building' }
STSoccerDocumentReader >> setStrategy [
	"Set the strategy for the current STSoccerFrame being built."

	| offside |
	offside := (self document findElementNamed: 'Offside') contentString.

	offside = 'none' ifTrue: [ frameBuilder setNoOffsideSoccerStrategy ].
	offside = '1925' ifTrue: [ frameBuilder setModernSoccerStrategy ].
	offside = '1866' ifTrue: [ frameBuilder setClassicSoccerStrategy ].
	offside = '1863' ifTrue: [ frameBuilder setAncientSoccerStrategy ]
]

{ #category : 'private - traversing' }
STSoccerDocumentReader >> teamLeftName [
	"Answer the name of team left."

	^ self teamNameAtSide: 'l'
]

{ #category : 'private - traversing' }
STSoccerDocumentReader >> teamNameAtSide: side [
	"Answer the name of the team at the given side 'l' or 'r'."

	^ (self currentFrameNode parent
		   findElementNamed: 'TeamName'
		   with: [ :each | (each parent attributeAt: 'side') = side ])
		  contentString
]

{ #category : 'private - traversing' }
STSoccerDocumentReader >> teamRightName [
	"Answer the name of team right."

	^ self teamNameAtSide: 'r'
]
