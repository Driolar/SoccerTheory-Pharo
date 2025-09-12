Class {
	#name : 'STSoccerMLReaderTest',
	#superclass : 'TestCase',
	#category : 'SoccerTheory-SoccerML-Tests',
	#package : 'SoccerTheory-SoccerML-Tests'
}

{ #category : 'fixtures' }
STSoccerMLReaderTest >> soccerMLFixture2 [
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
STSoccerMLReaderTest >> soccerMLFixture2Broken [
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
STSoccerMLReaderTest >> soccerMLFixture2Invalid [
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

{ #category : 'fixtures' }
STSoccerMLReaderTest >> soccerMLFixtureOverHalfTime [
	"Answer the transition to second half time: one frame before, one after halftime."

	^ '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE DRIOLAR SYSTEM "soccerML.dtd">

<DRIOLAR xmlns:soc="http://driolar.org/SoccerML">
    <soc:Header>
        <soc:Source>EPTS converter</soc:Source>
        <soc:Rules>
            <soc:Offside>1925</soc:Offside>
        </soc:Rules>
        <soc:Pitch>
            <soc:Length>105.0</soc:Length>
            <soc:Width>68.0</soc:Width>
            <soc:GoalWidth>7.32</soc:GoalWidth>
        </soc:Pitch>
        <soc:FramesPerSecond>25</soc:FramesPerSecond>
    </soc:Header>
    <soc:Sequence>
        <soc:Team side="l">
            <soc:TeamName>Team B</soc:TeamName>
        </soc:Team>
        <soc:Team side="r">
            <soc:TeamName>Team A</soc:TeamName>
        </soc:Team>
        <soc:Frame time="69594">
            <soc:Ball>
                <soc:X>-6.7</soc:X>
                <soc:Y>-14.9</soc:Y>
                <soc:PossessingTeam/>
            </soc:Ball>
            <soc:Player team="l" number="28" isGoalie="true">
                <soc:X>-51.1</soc:X>
                <soc:Y>-3.0</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="18">
                <soc:X>-8.6</soc:X>
                <soc:Y>7.1</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="19">
                <soc:X>-15.1</soc:X>
                <soc:Y>-0.6</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="20">
                <soc:X>-12.7</soc:X>
                <soc:Y>-11.6</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="21">
                <soc:X>-5.4</soc:X>
                <soc:Y>-19.9</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="22">
                <soc:X>9.7</soc:X>
                <soc:Y>4.6</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="23">
                <soc:X>-4.2</soc:X>
                <soc:Y>-5.8</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="24">
                <soc:X>0.3</soc:X>
                <soc:Y>-9.1</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="25">
                <soc:X>7.1</soc:X>
                <soc:Y>-25.4</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="26">
                <soc:X>11.6</soc:X>
                <soc:Y>-3.2</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="27">
                <soc:X>9.8</soc:X>
                <soc:Y>-10.9</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="11" isGoalie="true">
                <soc:X>43.7</soc:X>
                <soc:Y>-3.3</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="1">
                <soc:X>10.2</soc:X>
                <soc:Y>-22.2</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="2">
                <soc:X>9.9</soc:X>
                <soc:Y>-10.1</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="3">
                <soc:X>14.5</soc:X>
                <soc:Y>-3.7</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="4">
                <soc:X>11.9</soc:X>
                <soc:Y>8.3</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="5">
                <soc:X>-2.8</soc:X>
                <soc:Y>-18.6</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="6">
                <soc:X>2.6</soc:X>
                <soc:Y>-10.3</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="7">
                <soc:X>-12.2</soc:X>
                <soc:Y>-12.2</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="8">
                <soc:X>4.9</soc:X>
                <soc:Y>-2.9</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="9">
                <soc:X>-3.1</soc:X>
                <soc:Y>4.9</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="10">
                <soc:X>-12.8</soc:X>
                <soc:Y>-2.3</soc:Y>
            </soc:Player>
        </soc:Frame>
    </soc:Sequence>
    <soc:Sequence>
        <soc:Team side="l">
            <soc:TeamName>Team A</soc:TeamName>
        </soc:Team>
        <soc:Team side="r">
            <soc:TeamName>Team B</soc:TeamName>
        </soc:Team>
        <soc:Frame time="70090">
            <soc:Ball>
                <soc:X>-0.1</soc:X>
                <soc:Y>0.0</soc:Y>
                <soc:PossessingTeam/>
            </soc:Ball>
            <soc:Player team="l" number="11" isGoalie="true">
                <soc:X>-41.9</soc:X>
                <soc:Y>0.3</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="1">
                <soc:X>-19.1</soc:X>
                <soc:Y>16.4</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="3">
                <soc:X>-22.4</soc:X>
                <soc:Y>-5.3</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="4">
                <soc:X>-12.8</soc:X>
                <soc:Y>-20.7</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="5">
                <soc:X>-2.3</soc:X>
                <soc:Y>18.3</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="6">
                <soc:X>-10.3</soc:X>
                <soc:Y>1.5</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="7">
                <soc:X>-0.2</soc:X>
                <soc:Y>-11.1</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="9">
                <soc:X>-0.9</soc:X>
                <soc:Y>-19.2</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="10">
                <soc:X>0.0</soc:X>
                <soc:Y>9.2</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="12">
                <soc:X>-23.7</soc:X>
                <soc:Y>4.1</soc:Y>
            </soc:Player>
            <soc:Player team="l" number="13">
                <soc:X>-11.2</soc:X>
                <soc:Y>-1.6</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="28" isGoalie="true">
                <soc:X>47.0</soc:X>
                <soc:Y>1.9</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="19">
                <soc:X>23.5</soc:X>
                <soc:Y>-14.2</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="20">
                <soc:X>21.2</soc:X>
                <soc:Y>5.8</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="21">
                <soc:X>18.7</soc:X>
                <soc:Y>25.9</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="22">
                <soc:X>10.9</soc:X>
                <soc:Y>-11.1</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="23">
                <soc:X>9.0</soc:X>
                <soc:Y>1.5</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="24">
                <soc:X>13.9</soc:X>
                <soc:Y>13.4</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="25">
                <soc:X>1.2</soc:X>
                <soc:Y>14.6</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="26">
                <soc:X>1.0</soc:X>
                <soc:Y>-11.6</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="27">
                <soc:X>-0.1</soc:X>
                <soc:Y>0.0</soc:Y>
            </soc:Player>
            <soc:Player team="r" number="29">
                <soc:X>17.9</soc:X>
                <soc:Y>-12.4</soc:Y>
            </soc:Player>
        </soc:Frame>
    </soc:Sequence>
</DRIOLAR>'
]

{ #category : 'tests' }
STSoccerMLReaderTest >> testBadFormed [

	self
		should: [ STSoccerDocumentReader parse: self soccerMLFixture2Broken ]
		raise: XMLWellFormednessException
]

{ #category : 'tests' }
STSoccerMLReaderTest >> testFrameCreation [

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
STSoccerMLReaderTest >> testFrameNodes [

	| reader |
	reader := STSoccerDocumentReader parse: self soccerMLFixture2.
	self assert: reader numberOfFrames equals: 1
]

{ #category : 'tests' }
STSoccerMLReaderTest >> testInvalid [

	self
		should: [
		STSoccerDocumentReader parse: self soccerMLFixture2Invalid ]
		raise: XMLValidationException
]

{ #category : 'tests' }
STSoccerMLReaderTest >> testKeepColor [

	| reader frameBefore frameAfter |
	reader := STSoccerDocumentReader parse:
		          self soccerMLFixtureOverHalfTime.
	self assert: reader frameNodes size equals: 2.

	frameBefore := (reader currentFrameIndex: 1) currentSoccerFrame.
	frameAfter := (reader currentFrameIndex: 2) currentSoccerFrame.
	self
		assert: frameBefore teamLeft gradientColorLow
		equals: frameAfter teamRight gradientColorLow
]

{ #category : 'tests' }
STSoccerMLReaderTest >> testTeamNames [

	| reader |
	reader := STSoccerDocumentReader parse: self soccerMLFixture2.
	self assert: reader teamLeftName equals: 'Team A'.
	self assert: reader teamRightName equals: 'Team B'
]

{ #category : 'tests' }
STSoccerMLReaderTest >> testWellFormed [

	self
		shouldnt: [ STSoccerDocumentReader parse: self soccerMLFixture2 ]
		raise: XMLWellFormednessException
]
