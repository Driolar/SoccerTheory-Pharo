Class {
	#name : 'STF2Test',
	#superclass : 'TestCase',
	#instVars : [
		'actionManager',
		'playerA1',
		'playerA2',
		'playerB1',
		'playerB2',
		'playerA3'
	],
	#category : 'SoccerTheory-Tests-Model',
	#package : 'SoccerTheory-Tests-Model'
}

{ #category : 'running' }
STF2Test >> setUp [

	| frame |
	super setUp.
	frame := STSoccerFrameBuilder fixture2Frame.
	playerA1 := frame teamLeft playerWithJerseyNumber: 2.
	playerA2 := frame teamLeft playerWithJerseyNumber: 3.
	playerB1 := frame teamRight playerWithJerseyNumber: 2.
	playerB2 := frame teamRight playerWithJerseyNumber: 3.
	"Player A3 is just fort test 9"
	playerA3 := frame teamLeft playerWithJerseyNumber: 4.
	actionManager := STActionManager newWithPlay: frame
]

{ #category : 'tests' }
STF2Test >> testCase4 [
	"Place player A2 between players B1 and B2."

	actionManager
		movePlayer: playerA2
		toPosition: (Point x: playerB1 position x + 10 y: playerA2 position y).
	
	self assert: playerA2 isInOwnHalf not.
	
	actionManager setClassicSoccerStrategy.
	self assert: playerA2 isOffside.
	
	actionManager setModernSoccerStrategy.
	self deny: playerA2 isOffside
]

{ #category : 'tests' }
STF2Test >> testCase5 [
	"Place player A2 behind B2."

	actionManager
		movePlayer: playerA2
		toPosition: (Point x: playerB2 position x + 10 y: playerA2 position y).
	actionManager setClassicSoccerStrategy.
	self assert: playerA2 isOffside.
	actionManager setModernSoccerStrategy.
	self assert: playerA2 isOffside
]

{ #category : 'tests' }
STF2Test >> testCase6 [
	"Place player A1 with ball between B1 and B2."

	actionManager
		movePlayer: playerA1
		toPosition: (Point x: playerB1 position x + 10 y: playerA1 position y).
	actionManager
		moveBallToPosition: (Point x: playerB1 position x + 10 y: playerA1 position y).
	actionManager setClassicSoccerStrategy.
	self deny: playerA1 isOffside.
	actionManager setModernSoccerStrategy.
	self deny: playerA2 isOffside
]

{ #category : 'tests' }
STF2Test >> testCase7 [
	"Place player A1 with ball behind B2."

	actionManager
		movePlayer: playerA1
		toPosition: (Point x: playerB2 position x + 10 y: playerA1 position y).
	actionManager
		moveBallToPosition: (Point x: playerB2 position x + 10 y: playerA1 position y).
	actionManager setClassicSoccerStrategy.
	self deny: playerA2 isOffside.
	actionManager setModernSoccerStrategy.
	self deny: playerA2 isOffside
]

{ #category : 'tests' }
STF2Test >> testCase8 [
	"Place player B1 between A1 and A2."

	actionManager
		movePlayer: playerB1
		toPosition:
		(Point x: playerA2 position x - 10 y: playerB1 position y).

	self assert: playerA2 isInOwnHalf.
	actionManager setClassicSoccerStrategy.
	self deny: playerA2 isOffside.
	actionManager setModernSoccerStrategy.
	self deny: playerA2 isOffside.

	actionManager movePlayer: playerA2 toPosition: 0 @ 0. "middle of pitch"
	self assert: playerA2 isInOwnHalf.
	actionManager setClassicSoccerStrategy.
	self deny: playerA2 isOffside.
	actionManager setModernSoccerStrategy.
	self deny: playerA2 isOffside.

	actionManager movePlayer: playerA2 toPosition: 5 @ 5. 
	self deny: playerA2 isInOwnHalf.
	actionManager setClassicSoccerStrategy.
	self assert: playerA2 isOffside.
	actionManager setModernSoccerStrategy.
	self deny: playerA2 isOffside
]

{ #category : 'tests' }
STF2Test >> testCase9 [
	"Consider player A3 behind A1."

	actionManager setClassicSoccerStrategy.
	self assert: playerA3 isCovered.
	actionManager setModernSoccerStrategy.
	self deny: playerA3 isCovered 
]
