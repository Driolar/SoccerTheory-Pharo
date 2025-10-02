"
I am a visual soccer ball whose model is STBall.

I visualize which one is the owning team.

Also I am pullable.
"
Class {
	#name : 'STBallBlElement',
	#superclass : 'STMovableBlElement',
	#instVars : [
		'ball'
	],
	#category : 'SoccerTheory-Rendering-Bloc',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Bloc'
}

{ #category : 'instance creation' }
STBallBlElement class >> newForBall: aSTBall graphicFactory: aGraphicFactory playFieldExtent: aPoint [
	"Initialize with a STBall, a STGraphicFactory and the play field extent."

	^ self new initializeForBall: aSTBall graphicFactory: aGraphicFactory playFieldExtent: aPoint
]

{ #category : 'accessing' }
STBallBlElement >> ball [

	^ ball 
]

{ #category : 'private' }
STBallBlElement >> ballForm [ 
	"Answer my ball form."

	^ graphicFactory ballForm 
]

{ #category : 'private' }
STBallBlElement >> hideShadow [

	self border: BlBorder empty 
]

{ #category : 'private' }
STBallBlElement >> hoverTextString [
	"Answer the string for the hover text element."

	^ '(' , (ball position x printShowingDecimalPlaces: 1) , '@'
	  , (ball position y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'initialization' }
STBallBlElement >> initializeForBall: aSTBall graphicFactory: aSTGraphicFactory playFieldExtent: aPoint [
	"Initialize the shape instance for a given STBall."

	| ballIcon ballIconElement |
	ball := aSTBall.
	graphicFactory := aSTGraphicFactory.
	playFieldExtent := aPoint.
	self initializeEventHandling.

	squareExtent := 10 @ 10.
	self extent: squareExtent.
	self updateColor.
	ballIcon := self ballForm.
	ballIcon := ballIcon magnifyBy: 0.5.
	ballIconElement := ballIcon asElement.
	ballIconElement position: 1 @ 1.
	self addChild: ballIconElement
]

{ #category : 'accessing' }
STBallBlElement >> name [
	"Answer my name string."

	^ 'Ball'
]

{ #category : 'private' }
STBallBlElement >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	"Don't rely on self centerPosition here but use aPoint. Self centerposition may still answer the ancient position even after notifyPositionChanged. Timing problem?"

	^ STBallShapeMovedAnnouncement newWithTargetPosition: aPoint
]

{ #category : 'initialization' }
STBallBlElement >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self announcer
		when: STBallPossessionChangedAnnouncement
		do: [ :ann | self updateColor ]
		for: self
]

{ #category : 'private' }
STBallBlElement >> showShadow [

	self
		border: (BlBorder paint: Color black width: 1);
		beOutskirtsOutside
]

{ #category : 'private' }
STBallBlElement >> updateColor [
	"Update my color depending on the ball owning team."

	ball owningTeam
		ifNotNil: [ :team |
		self background: (Color colorFrom: team gradientColorHigh) ]
		ifNil: [ self background: self defaultBackground ]
]
