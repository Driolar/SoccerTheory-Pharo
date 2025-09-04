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
		'teamLeft',
		'teamRight',
		'frames',
		'framesPerSecond'
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
	"Add the next frame."

	frames add: aSTSoccerFrame
]

{ #category : 'initialization' }
STSoccerMLWriter >> initialize [

	super initialize.
	frames := OrderedCollection new.
	sourceName := 'Soccer Theory Suite'.
	self enablePrettyPrinting.
]

{ #category : 'initialization' }
STSoccerMLWriter >> initializeWithFrame: aSTSoccerFrame [
	"Set the header data."

	pitch := aSTSoccerFrame pitch.
	strategy := aSTSoccerFrame strategy.
	teamLeft := aSTSoccerFrame teamLeft.
	teamRight := aSTSoccerFrame teamRight.
	framesPerSecond := aSTSoccerFrame framesPerSecond.
	self addFrame: aSTSoccerFrame
]

{ #category : 'api' }
STSoccerMLWriter >> sourceName: aString [

	sourceName := aString
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
STSoccerMLWriter >> writeFrame: aSTSoccerFrame index: anInteger [

	| frameTag |
	frameTag := self tag: 'soc:Frame'.
	frameTag
		attributeAt: 'time'
		put: (aSTSoccerFrame officialTime ifNil: [ anInteger asString ]).
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
			self writeSequence ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeRules [

	self tag: 'soc:Rules' with: [ self writeOffside ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeSequence [
	"Write the sequence with all the frames."

	self tag: 'soc:Sequence' with: [
			self writeTeamLeft.
			self writeTeamRight.
			frames doWithIndex: [ :frame :index |
				self writeFrame: frame index: index ] ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeSource [

	self tag: 'soc:Source' with: sourceName
]

{ #category : 'writing' }
STSoccerMLWriter >> writeTeamLeft [

	(self tag: 'soc:Team')
		attributeAt: 'side' put: 'l';
		with: [ self writeTeamLeftName ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeTeamLeftName [

	self writeTeamNameOf: teamLeft
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
STSoccerMLWriter >> writeTeamRight [

	(self tag: 'soc:Team')
		attributeAt: 'side' put: 'r';
		with: [ self writeTeamRightName ]
]

{ #category : 'writing' }
STSoccerMLWriter >> writeTeamRightName [

	self writeTeamNameOf: teamRight
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
