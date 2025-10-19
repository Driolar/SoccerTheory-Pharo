"
I am a visual player whose model is STPlayer.

I visualize 
- my team color
- my jersey number
- if I am offside
- if I am uncovered
- if I am goalkeeper.

Also I am pullable.
"
Class {
	#name : 'STBlocPlayerShape',
	#superclass : 'STBlocMovableShape',
	#traits : 'STTPlayerShape',
	#classTraits : 'STTPlayerShape classTrait',
	#category : 'SoccerTheory-Graphics-Bloc',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Bloc'
}

{ #category : 'instance creation' }
STBlocPlayerShape class >> newWithPlayer: aPlayer graphicFactory: aGraphicFactory playFieldExtent: aPoint [
	"Answer a new player shape for the given STPlayer, STGraphicFactory and play field extent."

	^ self new
		  initializeForPlayer: aPlayer
		  graphicFactory: aGraphicFactory
		  playFieldExtent: aPoint
]

{ #category : 'private' }
STBlocPlayerShape >> goalkeeperElement [
	"Answer the goalkeeper BlElement."

	^ graphicFactory goalkeeperElement
]

{ #category : 'showing' }
STBlocPlayerShape >> hideOffside [
	"Remove the offside tag if present."

	self removeChildWithId: #offside
]

{ #category : 'private' }
STBlocPlayerShape >> hideShadow [
	"Show my shadow (when being deselected)."

	self effect: nil
]

{ #category : 'showing' }
STBlocPlayerShape >> hideUncovered [
		"Remove the uncovered tag if present."

	self removeChildWithId: #uncovered
]

{ #category : 'initialization' }
STBlocPlayerShape >> initializeForPlayer: aSTPlayer graphicFactory: aSTGraphicFactory playFieldExtent: aPoint [
	"Initialize the shape instance for a given STPlayer and a graphic factory."

	self player: aSTPlayer.
	graphicFactory := aSTGraphicFactory.
	self playFieldExtent: aPoint.
	self initializeEventHandling.

	squareExtent := 18 @ 18.
	self extent: squareExtent.
	self background: self jerseyGradient.
	self player isGoalkeeper ifTrue: [
		self addChild: (self goalkeeperElement position: 1 @ 1) ].
	self updateOffside.
	self updateUncovered
]

{ #category : 'private' }
STBlocPlayerShape >> jerseyGradient [
	"Answer the gradient for the field player's jersey."

	^ self team jerseyGradient 
]

{ #category : 'private' }
STBlocPlayerShape >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	"Don't rely on self centerPosition here but use aPoint. Self centerposition may still answer the ancient position even after notifyPositionChanged. Timing problem?"

	^ STPlayerShapeMovedAnnouncement
		  newOnPlayer: self player
		  targetPosition: aPoint
]

{ #category : 'private' }
STBlocPlayerShape >> offsideElement [
	"Answer the offside BlElement."

	^ self team isTeamLeft
		  ifTrue: [ graphicFactory offsideElement ]
		  ifFalse: [
				  graphicFactory offsideElement transform
					  flipY;
					  apply;
					  target ]
]

{ #category : 'showing' }
STBlocPlayerShape >> showOffside [
	"Tag me being offside."

	self
		childWithId: #offside
		ifNone: [ self addChild: self offsideElement as: #offside ]
]

{ #category : 'private' }
STBlocPlayerShape >> showShadow [
	"Show my shadow (when being selected)."

	self effect: (BlSimpleShadowEffect color: Color black offset: 2 @ 2)
]

{ #category : 'showing' }
STBlocPlayerShape >> showUncovered [
	"Tag me being uncovered."

	self
		childWithId: #uncovered
		ifNone: [ self addChild: self uncoveredElement as: #uncovered ]
]

{ #category : 'private' }
STBlocPlayerShape >> uncoveredElement [
	"Answer the uncovered BlElement."

	^ graphicFactory uncoveredElement
]

{ #category : 'showing' }
STBlocPlayerShape >> updateOffside [
	"Show or remove the offside flag reflecting the model."

	self isOffside
		ifTrue: [
			self hideUncovered.
			self showOffside ]
		ifFalse: [ self hideOffside ]
]

{ #category : 'showing' }
STBlocPlayerShape >> updateUncovered [
	"Show or remove the uncovered flag reflecting the model."

	self isOffside
		ifTrue: [ self hideUncovered ]
		ifFalse: [
				self isUncovered
					ifTrue: [ self showUncovered ]
					ifFalse: [ self hideUncovered ] ]
]
