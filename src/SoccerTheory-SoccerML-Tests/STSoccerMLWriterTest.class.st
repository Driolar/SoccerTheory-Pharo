Class {
	#name : 'STSoccerMLWriterTest',
	#superclass : 'TestCase',
	#category : 'SoccerTheory-SoccerML-Tests',
	#package : 'SoccerTheory-SoccerML-Tests'
}

{ #category : 'instance creation' }
STSoccerMLWriterTest >> newWriter [

	^ STSoccerDocumentWriter on: STSoccerFrameBuilder fixture2Frame
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testDoctypeDeclaration [

	self
		assert: self newWriter writeDoctypeDeclaration contents trim
		equals: '<!DOCTYPE DRIOLAR SYSTEM "soccerML.dtd">'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testValidDocument [

	self
		shouldnt: [
				| writer |
				writer := self newWriter.
				writer writeWholeDocument.
				STSoccerDocumentReader parse: writer document ]
		raise: XMLValidationException
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteGoalWidth [

	self
		assert: self newWriter writeGoalWidth contents
		equals: '<soc:GoalWidth>7.32</soc:GoalWidth>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteLength [

	self
		assert: self newWriter writePitchLength contents
		equals: '<soc:Length>105.0</soc:Length>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteOffside [

	self
		assert: self newWriter writeOffside contents
		equals: '<soc:Offside>none</soc:Offside>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWritePosition [

	self
		assert: (self newWriter writePosition: -34.22 @ 13.2) contents
		equals: '<soc:X>-34.2</soc:X>
<soc:Y>13.2</soc:Y>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWritePossessingTeam [

	self
		assert: self newWriter writePossessingTeam contents
		equals: '<soc:PossessingTeam>l</soc:PossessingTeam>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteRules [

	self
		assert: self newWriter writeRules contents
		equals: '<soc:Rules>
    <soc:Offside>none</soc:Offside>
</soc:Rules>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteSource [

	self
		assert: self newWriter writeSource contents
		equals: '<soc:Source>Soccer Theory Suite</soc:Source>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteTeamLeft [

	self
		assert: self newWriter writeTeamLeft contents
		equals: '<soc:Team side="l">
    <soc:TeamName>Team A</soc:TeamName>
</soc:Team>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteTeamLeftName [

	self
		assert: self newWriter writeTeamLeftName contents
		equals: '<soc:TeamName>Team A</soc:TeamName>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteTeamRight [

	self
		assert: self newWriter writeTeamRight contents
		equals: '<soc:Team side="r">
    <soc:TeamName>Team B</soc:TeamName>
</soc:Team>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteTeamRightName [

	self
		assert: self newWriter writeTeamRightName contents
		equals: '<soc:TeamName>Team B</soc:TeamName>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWriteWidth [

	self
		assert: self newWriter writePitchWidth contents
		equals: '<soc:Width>68.0</soc:Width>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testXmlDeclaration [

	self
		assert: self newWriter writeXmlDeclaration contents
		equals: '<?xml version="1.0" encoding="UTF-8"?>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testXmlns [

	self
		assert: self newWriter writeXmlns contents
		equals: '<DRIOLAR xmlns:soc="http://driolar.org/SoccerML"/>'
]
