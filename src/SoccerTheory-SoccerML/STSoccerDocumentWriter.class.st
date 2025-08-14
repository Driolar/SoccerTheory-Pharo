"
I write SoccerML from a STSoccerFrame instance.
"
Class {
	#name : 'STSoccerDocumentWriter',
	#superclass : 'Object',
	#instVars : [
		'frame',
		'xmlWriter'
	],
	#category : 'SoccerTheory-SoccerML-Base',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'Base'
}

{ #category : 'instance creation' }
STSoccerDocumentWriter class >> on: aSTSoccerFrame [
	
	^ self new initializeWith: aSTSoccerFrame 
]

{ #category : 'writing' }
STSoccerDocumentWriter >> contents [

	^ xmlWriter contents
]

{ #category : 'api' }
STSoccerDocumentWriter >> document [
	"Answer the document written so far."

	^ xmlWriter contents
]

{ #category : 'initialization' }
STSoccerDocumentWriter >> initialize [

	super initialize.
	self resetXmlWriter
]

{ #category : 'initialization' }
STSoccerDocumentWriter >> initializeWith: aSTSoccerFrame [

	frame := aSTSoccerFrame
]

{ #category : 'initialization' }
STSoccerDocumentWriter >> resetXmlWriter [

	xmlWriter := XMLWriter new
		          enablePrettyPrinting;
		          yourself
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeBall [

	xmlWriter tag: 'soc:Ball' with: [
			self writePosition: frame ball position.
			self writePossessingTeam ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeDeclarations [ 

	self writeXmlDeclaration.
	self writeDoctypeDeclaration
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeDoctypeDeclaration [

	xmlWriter doctype
		root: 'DRIOLAR';
		systemID: 'soccerML.dtd'
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeFrame [

	| frameTag |
	frameTag := xmlWriter tag: 'soc:Frame'.
	frameTag attributeAt: 'time' put: (frame officialTime ifNil: [ '1' ]).
	frameTag with: [
			self writeBall.
			self writePlayers ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeGoalWidth [

	xmlWriter
		tag: 'soc:GoalWidth'
		with: (frame pitch goalWidth printShowingDecimalPlaces: 2)
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeHeader [

	xmlWriter tag: 'soc:Header' with: [
			self writeSource.
			self writeRules.
			self writePitch ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeOffside [

	xmlWriter tag: 'soc:Offside' with: 'none'
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writePitch [

	xmlWriter tag: 'soc:Pitch' with: [
			self writePitchLength.
			self writePitchWidth.
			self writeGoalWidth ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writePitchLength [

	xmlWriter
		tag: 'soc:Length'
		with: (frame pitch extent x printShowingDecimalPlaces: 1)
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writePitchWidth [

	xmlWriter
		tag: 'soc:Width'
		with: (frame pitch extent y printShowingDecimalPlaces: 1)
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writePlayer: aSTPlayer [

	| playerTag |
	playerTag := xmlWriter tag: 'soc:Player'.
	playerTag attributeAt: 'team' put: aSTPlayer team xmlSideCode.
	playerTag attributeAt: 'number' put: aSTPlayer jerseyNumber asString.
	aSTPlayer isGoalkeeper ifTrue: [
		playerTag attributeAt: 'isGoalie' put: 'true' ].

	playerTag with: [ self writePosition: aSTPlayer position ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writePlayers [

	frame teamLeft players do: [ :player | self writePlayer: player ].
	frame teamRight players do: [ :player | self writePlayer: player ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writePosition: aPoint [

	xmlWriter
		tag: 'soc:X' with: (aPoint x printShowingDecimalPlaces: 1);
		tag: 'soc:Y' with: (aPoint y printShowingDecimalPlaces: 1)
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writePossessingTeam [

	xmlWriter
		tag: 'soc:PossessingTeam'
		with: (frame ball owningTeam ifNotNil: [ :team | team xmlSideCode ])
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeRoot [

	| rootTag |
	rootTag := xmlWriter tag: 'DRIOLAR'.
	rootTag xmlnsAt: 'soc' put: 'http://driolar.org/SoccerML'.
	rootTag with: [
			self writeHeader.
			self writeSequence ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeRules [

	xmlWriter tag: 'soc:Rules' with: [ self writeOffside ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeSequence [
	"Write the sequence with the only one frame."

	xmlWriter tag: 'soc:Sequence' with: [
			self writeTeamLeft.
			self writeTeamRight.
			self writeFrame ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeSource [

	xmlWriter tag: 'soc:Source' with: 'Soccer Theory Suite'
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeTeamLeft [

	(xmlWriter tag: 'soc:Team')
		attributeAt: 'side' put: 'l';
		with: [ self writeTeamLeftName ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeTeamLeftName [

	self writeTeamNameOf: frame teamLeft
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeTeamNameOf: aSTTeam [

	xmlWriter tag: 'soc:TeamName' with: aSTTeam teamName
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeTeamRight [

	(xmlWriter tag: 'soc:Team')
		attributeAt: 'side' put: 'r';
		with: [ self writeTeamRightName ]
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeTeamRightName [

	self writeTeamNameOf: frame teamRight
]

{ #category : 'api' }
STSoccerDocumentWriter >> writeWholeDocument [
	"Answer the whole docuemnt after having built it entirely."

	self resetXmlWriter.
	self writeDeclarations.
	self writeRoot.
	^ self document
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeXmlDeclaration [

	xmlWriter xml encoding: 'UTF-8'
]

{ #category : 'writing' }
STSoccerDocumentWriter >> writeXmlns [

	(xmlWriter tag: 'DRIOLAR') xmlnsAt: 'soc' put: 'http://driolar.org/SoccerML'
]
