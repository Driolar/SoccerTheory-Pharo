"
I render the layer that shows a favorable pass path from ball owner to goalgetter.

I draw:
- the passing lines from ball owner to goalgetter
- a circumference around the ball as far as the established ball owner
- a shooting line from goalgetter to goal (middle).
"
Class {
	#name : 'STShortPathToGoalLayer',
	#superclass : 'STStrategyLayer',
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'rendering' }
STShortPathToGoalLayer >> clearAll [

	self resetRotation.
	super clearAll
]

{ #category : 'private' }
STShortPathToGoalLayer >> goalLineMiddlePointAttackedBy: aSTTeam [
	"Answer the middle point of the goal line attacked by aSTTeam."

	^ aSTTeam isTeamLeft
		  ifTrue: [ scene rightGoalMiddlePoint ]
		  ifFalse: [ scene leftGoalMiddlePoint ]
]

{ #category : 'private' }
STShortPathToGoalLayer >> lineShapeForPassFromPlayer: player1 toPlayer: player2 [

	| playerShape1 playerShape2 |
	playerShape1 := self shapeFromModel: player1.
	playerShape2 := self shapeFromModel: player2.
	^ self passLineFrom: playerShape1 position to: playerShape2 position
]

{ #category : 'private' }
STShortPathToGoalLayer >> passLineFrom: fromPoint to: toPoint [

	| lineShape |
	lineShape := RSLine newFrom: fromPoint to: toPoint.
	lineShape width: 2.
	^ lineShape
]

{ #category : 'private' }
STShortPathToGoalLayer >> playerNearestToBall [
	"Answer the player nearest to the ball among all the players."

	^ self playerNearestToBallAmong:
		  (scene teamLeft players copyWithAll: scene teamRight players)
]

{ #category : 'private' }
STShortPathToGoalLayer >> playerNearestToBallAmong: players [
	"Answer the player nearest to the ball among the given players."

	^ players detectMin: [ :player | player distanceToBall ]
]

{ #category : 'rendering' }
STShortPathToGoalLayer >> render [

	| pathToGoal |
	self clearAll.
	pathToGoal := STShortPathToGoal newOnTeam: self shootingTeam.

	self renderCircumferenceAroundBallAsFarAsPlayer: pathToGoal ballOwner.

	pathToGoal combinePath overlappingPairsDo: [ :playerFrom :playerTo |
			| lineShape |
			lineShape := self
				             lineShapeForPassFromPlayer: playerFrom
				             toPlayer: playerTo.
			lineShape color:
				(Color colorFrom: self shootingTeam gradientColorHigh).
			self rotateShapeOfPlayer: playerFrom towardsPlayer: playerTo.
			scene renderBeforeBall: lineShape.
			shapes add: lineShape ].

	self rotateShapeOfGoalgetter: pathToGoal goalgetter.
	self renderShootingLineFrom: pathToGoal goalgetter.

	scene signalUpdate
]

{ #category : 'rendering' }
STShortPathToGoalLayer >> renderCircumferenceAroundBallAsFarAsPlayer: aSTPlayer [
	"Answer a circumference around the ball with the aSTPlayer on it."

	| circumference playerShape ballShape |
	playerShape := self shapeFromModel: aSTPlayer.
	ballShape := self shapeFromModel: aSTPlayer ball.
	circumference := RSCircle new
		                 center: ballShape position;
		                 radius:
			                 (ballShape position distanceTo:
					                  playerShape position);
		                 borderColor: aSTPlayer team gradientColorHigh;
		                 color: Color transparent;
		                 yourself.
	scene renderBeforeBall: circumference.
	shapes add: circumference
]

{ #category : 'rendering' }
STShortPathToGoalLayer >> renderShootingLineFrom: aSTPlayer [
	"Render the shooting line from aSTPlayer to goal (middle)."

	| line |
	line := self
		        shootLineFrom: (self shapeFromModel: aSTPlayer) position
		        to: (self goalLineMiddlePointAttackedBy: aSTPlayer team).
	line color: (Color colorFrom: aSTPlayer team gradientColorHigh).
	scene renderBeforeBall: line.
	shapes add: line
]

{ #category : 'rendering' }
STShortPathToGoalLayer >> rotateShapeOfGoalgetter: aSTPlayer [
	"Rotate the player shape of aSTPlayer towards the goal line middle point."

	self
		rotateShapeOfPlayer: aSTPlayer
		towardsPosition:
		(self goalLineMiddlePointAttackedBy: aSTPlayer team)
]

{ #category : 'rendering' }
STShortPathToGoalLayer >> rotateShapeOfPlayer: aSTPlayer towardsPlayer: targetPlayer [
	"Rotate the player shape of aSTPlayer towards the targetPlayer."

	self
		rotateShapeOfPlayer: aSTPlayer
		towardsPosition: (self shapeFromModel: targetPlayer) position
]

{ #category : 'rendering' }
STShortPathToGoalLayer >> rotateShapeOfPlayer: aSTPlayer towardsPosition: devicePoint [
	"Rotate the player shape of aSTPlayer towards devicePoint."

	| x y playerShape |
	playerShape := self shapeFromModel: aSTPlayer.
	x := playerShape position x - devicePoint x.
	y := playerShape position y - devicePoint y.
	playerShape rotateByRadians: (aSTPlayer team isTeamLeft
			 ifTrue: [ y negated arcTan: x negated ]
			 ifFalse: [ y arcTan: x ])
]

{ #category : 'private' }
STShortPathToGoalLayer >> shootLineFrom: fromPoint to: toPoint [

	| lineShape |
	lineShape := RSArrowedLine newFrom: fromPoint to: toPoint.
	lineShape width: 2.
	^ lineShape
]

{ #category : 'private' }
STShortPathToGoalLayer >> shootingTeam [
	"Answer the team the passing and shot path is drawn for."

	^ scene attackingTeam
		  ifNotNil: [ scene attackingTeam ]
		  ifNil: [ self playerNearestToBall team ]
]
