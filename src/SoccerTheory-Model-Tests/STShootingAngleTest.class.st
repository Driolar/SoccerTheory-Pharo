Class {
	#name : 'STShootingAngleTest',
	#superclass : 'TestCase',
	#instVars : [
		'frame',
		'leftTeamPlayer',
		'rightTeamPlayer'
	],
	#category : 'SoccerTheory-Model-Tests-Tests',
	#package : 'SoccerTheory-Model-Tests',
	#tag : 'Tests'
}

{ #category : 'running' }
STShootingAngleTest >> setUp [

	super setUp.

	frame := STSoccerFrameBuilder emptyFrameWithPitch: STPitch newDefault.
	leftTeamPlayer := STPlayer
		                  newWithPosition: 0 @ 0
		                  team: frame teamLeft
		                  frame: frame
		                  number: 2.
	rightTeamPlayer := STPlayer
		                   newWithPosition: 0 @ 0
		                   team: frame teamRight
		                   frame: frame
		                   number: 2
]

{ #category : 'tests' }
STShootingAngleTest >> test60DegreesLeftPlayer [
	"I test the 60 degrees shoot angle, straight in front of the right goal."

	| distance |
	distance := (frame pitch goalWidth squared / 4 * 3) sqrt.
	leftTeamPlayer position: frame pitch rightGoalMiddlePoint x - distance @ frame pitch rightGoalMiddlePoint y.
	self assert: leftTeamPlayer shootingAngle =~ 60
]

{ #category : 'tests' }
STShootingAngleTest >> test60DegreesRightPlayer [
	"I test the 60 degrees shoot angle, straight in front of the left goal."

	| distance |
	distance := (frame pitch goalWidth squared / 4 * 3) sqrt.
	rightTeamPlayer position: frame pitch leftGoalMiddlePoint x + distance @ frame pitch leftGoalMiddlePoint y.
	self assert: rightTeamPlayer shootingAngle =~ 60
]

{ #category : 'tests' }
STShootingAngleTest >> testZeroDegreesLeftPlayer [
	"I test the zero degrees shoot angle on the right goal line."

	leftTeamPlayer position: frame pitch rightGoalMiddlePoint x @ (frame pitch rightGoalMiddlePoint y + (2 * frame pitch goalWidth)).
	self assert: leftTeamPlayer shootingAngle equals: 0
]

{ #category : 'tests' }
STShootingAngleTest >> testZeroDegreesRightPlayer [
	"I test the zero degrees shoot angle on the left goal line."

	rightTeamPlayer position: frame pitch leftGoalMiddlePoint x @ (frame pitch leftGoalMiddlePoint y + (2 * frame pitch goalWidth)).
	self assert: rightTeamPlayer shootingAngle equals: 0
]
