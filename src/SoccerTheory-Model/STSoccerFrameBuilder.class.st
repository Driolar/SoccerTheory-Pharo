"
I am a soccer frame builder.

I encapsulate a soccer frame that is beeing built.

I can create players at specific positions on the pitch.
I can set the team that possesses the ball.

Internally, I act using the STActionManager.
"
Class {
	#name : 'STSoccerFrameBuilder',
	#superclass : 'Object',
	#instVars : [
		'frame',
		'actionManager'
	],
	#category : 'SoccerTheory-Model-Operate',
	#package : 'SoccerTheory-Model',
	#tag : 'Operate'
}

{ #category : 'instance creation' }
STSoccerFrameBuilder class >> emptyFrameWithPitch: aPitch [

	| builder |
	builder := self new initializeWithPitch: aPitch.
	^ builder builtFrame
]

{ #category : 'examples' }
STSoccerFrameBuilder class >> fixture1Frame [
	"Return the following example frame 1 against 1:
	- One player A1 and B1 for each team A and B, 1 ball
	- A1[x] < ball[x] < A2[x]
	- Team A has ball possession.
	- Ancient offside rule is applied.
	It can be asserted that player a1 is covered and is not offside."
	
	| pitch middle ball frameBuilder |

	pitch := STPitch newDefault.
	middle := pitch middle.
	ball := STBall newWithPosition: (Point x: middle x - 20 y: middle y).
	frameBuilder := self 
		newWithTeamLeft: 'Team A'
		teamRight: 'Team B'
		pitch: pitch
		ball: ball.
	frameBuilder setAncientSoccerStrategy.
	frameBuilder setBallPosessionLeft.
   frameBuilder
		createPlayerInTeamLeftAtPosition: (Point x: middle x - 30 y: middle y)
		number: 2.
	frameBuilder
		createPlayerInTeamRightAtPosition: (Point x: middle x + 30 y: middle y)
		number: 2.
	^ frameBuilder builtFrame 	
]

{ #category : 'examples' }
STSoccerFrameBuilder class >> fixture2Frame [
	"Return the following example frame three against two:
	- Two outfield players A1, A2 for team A and two outfield players B1, B2 for team B, 1 ball.
	- A1[x] < A2[x] < B1[x] < B2[x]
	- Ball possession for player A1.
	- Each team has a goalkeeper.
	- Classic or modern offside rule may be applied.
	- Additional player A3[x] < A1[x] just for unit test 9"

	| pitch middle ball frameBuilder |
	pitch := STPitch newDefault.
	middle := pitch middle.
	ball := STBall newWithPosition: (Point x: middle x - 30 y: middle y).
	frameBuilder := self
		                newWithTeamLeft: 'Team A'
		                teamRight: 'Team B'
		                pitch: pitch
		                ball: ball.
	frameBuilder setBallPosessionLeft.
	frameBuilder
		createGoalkeeperInTeamLeftAtPosition:
		(Point x: middle x - 50 y: middle y)
		number: 1.
	frameBuilder
		createGoalkeeperInTeamRightAtPosition:
		(Point x: middle x + 50 y: middle y)
		number: 1.
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x - 30 y: middle y)
		number: 2.
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x - 10 y: middle y)
		number: 3.
	frameBuilder
		createPlayerInTeamRightAtPosition:
		(Point x: middle x + 10 y: middle y)
		number: 2.
	frameBuilder
		createPlayerInTeamRightAtPosition:
		(Point x: middle x + 30 y: middle y)
		number: 3.
	"Player A3 is just for test 9"
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x - 40 y: middle y)
		number: 4.
	^ frameBuilder builtFrame
]

