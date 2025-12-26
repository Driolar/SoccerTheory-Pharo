Class {
	#name : 'STMatchEventExtractorTest',
	#superclass : 'TestCase',
	#category : 'SoccerTheory-Statistics-Tests',
	#package : 'SoccerTheory-Statistics-Tests'
}

{ #category : 'tests' }
STMatchEventExtractorTest >> testEndpointPairing [


	| extractor |

	extractor := STMatchEventExtractor new.

	self assert:
		(extractor endpointPairsFrom: SortedCollection new) isEmpty.

	self
		assert: (extractor endpointPairsFrom: #( 5 ) asSortedCollection)
		equals: (SortedCollection with: 5 with: 5).
		
	self assert: (extractor endpointPairsFrom: #(1 2 3 5 6 8 10) asSortedCollection)
		equals: #(1 3 5 6 8 8 10 10) asSortedCollection.
		
	self assert: (extractor endpointPairsFrom: #(1 3 5 6 9 10) asSortedCollection)
		equals: #(1 1 3 3 5 6 9 10) asSortedCollection.
]

{ #category : 'tests' }
STMatchEventExtractorTest >> testTwoFrames [

	| extractor |
	extractor := STMatchEventExtractor onString: self twoFrames.
	extractor extract.
	self
		assert: extractor team1Extract possessionEndpoints
		equals: (SortedCollection with: 1 with: 1).
	self
		assert: extractor team2Extract possessionEndpoints
		equals: (SortedCollection with: 2 with: 2).
]

{ #category : 'tests' }
STMatchEventExtractorTest >> testWithInterruption [

	| extractor |
	extractor := STMatchEventExtractor onString: self withInterruption.
	extractor extract.
	self
		assert: extractor team1Extract possessionEndpoints
		equals: (SortedCollection with: 1 with: 2).
	self assert: extractor team2Extract possessionEndpoints isEmpty
]

{ #category : 'fixtures' }
STMatchEventExtractorTest >> twoFrames [

	^ '<soc:Sequence>
    <soc:Team side="l">
      <soc:TeamName>Team A</soc:TeamName>
    </soc:Team>
    <soc:Team side="r">
      <soc:TeamName>Team B</soc:TeamName>
    </soc:Team>
    <soc:Frame time="1">
      <soc:Ball>
        <soc:X>-20.0</soc:X>
        <soc:Y>0.0</soc:Y>
        <soc:PossessingTeam>l</soc:PossessingTeam>
      </soc:Ball>
      <soc:Player team="l" number="1" isGoalie="true">
        <soc:X>-52.5</soc:X>
        <soc:Y>0.0</soc:Y>
      </soc:Player>
    </soc:Frame>
	 <soc:Frame time="2">
      <soc:Ball>
        <soc:X>-20.0</soc:X>
        <soc:Y>0.0</soc:Y>
        <soc:PossessingTeam>r</soc:PossessingTeam>
      </soc:Ball>
      <soc:Player team="l" number="1" isGoalie="true">
        <soc:X>-52.5</soc:X>
        <soc:Y>0.0</soc:Y>
      </soc:Player>
    </soc:Frame>
  </soc:Sequence>'
]

{ #category : 'fixtures' }
STMatchEventExtractorTest >> withInterruption [

	^ '<soc:Sequence>
    <soc:Team side="l">
      <soc:TeamName>Team A</soc:TeamName>
    </soc:Team>
    <soc:Team side="r">
      <soc:TeamName>Team B</soc:TeamName>
    </soc:Team>
    <soc:Frame time="1">
      <soc:Ball>
        <soc:X>-20.0</soc:X>
        <soc:Y>0.0</soc:Y>
        <soc:PossessingTeam>l</soc:PossessingTeam>
      </soc:Ball>
      <soc:Player team="l" number="1" isGoalie="true">
        <soc:X>-52.5</soc:X>
        <soc:Y>0.0</soc:Y>
      </soc:Player>
    </soc:Frame>
	<soc:Frame time="1">
      <soc:Ball>
        <soc:X>-20.0</soc:X>
        <soc:Y>0.0</soc:Y>
        <soc:PossessingTeam>l</soc:PossessingTeam>
      </soc:Ball>
      <soc:Player team="l" number="1" isGoalie="true">
        <soc:X>-52.5</soc:X>
        <soc:Y>0.0</soc:Y>
      </soc:Player>
    </soc:Frame>
	 <soc:Frame time="2">
      <soc:Ball>
        <soc:X>-20.0</soc:X>
        <soc:Y>0.0</soc:Y>
        <soc:PossessingTeam>l</soc:PossessingTeam>
      </soc:Ball>
      <soc:Player team="l" number="1" isGoalie="true">
        <soc:X>-52.5</soc:X>
        <soc:Y>0.0</soc:Y>
      </soc:Player>
    </soc:Frame>
  </soc:Sequence>'
]
