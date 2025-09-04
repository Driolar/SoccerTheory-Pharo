Class {
	#name : 'STSoccerMLWriterTest',
	#superclass : 'TestCase',
	#category : 'SoccerTheory-SoccerML-Tests',
	#package : 'SoccerTheory-SoccerML-Tests'
}

{ #category : 'instance creation' }
STSoccerMLWriterTest >> newSocMLWriter [

	^ STSoccerMLWriter new
]

{ #category : 'instance creation' }
STSoccerMLWriterTest >> newSoccerFrameDocumentWriter [

	^ STSoccerFrameDocumentWriter on: STSoccerFrameBuilder fixture2Frame
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testDoctypeDeclaration [

	self
		assert: self newSocMLWriter writeDoctypeDeclaration contents trim
		equals: '<!DOCTYPE DRIOLAR SYSTEM "soccerML.dtd">'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testValidDocument [

	self
		shouldnt: [
				| writer |
				writer := self newSoccerFrameDocumentWriter.
				STSoccerDocumentReader parse: writer writeWholeDocument ]
		raise: XMLValidationException
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testWritePosition [

	self
		assert: (self newSocMLWriter writePosition: -34.22 @ 13.2) contents
		equals: '<soc:X>-34.2</soc:X>
<soc:Y>13.2</soc:Y>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testXmlDeclaration [

	self
		assert: self newSocMLWriter writeXmlDeclaration contents
		equals: '<?xml version="1.0" encoding="UTF-8"?>'
]

{ #category : 'tests' }
STSoccerMLWriterTest >> testXmlns [

	self
		assert: self newSocMLWriter writeXmlns contents
		equals: '<DRIOLAR xmlns:soc="http://driolar.org/SoccerML"/>'
]
