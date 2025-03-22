Class {
	#name : 'STF1Test',
	#superclass : 'TestCase',
	#instVars : [
		'actionManager',
		'playerA1',
		'playerB1'
	],
	#category : 'SoccerTheory-Tests-Model',
	#package : 'SoccerTheory-Tests-Model'
}

{ #category : 'running' }
STF1Test >> setUp [
	| frame |
	
	super setUp.
	frame := STSoccerFrameBuilder fixture1Frame.	 
	playerA1 := frame teamLeft players at: 1.
	playerB1 := frame teamRight players at: 1.
	actionManager := STActionManager newWithFrame: frame
]

{ #category : 'tests' }
STF1Test >> testCase1 [
	self deny: playerA1 isOffside.
	self assert: playerA1 isCovered
]

{ #category : 'tests' }
STF1Test >> testCase2 [
	"From setup, ball is at (Point x: middle x - 20 y: middle y) and playerA1 at (Point x: middle x - 30 y: middle y)."

	"Let playerA1 overtake the ball."
	actionManager
		movePlayer: playerA1
		toPosition: (Point x: playerA1 position x + 20 y: playerA1 position y).
	self assert: playerA1 isOffside.
	self assert: playerA1 isCovered
]

{ #category : 'tests' }
STF1Test >> testCase3 [
	"Let playerB1 overtake playerA1"

	actionManager
		movePlayer: playerB1
		toPosition: (Point x: (playerA1 position x - 10) y: playerB1 position y).
	self deny: playerA1 isOffside.

	"Now playerA1 is not covered, because playerB1 has abandoned the defense zone and there is no defender more within."
	self deny: playerA1 isCovered
]
