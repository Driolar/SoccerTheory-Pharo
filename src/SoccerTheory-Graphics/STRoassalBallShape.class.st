"
I am a visual soccer ball whose model is STBall.

I visualize which one is the owning team.

Also I am draggable.
"
Class {
	#name : 'STRoassalBallShape',
	#superclass : 'STRoassalMovableShape',
	#traits : 'STTBallShape',
	#classTraits : 'STTBallShape classTrait',
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
STRoassalBallShape class >> newForBall: aSTBall playFieldExtent: aPoint [

	^ self new initializeForBall: aSTBall playFieldExtent: aPoint
]

{ #category : 'private' }
STRoassalBallShape >> createBallShapes [

	^ OrderedCollection with: (STGraphicFactory new roassalBall
			   fromRectangle: (Rectangle center: 0 @ 0 extent: 64 @ 64);
			   scaleBy: 0.150;
			   yourself)
]

{ #category : 'initialization' }
STRoassalBallShape >> initializeForBall: aSTBall playFieldExtent: aPoint [

	self ball: aSTBall.
	self playFieldExtent: aPoint.
	self initializeEventHandling.

	self
		shapes: self createBallShapes;
		model: aSTBall;
		popupText: [ :node | self hoverTextString ];
		@ RSDraggable
]

{ #category : 'private' }
STRoassalBallShape >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	^ STBallShapeMovedAnnouncement newWithTargetPosition: aPoint
]

{ #category : 'private - layout' }
STRoassalBallShape >> updatePossession [

	self ball owningTeam
		ifNotNil: [ :team |
		self color: (Color colorFrom: team gradientColorHigh) ]
		ifNil: [ self color: self defaultColor ]
]
