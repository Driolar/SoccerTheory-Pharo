"
I render the layer that shows the team's minimum spanning tree for one or each team.
"
Class {
	#name : 'STTeamSpanLayer',
	#superclass : 'STStrategyLayer',
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'rendering' }
STTeamSpanLayer >> render [

	self clearAll.
	scene attackingTeam
		ifNotNil: [ :attackingTeam |
		shapes add: (self shapeForTeam: attackingTeam) ]
		ifNil: [
				shapes add: (self shapeForTeam: scene teamLeft).
				shapes add: (self shapeForTeam: scene teamRight) ].
	shapes do: [ :shape | scene renderBeforeBall: shape ].
	scene signalUpdate
]

{ #category : 'rendering' }
STTeamSpanLayer >> shapeForTeam: aSTTeam [

	| playerPairs lineBuilder |
	playerPairs := (STTeamSpan newOnTeam: aSTTeam) connect.
	lineBuilder := RSLineBuilder line
		               color:
			               (Color fromHexString: aSTTeam gradientColorHigh);
		               dashed;
		               canvas: scene canvas;
		               useAssociations:
			               (playerPairs collect: [ :pair | pair asAssociation ]).
	^ lineBuilder asShape
]
