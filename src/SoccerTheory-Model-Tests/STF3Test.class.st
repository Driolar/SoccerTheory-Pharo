Class {
	#name : 'STF3Test',
	#superclass : 'TestCase',
	#instVars : [
		'actionManager',
		'playerA1',
		'playerA2',
		'playerA3',
		'playerB1',
		'playerB2',
		'playerB3'
	],
	#category : 'SoccerTheory-Model-Tests-Tests',
	#package : 'SoccerTheory-Model-Tests',
	#tag : 'Tests'
}

{ #category : 'running' }
STF3Test >> setUp [

	| frame |
	super setUp.
	frame := STSoccerFrameBuilder fixture3Frame.
	playerB1 := frame teamLeft playerWithJerseyNumber: 2.
	playerB2 := frame teamLeft playerWithJerseyNumber: 3.
	playerA1 := frame teamRight playerWithJerseyNumber: 2.
	playerA2 := frame teamRight playerWithJerseyNumber: 3.
	playerB3 := frame teamLeft playerWithJerseyNumber: 4.
	playerA3 := frame teamRight playerWithJerseyNumber: 4.
	actionManager := STActionManager newWithFrame: frame
]

{ #category : 'tests' }
STF3Test >> testCase10 [
	"Move A3 with ball between players A2 and B3."

	actionManager
		movePlayer: playerA3
		toPosition:
		(Point x: playerA2 position x + 5 y: playerA3 position y).
	actionManager moveBallToPosition:
		(Point x: playerA2 position x + 5 y: playerA3 position y).
	actionManager setClassicSoccerStrategy.
	self assert: playerA3 isCovered.
	actionManager setModernSoccerStrategy.
	self deny: playerA3 isCovered
]

{ #category : 'tests' }
STF3Test >> testCase11 [
	"Move A3 with ball between players B2 and A1."

	actionManager
		movePlayer: playerA3
		toPosition:
		(Point x: playerB2 position x + 5 y: playerA3 position y).
	actionManager moveBallToPosition:
		(Point x: playerB2 position x + 5 y: playerA3 position y).
	actionManager setClassicSoccerStrategy.
	self assert: playerA3 isCovered.
	self assert: playerA2 isCovered.
	actionManager setModernSoccerStrategy.
	self assert: playerA3 isCovered.
	self deny: playerA2 isCovered
]
