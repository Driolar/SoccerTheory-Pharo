"
I render the shooting angle layer:
- I label the players with the shooting angle
- For the player with the greatest angle, I show the shooting (tri)angle and the circumference where the shooting angle is equal. 

The triangle passes through the two goalposts and the player's position.
The larger the angle, the better the chance of a score.

The circumference passes through the two goalposts and the player's position.
Outside the rendered circle, the angle is smaller. Inside, the angle is greater.
This is shown in:
- https://www.mathed.page/conics/soccer or
- http://datagenetics.com/blog/march12019/index.html
"
Class {
	#name : 'STShootingAngleLayer',
	#superclass : 'STStrategyLayer',
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'rendering' }
STShootingAngleLayer >> circumscribedCircleShapeFor: triangleVertices [

	| triangle |
	triangle := GTriangle vertices: triangleVertices.
	^ triangle isDegenerate
		  ifFalse: [
				  | circle |
				  circle := triangle circumscribedCircle.
				  RSCircle new
					  center: circle center;
					  radius: circle radius;
					  borderColor: scene pitchColor muchDarker;
					  color: Color transparent;
					  yourself ]
		  ifTrue: [ RSCircle size: 0 ]
]

{ #category : 'private' }
STShootingAngleLayer >> playerShapesOfPlayers: players [

	^ scene canvas shapesFromModels: players
]

{ #category : 'private' }
STShootingAngleLayer >> playerShapesOfTeam: aSTTeam [

	^ self playerShapesOfPlayers: aSTTeam players
]

{ #category : 'rendering' }
STShootingAngleLayer >> render [

	self clearAll.
	scene attackingTeam
		ifNotNil: [ :attackingTeam |
				attackingTeam isTeamLeft
					ifTrue: [ self renderForTeamLeft ]
					ifFalse: [ self renderForTeamRight ] ]
		ifNil: [
				self renderForTeamLeft.
				self renderForTeamRight ].
	shapes do: [ :shape | scene renderBeforeBall: shape ].
	scene signalUpdate
]

{ #category : 'rendering' }
STShootingAngleLayer >> renderForTeam: aSTTeam goalLineMiddlePoint: middlePoint [

	| goalGetter goalPost1 goalPost2 |
	goalGetter := (self playerShapesOfTeam: aSTTeam) detectMax: [ :playerShape | playerShape model shootingAngle ].
	goalPost1 := middlePoint x @ (middlePoint y + (scene deviceGoalWidth // 2)).
	goalPost2 := middlePoint x @ (middlePoint y - (scene deviceGoalWidth // 2)).
	shapes
		add: (self shootingAngleShapeForPlayer: goalGetter goalPost1: goalPost1 goalPost2: goalPost2);
		add: (self circumscribedCircleShapeFor: (Array with: goalGetter position with: goalPost1 with: goalPost2))
]

{ #category : 'rendering' }
STShootingAngleLayer >> renderForTeamLeft [

	self renderForTeam: scene teamLeft goalLineMiddlePoint: scene rightGoalLineMiddle
]

{ #category : 'rendering' }
STShootingAngleLayer >> renderForTeamRight [

	self renderForTeam: scene teamRight goalLineMiddlePoint: scene leftGoalLineMiddle
]

{ #category : 'rendering' }
STShootingAngleLayer >> shootingAngleShapeForPlayer: aSTRoassalPlayerShape goalPost1: goalPost1 goalPost2: goalPost2 [

	| centroid |
	centroid := aSTRoassalPlayerShape position + goalPost1 + goalPost2 / 3.

	^ (RSGroup new
		   add: ((RSLine newFrom: aSTRoassalPlayerShape position to: goalPost1)
				    color: scene pitchColor muchDarker;
				    yourself);
		   add: ((RSLine newFrom: aSTRoassalPlayerShape position to: goalPost2)
				    color: scene pitchColor muchDarker;
				    yourself);
		   add: (RSLabel new
				    text: aSTRoassalPlayerShape shootingAngleString;
				    position: centroid;
				    yourself);
		   yourself) asShape
]
