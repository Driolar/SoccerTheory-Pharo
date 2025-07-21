"
I am a visual soccer ball whose model is STBall.

I visualize the owning team.

I am also pullable.
"
Class {
	#name : 'STBallShape',
	#superclass : 'STMovableShape',
	#instVars : [
		'ball'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STBallShape class >> newForBall: aBall graphicFactory: aGraphicFactory [
	"Initialize with a STBall and a STGraphicFactory"

	^ self new initializeForBall: aBall graphicFactory: aGraphicFactory
]

{ #category : 'private' }
STBallShape >> ballForm [ 
	"Answer my ball form."

	^ graphicFactory ballForm 
]

{ #category : 'private' }
STBallShape >> hideShadow [

	self border: BlBorder empty 
]

{ #category : 'private' }
STBallShape >> hoverTextString [
	"Answer the string for the hover text element."

	^ '(' , (ball position x printShowingDecimalPlaces: 1) , '@'
	  , (ball position y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'initialization' }
STBallShape >> initializeForBall: aSTBall graphicFactory: aSTGraphicFactory [
	"Initialize the shape instance for a given STBall."

	| ballIcon ballIconElement |
	ball := aSTBall.
	graphicFactory := aSTGraphicFactory.
	squareExtent := 10 @ 10.
	self extent: squareExtent.
	self updateColor.
	ballIcon := self ballForm.
	ballIcon := ballIcon magnifyBy: 0.5.
	ballIconElement := ballIcon asElement.
	ballIconElement position: (Point x: 1 y: 1).
	self addChild: ballIconElement
]

{ #category : 'accessing' }
STBallShape >> name [
	"Answer my name string."

	^ 'Ball'
]

{ #category : 'private' }
STBallShape >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	"Don't rely on self centerPosition here but use aPosition. Self centerposition may still answer the ancient position even after notifyPositionChanged. Timing problem?"

	^ STBallShapeMovedAnnouncement newWithTargetPosition: aPoint
]

{ #category : 'initialization' }
STBallShape >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self announcer
		when: STBallPossessionChangedAnnouncement
		do: [ :ann | self updateColor ]
		for: self
]

{ #category : 'private' }
STBallShape >> showShadow [

	self
		border: (BlBorder paint: Color black width: 1);
		beOutskirtsOutside
]

{ #category : 'private' }
STBallShape >> updateColor [
	"Update my color depending on the ball owning team."

	ball owningTeam
		ifNotNil: [ :team |
		self background: (Color colorFrom: team gradientColorHigh) ]
		ifNil: [ self background: self defaultBackground ]
]
