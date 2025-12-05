Class {
	#name : 'STShortPathToGoalTest',
	#superclass : 'TestCase',
	#category : 'SoccerTheory-Model-Tests-Tests',
	#package : 'SoccerTheory-Model-Tests',
	#tag : 'Tests'
}

{ #category : 'tests' }
STShortPathToGoalTest >> testFixture1 [

	| path |
	path := STShortPathToGoal newOnTeam:
		        STSoccerFrameBuilder fixture1Frame teamLeft.
	self assert: path combinePath size equals: 1
]

{ #category : 'tests' }
STShortPathToGoalTest >> testFixture2TeamLeft [ 

	| path |
	path := (STShortPathToGoal newOnTeam:
		         STSoccerFrameBuilder fixture2Frame teamLeft) combinePath.
	self assert: path size equals: 2.
	"Nearest to ball:"
	self assert: path first jerseyNumber equals: 2.
	"Greatest shooting angle:"
	self assert: path last jerseyNumber equals: 3
]

{ #category : 'tests' }
STShortPathToGoalTest >> testFixture2TeamRight [ 

	| path |
	path := (STShortPathToGoal newOnTeam:
		         STSoccerFrameBuilder fixture2Frame teamRight) combinePath.
	self assert: path size equals: 1.
	"Nearest to ball:"
	self assert: path first jerseyNumber equals: 2.
	"Greatest shooting angle:"
	self assert: path last jerseyNumber equals: 2
]

{ #category : 'tests' }
STShortPathToGoalTest >> testFixture3TeamLeft [ 

	| path |
	path := (STShortPathToGoal newOnTeam:
		         STSoccerFrameBuilder fixture3Frame teamLeft) combinePath.
	self assert: path size equals: 1.
	"Nearest to ball:"
	self assert: path first jerseyNumber equals: 4.
	"Greatest shooting angle:"
	self assert: path last jerseyNumber equals: 4
]

{ #category : 'tests' }
STShortPathToGoalTest >> testFixture3TeamRight [ 

	| path |
	path := (STShortPathToGoal newOnTeam:
		         STSoccerFrameBuilder fixture3Frame teamRight) combinePath.
	self assert: path size equals: 3.
	"Nearest to ball:"
	self assert: path first jerseyNumber equals: 4.
	"Greatest shooting angle:"
	self assert: path last jerseyNumber equals: 2
]

{ #category : 'tests' }
STShortPathToGoalTest >> testFixture4TeamLeft [ 

	| path |
	path := (STShortPathToGoal newOnTeam:
		         STSoccerFrameBuilder fixture4Frame teamLeft) combinePath.
	self assert: path size equals: 3.
	"Nearest to ball:"
	self assert: path first jerseyNumber equals: 2.
	"Greatest shooting angle:"
	self assert: path last jerseyNumber equals: 4
]

{ #category : 'tests' }
STShortPathToGoalTest >> testFixture4TeamRight [ 

	| path |
	path := (STShortPathToGoal newOnTeam:
		         STSoccerFrameBuilder fixture4Frame teamRight) combinePath.
	self assert: path size equals: 1.
	"Nearest to ball:"
	self assert: path first jerseyNumber equals: 2.
	"Greatest shooting angle:"
	self assert: path last jerseyNumber equals: 2
]
