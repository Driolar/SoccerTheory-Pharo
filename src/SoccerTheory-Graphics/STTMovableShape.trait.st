"
I support the behavior of the movable shapes common to the various specific graphics.
"
Trait {
	#name : 'STTMovableShape',
	#instVars : [
		'playFieldExtent'
	],
	#category : 'SoccerTheory-Graphics-Basic',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Basic'
}

{ #category : 'initialization' }
STTMovableShape >> addEventHandlers [

	self explicitRequirement
]

{ #category : 'accessing' }
STTMovableShape >> ball [

	self subclassResponsibility
]

{ #category : 'accessing' }
STTMovableShape >> centerPosition [

	^ self explicitRequirement
]

{ #category : 'accessing' }
STTMovableShape >> centerPosition: aPoint [

	self explicitRequirement
]

{ #category : 'private' }
STTMovableShape >> gameAnnouncer [ 
	"Answer the announcer to send and receive announcements."

	^ self ball gameAnnouncer 
]

{ #category : 'initialization' }
STTMovableShape >> initializeEventHandling [

	self addEventHandlers.
	self registerAtAnnouncer
]

{ #category : 'private' }
STTMovableShape >> limitPosition [
	"Limit the current center position to the play field's extent if necessary. Answer the limited center position."

	| limitedPosition |
	limitedPosition := self limitedPosition.
	limitedPosition = self centerPosition ifFalse: [
		self centerPosition: limitedPosition ].
	^ limitedPosition
]

{ #category : 'private' }
STTMovableShape >> limitedPosition [
	"Answer the device Point that best keeps the shape inside the play field."

	^ self centerPosition min: self maximalPoint max: self minimalPoint
]

{ #category : 'accessing' }
STTMovableShape >> maximalPoint [

	self explicitRequirement
]

{ #category : 'accessing' }
STTMovableShape >> minimalPoint [

	self explicitRequirement
]

{ #category : 'accessing' }
STTMovableShape >> name [
	"Answer my name string."

	^ self subclassResponsibility
]

{ #category : 'private' }
STTMovableShape >> newMovedAnnouncementWithTarget: aPoint [
	"Answer the announcement that I have been moved to the given center position."

	^ self subclassResponsibility
]

{ #category : 'accessing' }
STTMovableShape >> playFieldExtent [

	^ playFieldExtent
]

{ #category : 'accessing' }
STTMovableShape >> playFieldExtent: anObject [

	playFieldExtent := anObject
]

{ #category : 'initialization' }
STTMovableShape >> registerAtAnnouncer [

	self subclassResponsibility
]