{ #category : 'examples' }
STSoccerFrameBuilder class >> fixture3Frame [
	"Return the following example frame three against three:
	- Three outfield players for each team, 1 ball.
	- B1[x] < B2[x] < A1[x] < A2[x] < B3[x] < A3[x]
	- Ball possession for player A3.
	- Each team has a goalkeeper.
	- Classic or modern offside rule may be applied."

	| pitch middle ball frameBuilder |
	pitch := STPitch newDefault.
	middle := pitch middle.
	ball := STBall newWithPosition: (Point x: middle x + 20 y: middle y).
	frameBuilder := self
		                newWithTeamLeft: 'Team A'
		                teamRight: 'Team B'
		                pitch: pitch
		                ball: ball.
	frameBuilder setBallPosessionRight.
	frameBuilder
		createGoalkeeperInTeamLeftAtPosition:
		(Point x: middle x - 50 y: middle y)
		number: 1.
	frameBuilder
		createGoalkeeperInTeamRightAtPosition:
		(Point x: middle x + 50 y: middle y)
		number: 1.
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x - 30 y: middle y)
		number: 2.
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x - 20 y: middle y)
		number: 3.
	frameBuilder
		createPlayerInTeamRightAtPosition:
		(Point x: middle x - 10 y: middle y)
		number: 2.
	frameBuilder
		createPlayerInTeamRightAtPosition: (Point x: middle x y: middle y)
		number: 3.
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x + 10 y: middle y)
		number: 4.
	frameBuilder
		createPlayerInTeamRightAtPosition:
		(Point x: middle x + 20 y: middle y)
		number: 4.
	^ frameBuilder builtFrame
]

{ #category : 'examples' }
STSoccerFrameBuilder class >> fixture4Frame [
	"Return the following example frame three against three:
	- Three outfield players for each team, 1 ball.
	- B1[x] < A1[x] < B2[x] < A2[x] < A3[x] < B3[x]
	- Ball possession for player A1.
	- Each team has a goalkeeper.
	- Classic or modern offside rule may be applied.
	It can be asserted that A3 is uncovered for both offside rules."

	
	^ self fixture4FrameBuilder builtFrame
]

{ #category : 'examples' }
STSoccerFrameBuilder class >> fixture4FrameBuilder [
	"Return the builder for the following example frame three against three:
	- Three outfield players for each team, 1 ball.
	- B1[x] < A1[x] < B2[x] < A2[x] < A3[x] < B3[x]
	- Ball possession for player A1.
	- Each team has a goalkeeper.
	- Classic or modern offside rule may be applied.
	It can be asserted that A3 is uncovered for both offside rules."

	| pitch middle ball frameBuilder |
	pitch := STPitch newDefault.
	middle := pitch middle.
	ball := STBall newWithPosition: (Point x: middle x - 20 y: middle y).
	frameBuilder := self
		                newWithTeamLeft: 'Team A'
		                teamRight: 'Team B'
		                pitch: pitch
		                ball: ball.
	frameBuilder setBallPosessionRight.
	frameBuilder
		createGoalkeeperInTeamLeftAtPosition:
		(Point x: middle x - 50 y: middle y)
		number: 1.
	frameBuilder
		createGoalkeeperInTeamRightAtPosition:
		(Point x: middle x + 50 y: middle y)
		number: 1.
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x - 30 y: middle y)
		number: 2.
	frameBuilder
		createPlayerInTeamRightAtPosition:
		(Point x: middle x - 20 y: middle y)
		number: 2.
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x - 10 y: middle y)
		number: 3.
	frameBuilder
		createPlayerInTeamRightAtPosition: (Point x: middle x y: middle y)
		number: 3.
	frameBuilder
		createPlayerInTeamRightAtPosition:
		(Point x: middle x + 10 y: middle y)
		number: 4.
	frameBuilder
		createPlayerInTeamLeftAtPosition:
		(Point x: middle x + 20 y: middle y)
		number: 4.
	^ frameBuilder
]

