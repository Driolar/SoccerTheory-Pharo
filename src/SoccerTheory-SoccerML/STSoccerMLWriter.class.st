"
I support writing SoccerML documents.
"
Class {
	#name : 'STSoccerMLWriter',
	#superclass : 'XMLWriter',
	#instVars : [
		'sourceName',
		'pitch',
		'strategy',
		'framesPerSecond',
		'sequences',
		'runningFrameIndex'
	],
	#category : 'SoccerTheory-SoccerML-Base',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'Base'
}

{ #category : 'instance creation' }
STSoccerMLWriter class >> onFirstFrame: aSTSoccerFrame [

	^ self new initializeWithFrame: aSTSoccerFrame
]

{ #category : 'api' }
STSoccerMLWriter >> addFrame: aSTSoccerFrame [
	"Add the next frame to the current sequence."

	sequences last add: aSTSoccerFrame
]

{ #category : 'initialization' }
STSoccerMLWriter >> initialize [

	super initialize.
	sequences := OrderedCollection new.
	self startNewSequence.
	sourceName := 'Soccer Theory Suite'.
	self enablePrettyPrinting.
]

{ #category : 'initialization' }
STSoccerMLWriter >> initializeWithFrame: aSTSoccerFrame [
	"Set the header data."

	pitch := aSTSoccerFrame pitch.
	strategy := aSTSoccerFrame strategy.
	framesPerSecond := aSTSoccerFrame framesPerSecond.
	self addFrame: aSTSoccerFrame
]

{ #category : 'api' }
STSoccerMLWriter >> sourceName: aString [

	sourceName := aString
]

{ #category : 'api' }
STSoccerMLWriter >> startNewSequence [ 
	"Start a new sequence"

	sequences add: OrderedCollection new
]

{ #category : 'writing' }
STSoccerMLWriter >> writeAll [
	"Build the whole document."

	self writeDeclarations.
	self writeRoot.
	self close
]

{ #category : 'writing' }
STSoccerMLWriter >> writeBall: aSTBall [

	self tag: 'soc:Ball' with: [
			self writePosition: aSTBall position.
			self writeTeamPossessingBall: aSTBall ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeDeclarations [ 

	self writeXmlDeclaration.
	self writeDoctypeDeclaration
]

{ #category : 'writing' }
STSoccerMLWriter >> writeDoctypeDeclaration [

	self doctype
		root: 'DRIOLAR';
		systemID: 'soccerML.dtd'
]

{ #category : 'writing' }
STSoccerMLWriter >> writeFrame: aSTSoccerFrame [

	| frameTag |
	runningFrameIndex := runningFrameIndex + 1.
	frameTag := self tag: 'soc:Frame'.
	frameTag
		attributeAt: 'time'
		put: (aSTSoccerFrame officialTime ifNil: [ runningFrameIndex asString ]).
	frameTag with: [
			self writeBall: aSTSoccerFrame ball.
			self writePlayersFromFrame: aSTSoccerFrame ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeFramesPerSecond [

	framesPerSecond ifNotNil: [
		self tag: 'soc:FramesPerSecond' with: framesPerSecond ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeGoalWidth [

	self
		tag: 'soc:GoalWidth'
		with: (pitch goalWidth printShowingDecimalPlaces: 2)
]

{ #category : 'writing' }
STSoccerMLWriter >> writeHeader [

	self tag: 'soc:Header' with: [
			self writeSource.
			self writeRules.
			self writePitch.
			self writeFramesPerSecond ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeOffside [

	self tag: 'soc:Offside' with: strategy xmlText
]

{ #category : 'writing' }
STSoccerMLWriter >> writePitch [

	self tag: 'soc:Pitch' with: [
			self writePitchLength.
			self writePitchWidth.
			self writeGoalWidth ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writePitchLength [

	self
		tag: 'soc:Length'
		with: (pitch extent x printShowingDecimalPlaces: 1)
]

{ #category : 'writing' }
STSoccerMLWriter >> writePitchWidth [

	self
		tag: 'soc:Width'
		with: (pitch extent y printShowingDecimalPlaces: 1)
]

{ #category : 'writing' }
STSoccerMLWriter >> writePlayer: aSTPlayer [

	| playerTag |
	playerTag := self tag: 'soc:Player'.
	playerTag attributeAt: 'team' put: aSTPlayer team xmlSideCode.
	playerTag attributeAt: 'number' put: aSTPlayer jerseyNumber asString.
	aSTPlayer isGoalkeeper ifTrue: [
		playerTag attributeAt: 'isGoalie' put: 'true' ].

	playerTag with: [ self writePosition: aSTPlayer position ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writePlayersFromFrame: aSTSoccerFrame [

	aSTSoccerFrame teamLeft players do: [ :player | self writePlayer: player ].
	aSTSoccerFrame teamRight players do: [ :player | self writePlayer: player ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writePosition: aPoint [

	self
		tag: 'soc:X' with: (aPoint x printShowingDecimalPlaces: 1);
		tag: 'soc:Y' with: (aPoint y printShowingDecimalPlaces: 1)
]

{ #category : 'writing' }
STSoccerMLWriter >> writeRoot [

	| rootTag |
	rootTag := self tag: 'DRIOLAR'.
	rootTag xmlnsAt: 'soc' put: 'http://driolar.org/SoccerML'.
	rootTag with: [
			self writeHeader.
			self writeSequences ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeRules [

	self tag: 'soc:Rules' with: [ self writeOffside ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeSequence: sequenceFrames [
	"Write the sequence with all the frames."

	self tag: 'soc:Sequence' with: [
			self writeTeamLeft: sequenceFrames first teamLeft.
			self writeTeamRight: sequenceFrames first teamRight.
			sequenceFrames do: [ :frame | self writeFrame: frame ] ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeSequences [
	"Write successively all the sequences."

	runningFrameIndex := 0.
	sequences do: [ :sequenceFrames | self writeSequence: sequenceFrames ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeSource [

	self tag: 'soc:Source' with: sourceName
]

{ #category : 'writing' }
STSoccerMLWriter >> writeTeamLeft: aSTTeam [

	(self tag: 'soc:Team')
		attributeAt: 'side' put: 'l';
		with: [ self writeTeamNameOf: aSTTeam ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeTeamNameOf: aSTTeam [

	self tag: 'soc:TeamName' with: aSTTeam teamName
]

{ #category : 'writing' }
STSoccerMLWriter >> writeTeamPossessingBall: aSTBall [

	self
		tag: 'soc:PossessingTeam'
		with: (aSTBall owningTeam ifNotNil: [ :team | team xmlSideCode ])
]

{ #category : 'writing' }
STSoccerMLWriter >> writeTeamRight: aSTTeam [

	(self tag: 'soc:Team')
		attributeAt: 'side' put: 'r';
		with: [ self writeTeamNameOf: aSTTeam ]
]

{ #category : 'api' }
STSoccerMLWriter >> writeWholeDocument [
	"Answer the whole document after having built it entirely."

	self writeAll.
	^ self contents
]

{ #category : 'api' }
STSoccerMLWriter >> writeWholeDocumentToFileNamed: fileName [
	"Save the whole document to the file named fileName after having built it entirely."

	self stream: ((File named: fileName) openForWrite: true).
	self writeAll
]

{ #category : 'writing' }
STSoccerMLWriter >> writeXmlDeclaration [

	self xml encoding: 'UTF-8'
]

{ #category : 'writing' }
STSoccerMLWriter >> writeXmlns [

	(self tag: 'DRIOLAR')
		xmlnsAt: 'soc'
		put: 'http://driolar.org/SoccerML'
]
