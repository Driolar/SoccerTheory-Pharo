"
I render the soccer pitch including all other soccer game elements on it.

The STFrameEditor shows me.

I access to the soccer model through STSoccerFrame.

"
Class {
	#name : 'STSoccerScene',
	#superclass : 'BlElement',
	#instVars : [
		'transformer',
		'soccerFrame',
		'borderWidth',
		'ballShape',
		'graphicFactory'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STSoccerScene class >> newApplicationSceneWithFrame: aFrame graphicFactory: aGraphicFactory [
	"Answer a new instance for application purpose with the given STSoccerFrame and STGraphicFactory."

	^ self new
		  initializeForApplicationWithFrame: aFrame
		  graphicFactory: aGraphicFactory
]

{ #category : 'instance creation' }
STSoccerScene class >> newSampleSceneWithFrame: aFrame [
	"Answer a new instance for demo purpose with the given STSoccerFrame and STGraphicFactory."

	^ self new
		  initializeForSampleWithFrame: aFrame
		  graphicFactory: STGraphicFactory new
]

{ #category : 'creation' }
STSoccerScene >> addNewShapeOnBall: aBall [
	"Add a new STBallShape on a STBall."

	| centerPoint |
	ballShape := STBallShape
		             newForBall: aBall
		             graphicFactory: graphicFactory.
	centerPoint := transformer toDevice: aBall position.
	centerPoint := centerPoint + borderWidth.
	self attachChild: (ballShape centerPosition: centerPoint)
]

{ #category : 'creation' }
STSoccerScene >> addNewShapeOnPlayer: aPlayer [
	"Add a new STBallPlayer on a STPlayer."

	| playerShape centerPoint |
	playerShape := STPlayerShape
		               newWithPlayer: aPlayer
		               graphicFactory: graphicFactory.
	centerPoint := transformer toDevice: aPlayer position.
	centerPoint := centerPoint + borderWidth.
	self
		addChild: (playerShape centerPosition: centerPoint)
		before: ballShape "The ball must always be visible."
]

{ #category : 'creation' }
STSoccerScene >> addShapes [
	"Add all the shapes from the soccer frame."

	soccerFrame ball ifNotNil: [ :ball | self addNewShapeOnBall: ball ].
	soccerFrame teamLeft players do: [ :player |
		self addNewShapeOnPlayer: player ].
	soccerFrame teamRight players do: [ :player |
		self addNewShapeOnPlayer: player ]
]

{ #category : 'api - transformation' }
STSoccerScene >> borderWidth [ 
	"Answer the border width. This is temporary until refactoring."

	^borderWidth 
]

{ #category : 'initialization' }
STSoccerScene >> initializeForApplicationWithFrame: aFrame graphicFactory: aGraphicFactory [
	"Initialize for application purpose with the given STSoccerFrame and STGraphicFactory."

	soccerFrame := aFrame.
	graphicFactory := aGraphicFactory.
	borderWidth := 30.
	transformer := STCoordinatesTransformer
		               newForApplicationWithWorldExtent: aFrame pitch extent.
	self paintPitch.
	self paintGoals.
	self addShapes
]

{ #category : 'initialization' }
STSoccerScene >> initializeForSampleWithFrame: aFrame graphicFactory: aGraphicFactory [
	"Initialize for demo purpose with the given STSoccerFrame and STGraphicFactory."

	soccerFrame := aFrame.
	graphicFactory := aGraphicFactory.
	borderWidth := 10.
	transformer := STCoordinatesTransformer newForSampleWithWorldExtent:
		               aFrame pitch extent.
	self paintPitch.
	self paintGoals.
	self addShapes
]

{ #category : 'paint' }
STSoccerScene >> paintGoals [
	"Paint the left and the right goal on the pitch's border."

	| goalWidth goalDepth goalLeft goalRight goalPosition |
	goalWidth := (transformer scaleWorldPoint:
		              (Point x: 0 y: soccerFrame pitch goalWidth)) y.
	goalDepth := borderWidth / 2.

	goalPosition := Point
		                x: borderWidth - goalDepth
		                y:
		                self pitchExtent y / 2 + borderWidth
		                - (goalWidth / 2).
	goalLeft := BlElement new
		            size: (Point x: goalDepth y: goalWidth);
		            position: goalPosition;
		            background: (BlLinearGradientPaint horizontal
				             from: (Color colorFrom: soccerFrame teamLeft color1)
				             to: (Color colorFrom: soccerFrame teamLeft color2));
		            yourself.

	goalPosition := Point
		                x: self pitchExtent x + borderWidth
		                y: goalPosition y.
	goalRight := BlElement new
		             size: (Point x: goalDepth y: goalWidth);
		             position: goalPosition;
		            background: (BlLinearGradientPaint horizontal
				             from: (Color colorFrom: soccerFrame teamRight color1)
				             to: (Color colorFrom: soccerFrame teamRight color2));
		             yourself.

	self addChild: goalLeft.
	self addChild: goalRight
]

{ #category : 'paint' }
STSoccerScene >> paintGreen [
	"Paint the green lawn."

	self border:
		(BlBorder paint: (Color fromHexString: '66CC66') width: borderWidth). "Moderate lime green border"

	self size: self totalExtent.
	self background: (Color fromHexString: '009666') "dark cyan - lime green"
]

{ #category : 'paint' }
STSoccerScene >> paintMiddleLine [
	"Paint the middle line of the soccer pitch."

	| verticalMiddleLine horizontalMiddleLine middlePoint startPoint endPoint |
	middlePoint := transformer toDevice: soccerFrame pitch middle.
	startPoint := Point x: middlePoint x y: 0.
	endPoint := Point x: middlePoint x y: self pitchExtent y.

	verticalMiddleLine := BlLineGeometry
		                      from: startPoint + borderWidth
		                      to: endPoint + borderWidth.
	self addChild: (verticalMiddleLine asElement border:
			 (BlBorder paint: Color white width: 1)).

	horizontalMiddleLine := BlLineGeometry
		                        from: middlePoint - (4 @ 0) + borderWidth
		                        to: middlePoint + (4 @ 0) + borderWidth.
	self addChild: (horizontalMiddleLine asElement border:
			 (BlBorder paint: Color white width: 1))
]

{ #category : 'paint' }
STSoccerScene >> paintPitch [
	"Paint the pitch's green and middle line."

	self paintGreen.
	self paintMiddleLine
]

{ #category : 'private' }
STSoccerScene >> pitchExtent [ 
	"Answer the pitch's device extent."

	^transformer deviceExtent 
]

{ #category : 'api - transformation' }
STSoccerScene >> toWorld: aDevicePoint [
	"Transform device Point to world Point."

	^ transformer toWorld: aDevicePoint
]

{ #category : 'paint' }
STSoccerScene >> totalExtent [
	"Answer the total extent including pitch border"

	^ self pitchExtent + (2 * borderWidth)
]