{ #category : 'instance creation' }
STSoccerFrameBuilder class >> newWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall [
	
^ self new initializeWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall
]

{ #category : 'instance creation' }
STSoccerFrameBuilder class >> startFrameWithPitch: aPitch [

	| builder middle extent |
	builder := self new initializeWithPitch: aPitch.
	middle := aPitch middle.
	extent := aPitch extent.
	builder
		createGoalkeeperInTeamLeftAtPosition:
		(Point x: middle x - extent x / 2 y: aPitch middle y)
		number: 1.
	builder
		createGoalkeeperInTeamRightAtPosition:
		(Point x: middle x + extent x / 2 y: aPitch middle y)
		number: 1.
	^ builder builtFrame
]

{ #category : 'creation' }
STSoccerFrameBuilder >> builtFrame [
	^frame 
]

{ #category : 'private' }
STSoccerFrameBuilder >> createGoalkeeperInTeam: aTeam position: aPoint number: aSmallInteger [
	| player |
	player := STPlayer
		newWithPosition: aPoint
		team: aTeam
		frame: frame
		number: aSmallInteger.
	player makeGoalkeeper.
	actionManager addPlayer: player toTeam: aTeam
]

{ #category : 'creation' }
STSoccerFrameBuilder >> createGoalkeeperInTeamLeftAtPosition: aPoint number: aSmallInteger [
	^ self
		createGoalkeeperInTeam: frame teamLeft
		position: aPoint
		number: aSmallInteger
]

{ #category : 'creation' }
STSoccerFrameBuilder >> createGoalkeeperInTeamRightAtPosition: aPoint number: aSmallInteger [
	^ self
		createGoalkeeperInTeam: frame teamRight
		position: aPoint
		number: aSmallInteger
]

{ #category : 'private' }
STSoccerFrameBuilder >> createPlayerInTeam: aTeam position: aPoint number: aSmallInteger [
	| player |
	player := STPlayer
		newWithPosition: aPoint
		team: aTeam
		frame: frame
		number: aSmallInteger.
	actionManager addPlayer: player toTeam: aTeam.
	^ player
]

{ #category : 'creation' }
STSoccerFrameBuilder >> createPlayerInTeamLeftAtPosition: aPoint number: aSmallInteger [
	^ self createPlayerInTeam: frame teamLeft position: aPoint number: aSmallInteger
]

{ #category : 'creation' }
STSoccerFrameBuilder >> createPlayerInTeamRightAtPosition: aPoint number: aSmallInteger [
	^ self
		createPlayerInTeam: frame teamRight
		position: aPoint
		number: aSmallInteger
]

{ #category : 'initialization' }
STSoccerFrameBuilder >> initializeWithPitch: aPitch [

	frame := STSoccerFrame newWithPitch: aPitch.
	actionManager := STActionManager newWithFrame: frame
]

{ #category : 'initialization' }
STSoccerFrameBuilder >> initializeWithTeamLeft: aStringLeft teamRight: aStringRight pitch: aPitch ball: aBall [

	frame := STSoccerFrame
		newWithTeamLeft: aStringLeft
		teamRight: aStringRight
		pitch: aPitch
		ball: aBall.
	actionManager := STActionManager newWithFrame: frame.
]

{ #category : 'creation' }
STSoccerFrameBuilder >> setAncientSoccerStrategy [
	actionManager setAncientSoccerStrategy
]

{ #category : 'creation' }
STSoccerFrameBuilder >> setBallPosessionLeft [
	actionManager changeBallOwnerToTeam: frame teamLeft
]

{ #category : 'creation' }
STSoccerFrameBuilder >> setBallPosessionRight [
	actionManager changeBallOwnerToTeam: frame teamRight
]

{ #category : 'creation' }
STSoccerFrameBuilder >> setClassicSoccerStrategy [

	actionManager setClassicSoccerStrategy
]

{ #category : 'creation' }
STSoccerFrameBuilder >> setModernSoccerStrategy [ 

	actionManager setModernSoccerStrategy 
]
