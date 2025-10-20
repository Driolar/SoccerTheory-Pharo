"
I am the abstract class for movable soccer shapes based on Roassal.
"
Class {
	#name : 'STRoassalMovableShape',
	#superclass : 'RSComposite',
	#traits : 'STTMovableShape',
	#classTraits : 'STTMovableShape classTrait',
	#instVars : [
		'shadowInteraction'
	],
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'initialization' }
STRoassalMovableShape >> addEventHandlers [

	self addMouseEventHandlers
]

{ #category : 'initialization' }
STRoassalMovableShape >> addMouseEventHandlers [

	self
		when: RSMouseDragEnd
		do: [
				self gameAnnouncer announce:
					(self newMovedAnnouncementWithTarget: self limitPosition) ]
		for: self.

	self
		when: RSMouseLeftClick
		do: [
				| wasSelected |
				wasSelected := self hasShadow.
				shadowInteraction removeShadowsOn: self canvas.
				self canvas removeInteractionIfPresent:
					STRoassalMoveByKeyInteraction.
				wasSelected ifFalse: [
						shadowInteraction onShape: self.
						self addInteraction: STRoassalMoveByKeyInteraction.
						self gameAnnouncer announce:
							(STMovableShapeSelectedAnnouncement newOn: self) ] ]
		for: self
]

{ #category : 'accessing' }
STRoassalMovableShape >> centerPosition [

	^ self position 
]

{ #category : 'accessing' }
STRoassalMovableShape >> centerPosition: aPoint [

	self position: aPoint.
	self signalUpdate
]

{ #category : 'private' }
STRoassalMovableShape >> exceedsLimits: aPoint [
	"Answer true if aPoint would exceed the pitch limits. Answer false if aPoint remains on pitch."

	^ ((aPoint x between: self minimalPoint x and: self maximalPoint x)
		   and: [
		   aPoint y between: self minimalPoint y and: self maximalPoint y ])
		  not
]

{ #category : 'private' }
STRoassalMovableShape >> hoverTextString [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
STRoassalMovableShape >> initialize [

	super initialize.
	shadowInteraction := RSShadowInteraction new
		                     shadowColor: Color gray;
		                     yourself
]

{ #category : 'private' }
STRoassalMovableShape >> stepTheArrowWay: aRSKeyDown [
	"Move me one step following the given keyboard key if it is an arrow key."

	| offset offsetPoint keyName |
	offset := 1.
	offsetPoint := nil.
	keyName := aRSKeyDown keyName.

	keyName = #LEFT ifTrue: [ offsetPoint := offset negated @ 0 ].
	keyName = #RIGHT ifTrue: [ offsetPoint := offset @ 0 ].
	keyName = #UP ifTrue: [ offsetPoint := 0 @ offset negated ].
	keyName = #DOWN ifTrue: [ offsetPoint := 0 @ offset ].

	offsetPoint ifNil: [ ^ self ].
	(self exceedsLimits: self position + offsetPoint) ifTrue: [ ^ self ].

	self translateBy: offsetPoint.
	self signalUpdate shape gameAnnouncer announce:
		(self newMovedAnnouncementWithTarget: self position)
]
