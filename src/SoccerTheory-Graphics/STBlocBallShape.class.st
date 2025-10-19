"
I am a visual soccer ball whose model is STBall.

I visualize which one is the owning team.

Also I am pullable.
"
Class {
	#name : 'STBlocBallShape',
	#superclass : 'STBlocMovableShape',
	#traits : 'STTBallShape',
	#classTraits : 'STTBallShape classTrait',
	#instVars : [
		'ball'
	],
	#category : 'SoccerTheory-Graphics-Bloc',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Bloc'
}

{ #category : 'instance creation' }
STBlocBallShape class >> newForBall: aSTBall graphicFactory: aGraphicFactory playFieldExtent: aPoint [
	"Initialize with a STBall, a STGraphicFactory and the play field extent."

	^ self new initializeForBall: aSTBall graphicFactory: aGraphicFactory playFieldExtent: aPoint
]

{ #category : 'private' }
STBlocBallShape >> ballForm [ 
	"Answer my ball form."

	^ graphicFactory ballForm 
]

{ #category : 'private' }
STBlocBallShape >> hideShadow [

	self border: BlBorder empty 
]

{ #category : 'initialization' }
STBlocBallShape >> initializeForBall: aSTBall graphicFactory: aSTGraphicFactory playFieldExtent: aPoint [
	"Initialize the shape instance for a given STBall."

	| ballIcon ballIconElement |
	ball := aSTBall.
	graphicFactory := aSTGraphicFactory.
	self playFieldExtent: aPoint.
	self initializeEventHandling.

	squareExtent := 10 @ 10.
	self extent: squareExtent.
	self updatePossession.
	ballIcon := self ballForm.
	ballIcon := ballIcon magnifyBy: 0.5.
	ballIconElement := ballIcon asElement.
	ballIconElement position: 1 @ 1.
	self addChild: ballIconElement
]

{ #category : 'private' }
STBlocBallShape >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	"Don't rely on self centerPosition here but use aPoint. Self centerposition may still answer the ancient position even after notifyPositionChanged. Timing problem?"

	^ STBallShapeMovedAnnouncement newWithTargetPosition: aPoint
]

{ #category : 'private' }
STBlocBallShape >> showShadow [

	self
		border: (BlBorder paint: Color black width: 1);
		beOutskirtsOutside
]

{ #category : 'private' }
STBlocBallShape >> updatePossession [
	"Update my color depending on the ball owning team."

	ball owningTeam
		ifNotNil: [ :team |
		self background: (Color colorFrom: team gradientColorHigh) ]
		ifNil: [ self background: self defaultBackground ]
]
