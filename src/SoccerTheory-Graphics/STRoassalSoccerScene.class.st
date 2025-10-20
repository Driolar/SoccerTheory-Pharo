"
I render the soccer pitch including all other soccer game shapes on it.

Currently using me: STGeometryVisualizer.
"
Class {
	#name : 'STRoassalSoccerScene',
	#superclass : 'STSoccerScene',
	#instVars : [
		'offsideLine',
		'canvas',
		'attackLine',
		'ballShape'
	],
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'viewing' }
STRoassalSoccerScene class >> viewPresenterClass [
	"Answer the SpPresenter class for presenting my views."

	^ SpRoassalPresenter
]

{ #category : 'api' }
STRoassalSoccerScene >> addNewShapeOnPlayer: aPlayer [

	canvas addShape: (self newShapeOnPlayer: aPlayer) before: ballShape
]

{ #category : 'paint' }
STRoassalSoccerScene >> attackLineColor [

	^ self attackingTeam
		  ifNotNil: [ :team | Color colorFrom: team gradientColorHigh ]
		  ifNil: [ Color yellow ]
]

{ #category : 'private' }
STRoassalSoccerScene >> centerDash [

	^ RSLine new
		  startPoint: -4 @ 0;
		  endPoint: 4 @ 0;
		  color: Color white
]

{ #category : 'paint' }
STRoassalSoccerScene >> goalLeftShape [
	"Answer the RSBox representing the left goal."

	^ (self
		   goalShapeAtPosition: self leftGoalLineMiddle x @ 0
		   team: self teamLeft)
		  translateBy: (self deviceGoalDepth / 2) negated @ 0;
		  yourself
]

{ #category : 'paint' }
STRoassalSoccerScene >> goalRightShape [
	"Answer the RSBox representing the right goal."

	^ (self
		   goalShapeAtPosition: self rightGoalLineMiddle x @ 0
		   team: self teamRight)
		  translateBy: self deviceGoalDepth / 2 @ 0;
		  yourself
]

{ #category : 'paint' }
STRoassalSoccerScene >> goalShapeAtPosition: aPoint team: aSTTeam [
	"Answer the RSBox representing the goal."

	^ RSBox new
		  position: aPoint;
		  extent: self deviceGoalDepth @ self deviceGoalWidth;
		  color: aSTTeam gradientColorLow;
		  popupText: aSTTeam teamName;
		  yourself
]

{ #category : 'private' }
STRoassalSoccerScene >> leftGoalLineMiddle [

	^ (self playFieldExtent x / 2) negated @ 0
]

{ #category : 'private' }
STRoassalSoccerScene >> maximalPoint [
	"Answer the maximal device coordinates."

	^ transformer maximalDevicePoint
]

{ #category : 'private' }
STRoassalSoccerScene >> middleLine [

	^ RSLine new
		  startPoint: 0 @ self minimalPoint y;
		  endPoint: 0 @ self maximalPoint y;
		  color: Color white
]

{ #category : 'private' }
STRoassalSoccerScene >> minimalPoint [
	"Answer the minimal device coordinates."

	^ transformer minimalDevicePoint
]

{ #category : 'private' }
STRoassalSoccerScene >> newShapeOnBall: aSTBall [
	"Answer a new STBallRSShape on a STBall."

	| centerPoint newBallShape |
	newBallShape := STRoassalBallShape
		                newForBall: aSTBall
		                coordinatesTransformer: transformer.
	centerPoint := transformer toDevice: aSTBall position.
	^ newBallShape
		  position: centerPoint;
		  yourself
]

{ #category : 'private' }
STRoassalSoccerScene >> newShapeOnPlayer: aSTPlayer [
	"Answert a new STPlayeRSShape on a STPlayer."

	^ STRoassalPlayerShape
		  newForPlayer: aSTPlayer
		  centerPoint: (transformer toDevice: aSTPlayer position)
		  coordinatesTransformer: transformer
]

{ #category : 'api' }
STRoassalSoccerScene >> renderViewIn: aRSCanvas [
	"Repopulate the play field with the current shapes."

	| playField |
	canvas := aRSCanvas.
	canvas extent: self totalExtent.
	canvas color: self pitchSurroundingColor.

	playField := RSBox new
		             extent: self playFieldExtent;
		             color: self pitchColor.

	canvas shapes do: [ :shape | canvas removeShape: shape ].

	canvas
		add: playField;
		add: self middleLine;
		add: self centerDash;
		add: self goalLeftShape;
		add: self goalRightShape.

	canvas addAll: (self teamLeft players collect: [ :player |
			 self newShapeOnPlayer: player ]).
	canvas addAll: (self teamRight players collect: [ :player |
			 self newShapeOnPlayer: player ]).


	ballShape := self newShapeOnBall: self ball.
	canvas add: ballShape.
	self updateAttackLinePositionX: ballShape position x
]

{ #category : 'private' }
STRoassalSoccerScene >> rightGoalLineMiddle [

	^ self playFieldExtent x / 2 @ 0
]

{ #category : 'paint' }
STRoassalSoccerScene >> updateAttackLineAppearance [
	"Update the attack line appearance depending on the attacking team."

	attackLine color: self attackLineColor
]

{ #category : 'paint' }
STRoassalSoccerScene >> updateAttackLinePositionX: deviceX [
	"Lazy create and add the attack line shape and update its position."

	attackLine ifNil: [
			attackLine := STGraphicFactory new roassalAttackLine.
			canvas addShape: attackLine before: ballShape ].

	attackLine
		startPoint: deviceX @ self minimalPoint y;
		endPoint: deviceX @ self maximalPoint y.
	self updateAttackLineAppearance
]

{ #category : 'paint' }
STRoassalSoccerScene >> updateOffsideLinePositionX: worldX [
	"Lazy create and add the offside line shape and update its position."

	| deviceX |
	worldX ifNil: [
			offsideLine ifNotNil: [ canvas removeShape: offsideLine ].
			^ offsideLine := nil ].

	deviceX := (transformer toDevice: worldX asPoint) x.

	offsideLine ifNil: [
			offsideLine := STGraphicFactory new roassalOffsideLine.
			canvas addShape: offsideLine before: ballShape ].
	offsideLine
		startPoint: deviceX @ self minimalPoint y;
		endPoint: deviceX @ self maximalPoint y;
		color: self offsideLineColor
]
