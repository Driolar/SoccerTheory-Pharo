Class {
	#name : 'STF4Test',
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
	#category : 'SoccerTheory-Tests-Model',
	#package : 'SoccerTheory-Tests-Model'
}

{ #category : 'running' }
STF4Test >> setUp [

	| frame |
	super setUp.
	frame := STSoccerFrameBuilder fixture4Frame.
	playerB1 := frame teamLeft playerWithJerseyNumber: 2.
	playerA1 := frame teamRight playerWithJerseyNumber: 2.
	playerB2 := frame teamLeft playerWithJerseyNumber: 3.
	playerA2 := frame teamRight playerWithJerseyNumber: 3.
	playerA3 := frame teamRight playerWithJerseyNumber: 4.
	playerB3 := frame teamLeft playerWithJerseyNumber: 4.
	actionManager := STActionManager newWithFrame: frame
]

{ #category : 'tests' }
STF4Test >> testCase [
	"Test initial position"

	actionManager setClassicSoccerStrategy.
	self assert: playerA3 isCovered.
	actionManager setModernSoccerStrategy.
	self deny: playerA3 isCovered
]

{ #category : 'tests' }
STF4Test >> testCase12 [
	"Pass Ball back to A3"

	actionManager moveBallToPosition: playerA3 position.
	actionManager setClassicSoccerStrategy.
	self assert: playerA3 isCovered.
	actionManager setModernSoccerStrategy.
	self deny: playerA3 isCovered
]

{ #category : 'tests' }
STF4Test >> testCase13 [
	"Move A3 between A1 and B2"

		actionManager
		movePlayer: playerA3
		toPosition: (Point x: playerA1 position x + 5 y: playerA3 position y).
	actionManager setClassicSoccerStrategy.
	self assert: playerA3 isCovered.
	actionManager setModernSoccerStrategy.
	self deny: playerA3 isCovered
]
