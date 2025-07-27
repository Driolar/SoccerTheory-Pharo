Class {
	#name : 'STSoccerMLTest',
	#superclass : 'TestCase',
	#category : 'SoccerTheory-SoccerML-Tests',
	#package : 'SoccerTheory-SoccerML-Tests'
}

{ #category : 'fixtures' }
STSoccerMLTest >> soccerMLFixture2 [
	"Answer the SoccerML for fixture 2 as a String."

	^ '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE DRIOLAR SYSTEM "soccerML.dtd">

<DRIOLAR xmlns:soc="http://driolar.org/SoccerML">
  <soc:Header>
    <soc:Source>Driolar Editor</soc:Source>
    <soc:Rules>
      <soc:Offside>none</soc:Offside>
    </soc:Rules>
    <soc:Pitch>
      <soc:Length>105.0</soc:Length>
      <soc:Width>68.0</soc:Width>
      <soc:GoalWidth>7.32</soc:GoalWidth>
    </soc:Pitch>
  </soc:Header>
  <soc:Sequence>
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
      <soc:Player team="l" number="2">
        <soc:X>-30.0</soc:X>
        <soc:Y>20.0</soc:Y>
      </soc:Player>
      <soc:Player team="l" number="3">
        <soc:X>-30.0</soc:X>
        <soc:Y>-20.0</soc:Y>
      </soc:Player>
      <soc:Player team="r" number="1" isGoalie="true">
        <soc:X>52.5</soc:X>
        <soc:Y>0.0</soc:Y>
      </soc:Player>
      <soc:Player team="r" number="2">
        <soc:X>30.0</soc:X>
        <soc:Y>20.0</soc:Y>
      </soc:Player>
      <soc:Player team="r" number="3">
        <soc:X>30.0</soc:X>
        <soc:Y>-20.0</soc:Y>
      </soc:Player>
    </soc:Frame>
  </soc:Sequence>
</DRIOLAR>'
]

{ #category : 'fixtures' }
STSoccerMLTest >> soccerMLFixture2Broken [
	"Answer the SoccerML for fixture 2 as a String but broken."

	^ '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE DRIOLAR SYSTEM "soccerML.dtd">

<DRIOLAR xmlns:soc="http://driolar.org/SoccerML">
  <soc:Header>
    <soc:Source>Driolar Editor</soc:Source>
    <soc:Rules>
      <soc:Offside>none</soc:Offside>
    </soc:Rules>
    <soc:Pitch>
      <soc:Length>105.0</soc:Length>
      <soc:Width>68.0</soc:Width>
      <soc:GoalWidth>7.32</soc:GoalWidth>
    </soc:Pitch>
  </soc:Header>
  <soc:Sequence>
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
      <soc:Player team="l" number="2">
        <soc:X>-30.0</soc:X>
        <soc:Y>20.0</soc:Y>
      </soc:Player>
      <soc:Player team="l" number="3">
        <soc:X>-30.0</soc:X>
        <soc:Y>-20.0</soc:Y>
      </soc:Player>
      <soc:Player team="r" number="1" isGoalie="true">
        <soc:X>52.5</soc:X>
        <soc:Y>0.0</soc:Y>
      </soc:Player>
      <soc:Player team="r" number="2">
        <soc:X>30.0</soc:X>
        <soc:Y>20.0</soc:Y>
      </soc:Player>
      <soc:Player team="r" number="3">
        <soc:X>30.0</soc:X>
        <soc:Y>-20.0</soc:Y>
      </soc:Player>
    </soc:Frame>
  </soc:Sequence>'
	"</DRIOLAR>"
]

{ #category : 'fixtures' }
STSoccerMLTest >> soccerMLFixture2Invalid [
	"Answer a well formed but invalid SoccerML for fixture 2 as a String."

	^ '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE DRIOLAR SYSTEM "soccerML.dtd">

<DRIOLAR xmlns:soc="http://driolar.org/SoccerML">
  <soc:Header>
    <soc:Source>Driolar Editor</soc:Source>
    <soc:Rules>
      <soc:Offside>none</soc:Offside>
    </soc:Rules>
    <soc:Pitch>
      <soc:Length>105.0</soc:Length>
      <soc:Width>68.0</soc:Width>
      <soc:GoalWidth>7.32</soc:GoalWidth>
    </soc:Pitch>
  </soc:Header>
  <soc:Sequence>
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
      <soc:Player team="l" number="2">
        <soc:X>-30.0</soc:X>
        <soc:Y>20.0</soc:Y>
      </soc:Player>
      <soc:Player team="l" number="3">
        <soc:X>-30.0</soc:X>
        <soc:X>-20.0</soc:X> "INVALID!"
      </soc:Player>
      <soc:Player team="r" number="1" isGoalie="true">
        <soc:X>52.5</soc:X>
        <soc:Y>0.0</soc:Y>
      </soc:Player>
      <soc:Player team="r" number="2">
        <soc:X>30.0</soc:X>
        <soc:Y>20.0</soc:Y>
      </soc:Player>
      <soc:Player team="r" number="3">
        <soc:X>30.0</soc:X>
        <soc:Y>-20.0</soc:Y>
      </soc:Player>
    </soc:Frame>
  </soc:Sequence>
</DRIOLAR>'
]

{ #category : 'tests' }
STSoccerMLTest >> testBadFormed [

	self
		should: [ STSoccerDocumentReader parse: self soccerMLFixture2Broken ]
		raise: XMLWellFormednessException
]

{ #category : 'tests' }
STSoccerMLTest >> testFrameCreation [

	| reader createdFrame |
	reader := STSoccerDocumentReader parse: self soccerMLFixture2.
	createdFrame := reader currentSoccerFrame.

	self assert: createdFrame owningTeam equals: createdFrame teamLeft.
	self assert: createdFrame ball position equals: -20.0 @ 0.0.
	self assert: createdFrame strategy isNone.
	self assert: createdFrame pitch extent equals: 105 @ 68.
	self assert: createdFrame pitch goalWidth equals: 7.32.
	self assert: createdFrame teamLeft players size equals: 3.
	self assert: createdFrame teamRight players size equals: 3.
	self
		assert: (createdFrame teamLeft players select: [ :player |
				 player isGoalkeeper ]) size
		equals: 1.
	self
		assert: (createdFrame teamRight players select: [ :player |
				 player isGoalkeeper ]) size
		equals: 1
]

{ #category : 'tests' }
STSoccerMLTest >> testFrameNodes [

	| reader |
	reader := STSoccerDocumentReader parse: self soccerMLFixture2.
	self assert: reader numberOfFrames equals: 1
]

{ #category : 'tests' }
STSoccerMLTest >> testInvalid [

	self
		should: [
		STSoccerDocumentReader parse: self soccerMLFixture2Invalid ]
		raise: XMLValidationException
]

{ #category : 'tests' }
STSoccerMLTest >> testTeamNames [

	| reader |
	reader := STSoccerDocumentReader parse: self soccerMLFixture2.
	self assert: reader teamLeftName equals: 'Team A'.
	self assert: reader teamRightName equals: 'Team B'
]

{ #category : 'tests' }
STSoccerMLTest >> testWellFormed [

	self
		shouldnt: [ STSoccerDocumentReader parse: self soccerMLFixture2 ]
		raise: XMLWellFormednessException
]
