"
I render the soccer pitch including all other soccer game shapes on it.

Currently using me: STGeometryVisualizer.
"
Class {
	#name : 'STSoccerSceneRoassal',
	#superclass : 'STSoccerScene',
	#category : 'SoccerTheory-Rendering-Roassal',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Roassal'
}

{ #category : 'adding' }
STSoccerSceneRoassal >> newShapeOnBall: aSTBall [
	"Answer a new STBallRSShape on a STBall."

	| centerPoint ballShape |
	ballShape := STBallRSShape newForBall: aSTBall.
	centerPoint := transformer toDevice: aSTBall position.
	^ ballShape
		  position: centerPoint;
		  yourself
]

{ #category : 'adding' }
STSoccerSceneRoassal >> newShapeOnPlayer: aSTPlayer [
	"Answert a new STPlayeRSShape on a STPlayer."

	^ STPlayerRSShape
		  newForPlayer: aSTPlayer
		  centerPoint: (transformer toDevice: aSTPlayer position)
]

{ #category : 'api' }
STSoccerSceneRoassal >> refreshCanvas: aRSCanvas [
	"Repopulate the play field with the current shapes."

	| playField |
	aRSCanvas @ RSCanvasController.

	aRSCanvas extent: self totalExtent.
	aRSCanvas color: (Color fromHexString: '66CC66'). "Moderate lime green border"

	playField := RSBox new
		             extent: self playFieldExtent;
		             color: (Color fromHexString: '009666'). "dark cyan - lime green"

	aRSCanvas shapes do: [ :shape | aRSCanvas removeShape: shape ].

	aRSCanvas add: playField.

	aRSCanvas addAll: (self teamLeft players collect: [ :player |
			 self newShapeOnPlayer: player ]).
	aRSCanvas addAll: (self teamRight players collect: [ :player |
			 self newShapeOnPlayer: player ]).
	aRSCanvas add: (self newShapeOnBall: self ball)
]
