"
I am a visual player whose model is STPlayer.

I visualize

•	my team color
•	my jersey number
•	if I am offside
•	if I am uncovered
•	if I am goalkeeper.


Also I am pullable.
"
Class {
	#name : 'STRoassalPlayerShape',
	#superclass : 'STRoassalMovableShape',
	#traits : 'STTPlayerShape',
	#classTraits : 'STTPlayerShape classTrait',
	#instVars : [
		'centerPoint'
	],
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
STRoassalPlayerShape class >> newForPlayer: aSTPlayer centerPoint: center coordinatesTransformer: aSTCoordinatesTransformer [

	^ self new
		  initializeForPlayer: aSTPlayer
		  centerPoint: center
		  coordinatesTransformer: aSTCoordinatesTransformer
]

{ #category : 'private' }
STRoassalPlayerShape >> createFieldPlayerShape [
	"Answer the field player's body."

	^ self team isTeamLeft
		  ifTrue: [
				  STGraphicFactory new
					  roassalLeftFieldPlayerWithCenter: centerPoint
					  color: self teamColor ]
		  ifFalse: [
				  STGraphicFactory new
					  roassalRightFieldPlayerWithCenter: centerPoint
					  color: self teamColor ]
]

{ #category : 'private' }
STRoassalPlayerShape >> createGoalkeeperShape [
	"Answer the field player's body."

	^ self team isTeamLeft
		  ifTrue: [
				  STGraphicFactory new
					  roassalLeftGoalkeeperWithCenter: centerPoint
					  color: self teamColor ]
		  ifFalse: [
				  STGraphicFactory new
					  roassalRightGoalkeeperWithCenter: centerPoint
					  color: self teamColor ]
]

{ #category : 'private' }
STRoassalPlayerShape >> createOffsideFlag [

	| flag |
	flag := self team isTeamLeft
		        ifTrue: [
			        STGraphicFactory new roassalFlagWavingToRightWithColor:
				        self distinctColor ]
		        ifFalse: [
			        STGraphicFactory new roassalFlagWavingToLeftWithColor:
				        self distinctColor ].

	^ flag
		  translateTo: centerPoint;
		  scaleBy: 0.7;
		  yourself
]

{ #category : 'private' }
STRoassalPlayerShape >> createUncoveredEye [

	| center correction |
	"Correct optical deceit."
	correction := self player isGoalkeeper
		              ifTrue: [ 0 ]
		              ifFalse: [ 2 ].
	center := self team isTeamLeft
		          ifTrue: [ centerPoint x - correction @ centerPoint y ]
		          ifFalse: [ centerPoint x + correction @ centerPoint y ].

	^ (STGraphicFactory new roassalEyeWithColor: self distinctColor)
		  fromRectangle: (Rectangle center: center extent: 22 @ 22);
		  scaleBy: 0.5;
		  yourself
]

{ #category : 'private' }
STRoassalPlayerShape >> distinctColor [
	"Answer a color that won't be coincide with my team color."

	^ (Color fromHexString: self teamColor) negated asHexString
]

{ #category : 'initialization' }
STRoassalPlayerShape >> initializeForPlayer: aSTPlayer centerPoint: center coordinatesTransformer: aSTCoordinatesTransformer [

	self player: aSTPlayer.
	centerPoint := center.
	self transformer: aSTCoordinatesTransformer.
	self initializeEventHandling.

	self
		refreshShapes;
		model: aSTPlayer;
		@ RSDraggable
]

{ #category : 'private' }
STRoassalPlayerShape >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	^ STPlayerShapeMovedAnnouncement
		  newOnPlayer: self player
		  targetPosition: aPoint
]

{ #category : 'accessing' }
STRoassalPlayerShape >> player [

	^ self model 
]

{ #category : 'accessing' }
STRoassalPlayerShape >> player: aSTPlayer [

	self model: aSTPlayer
]

{ #category : 'private' }
STRoassalPlayerShape >> refreshShapes [

	| group |
	group := RSGroup with: (self player isGoalkeeper
			          ifTrue: [ self createGoalkeeperShape ]
			          ifFalse: [ self createFieldPlayerShape ]).
	self isOffside
		ifTrue: [ group add: self createOffsideFlag ]
		ifFalse: [
		self isUncovered ifTrue: [ group add: self createUncoveredEye ] ].
	self
		resetChildren;
		shapes: group;
		popupText: self hoverTextString;
		signalUpdate
]

{ #category : 'private' }
STRoassalPlayerShape >> teamColor [

	^ self team gradientColorHigh
]

{ #category : 'showing' }
STRoassalPlayerShape >> updateOffside [

	self refreshShapes
]

{ #category : 'showing' }
STRoassalPlayerShape >> updateUncovered [

	self refreshShapes
]
