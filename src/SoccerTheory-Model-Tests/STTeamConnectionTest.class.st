Class {
	#name : 'STTeamConnectionTest',
	#superclass : 'TestCase',
	#category : 'SoccerTheory-Model-Tests-Tests',
	#package : 'SoccerTheory-Model-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
STTeamConnectionTest >> testFixture1 [

	self testTeamConnection: STSoccerFrameBuilder fixture1Frame teamLeft.
	self testTeamConnection: STSoccerFrameBuilder fixture1Frame teamRight
]

{ #category : 'tests' }
STTeamConnectionTest >> testFixture2 [

	self testTeamConnection: STSoccerFrameBuilder fixture2Frame teamLeft.
	self testTeamConnection: STSoccerFrameBuilder fixture2Frame teamRight
]

{ #category : 'tests' }
STTeamConnectionTest >> testFixture3 [

	self testTeamConnection: STSoccerFrameBuilder fixture3Frame teamLeft.
	self testTeamConnection: STSoccerFrameBuilder fixture3Frame teamRight
]

{ #category : 'tests' }
STTeamConnectionTest >> testFixture4 [

	self testTeamConnection: STSoccerFrameBuilder fixture4Frame teamLeft.
	self testTeamConnection: STSoccerFrameBuilder fixture4Frame teamRight
]

{ #category : 'tests' }
STTeamConnectionTest >> testTeamConnection: aSTTeam [

	| spanningTree |
	spanningTree := STTeamSpan newOnTeam: aSTTeam.
	self
		assert: spanningTree connect size
		equals: aSTTeam players size - 1
]
