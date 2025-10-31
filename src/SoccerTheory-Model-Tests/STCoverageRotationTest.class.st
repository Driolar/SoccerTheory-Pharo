Class {
	#name : 'STCoverageRotationTest',
	#superclass : 'TestCase',
	#instVars : [
		'frameBuilder'
	],
	#category : 'SoccerTheory-Model-Tests-Tests',
	#package : 'SoccerTheory-Model-Tests',
	#tag : 'Tests'
}

{ #category : 'running' }
STCoverageRotationTest >> setUp [

	super setUp.

	frameBuilder := STSoccerFrameBuilder emptyWithPitch:
		                STPitch newDefault
]

{ #category : 'tests' }
STCoverageRotationTest >> testHorizontal [

	self testLeftPosition: 0 @ 0 rightPosition: 50 @ 0 expectedRadians: 0.
	self
		testLeftPosition: 50 @ 0
		rightPosition: 0 @ 0
		expectedRadians: Float pi
]

{ #category : 'tests' }
STCoverageRotationTest >> testLeftPosition: leftPosition rightPosition: rightPosition expectedRadians: radians [

	| playerLeft playerRight coveragePair |
	frameBuilder setBallPosessionLeft.
	playerLeft := frameBuilder
		              createPlayerInTeamLeftAtPosition: leftPosition
		              number: 2.
	playerRight := frameBuilder
		               createPlayerInTeamRightAtPosition: rightPosition
		               number: 2.
	coveragePair := STIndividualCoveragePair
		                newPlayer1: playerLeft
		                player2: playerRight.
	self assert: coveragePair coverageRotation closeTo: radians
]

{ #category : 'tests' }
STCoverageRotationTest >> testOverlapping [

	self testLeftPosition: 0 @ 0 rightPosition: 0 @ 0 expectedRadians: 0
]

{ #category : 'tests' }
STCoverageRotationTest >> testVertical [

	self
		testLeftPosition: 0 @ 0
		rightPosition: 0 @ 50
		expectedRadians: Float pi / 2.
	self
		testLeftPosition: 0 @ 50
		rightPosition: 0 @ 0
		expectedRadians: Float pi / -2
]
