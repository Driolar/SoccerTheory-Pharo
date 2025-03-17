"
I am the abstract class for movable shapes.
"
Class {
	#name : 'STMovableShape',
	#superclass : 'BlElement',
	#instVars : [
		'squareExtent',
		'graphicFactory'
	],
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'initialization' }
STMovableShape >> addKeyEventHandlers [
	"Add my key event handlers."

	self addEventHandler: (BlEventHandler
			 on: BlKeyDownEvent
			 do: [ :anEvent |
				 self removeChildWithId: #hovertext.
				 self stepTheArrowWay: anEvent key ])
]

{ #category : 'initialization' }
STMovableShape >> addMouseEventHandlers [
	"Add my mouse event handlers."

	self addEventHandler: BlPullHandler new.

	self addEventHandler: (BlEventHandler
			 on: BlMouseOverEvent
			 do: [ :anEvent |
				 anEvent currentTarget
					 addChild: self hoverTextElement
					 as: #hovertext ]).

	self addEventHandler: (BlEventHandler
			 on: BlMouseOutEvent
			 do: [ :anEvent |
			 anEvent currentTarget removeChildWithId: #hovertext ]).

	self addEventHandler: (BlEventHandler
			 on: BlDragStartEvent
			 do: [ :anEvent |
			 anEvent currentTarget removeChildWithId: #hovertext ]).

	self addEventHandler: (BlEventHandler
			 on: BlDragEndEvent
			 do: [ :anEvent |
				 anEvent currentTarget removeChildWithId: #hovertext.
				 self announcer announce:
					 (self newMovedAnnouncementWithTarget: self centerPosition) ]).

	self addEventHandler: (BlEventHandler
			 on: BlClickEvent
			 do: [ :anEvent |
				 self hasFocus
					 ifTrue: [
						 self hideShadow.
						 self loseFocus ]
					 ifFalse: [
						 self showShadow.
						 self requestFocus.
						 self announcer announce:
							 (STMovableShapeSelectedAnnouncement newOn: self) ] ]).

	self addEventHandler: (BlEventHandler
			 on: BlFocusOutEvent
			 do: [ :anEvent | self hideShadow ])
]

{ #category : 'private' }
STMovableShape >> announcer [
	"Answer the announcer to send and receive announcements."

	^ STSoccerFrame announcer
]

{ #category : 'accessing' }
STMovableShape >> centerPosition [
	"Answer the very center Point of the shape."

	"This doesn't always work: self position: aPosition - (self extent / 2). 
	Sometimes self extent returns here 0@0 instead of 18@18.
	For this reason, the variable squareExtent is introduced."

	^ self position + (squareExtent / 2)
]

{ #category : 'accessing' }
STMovableShape >> centerPosition: aPosition [
	"Set the device origin top left based on the center position."

	"This doesn't always work: self position: aPosition - (self extent / 2). 
	Sometimes self extent returns here 0@0 instead of 18@18.
	For this reason, the variable squareExtent is introduced."

	self position: aPosition - (squareExtent / 2)
]

{ #category : 'private' }
STMovableShape >> hideShadow [
	"Show my shadow (when being deselected)."

	^ self subclassResponsibility
]

{ #category : 'private' }
STMovableShape >> hoverTextElement [
	"Answer the player's hover text"

	| hoverText |
	hoverText := ((BlRopedText string: self hoverTextString) fontSize: 11)
		             asElement
		             background: Color white;
		             padding: (BlInsets all: 2).
	hoverText position:
		(Point x: self hoverTextPositionX y: self hoverTextPositionY).
	^ hoverText
]

{ #category : 'private' }
STMovableShape >> hoverTextPositionX [
	"Answer the x coordinate of the hover text."

	^ squareExtent x
]

{ #category : 'private' }
STMovableShape >> hoverTextPositionY [
	"Answer the y coordinate of the hover text."

	| parentExtent |
	parentExtent := self parent extent.
	^ self centerPosition y < (parentExtent y / 2)
		  ifTrue: [ squareExtent y ]
		  ifFalse: [ 0 ]
]

{ #category : 'private' }
STMovableShape >> hoverTextString [
	"Answer the string for the hover text element."

	^ self subclassResponsibility
]

{ #category : 'accessing' }
STMovableShape >> name [
	"Answer my name string."

	^ self subclassResponsibility
]

{ #category : 'private' }
STMovableShape >> newMovedAnnouncementWithTarget: aPosition [
	"Answer the announcement that I have been moved to the given device position."

	^ self subclassResponsibility
]

{ #category : 'private' }
STMovableShape >> showShadow [
	"Show my shadow (when being selected)."

	^ self subclassResponsibility
]

{ #category : 'private' }
STMovableShape >> stepTheArrowWay: aKeyboardKey [
	"Move me one step following the given keyboard key if it is an arrow key."

	| offset offsetPoint newCenterPosition |
	offset := 1.
	offsetPoint := nil.

	aKeyboardKey isArrowLeft ifTrue: [
		offsetPoint := Point x: offset negated y: 0 ].

	aKeyboardKey isArrowRight ifTrue: [
		offsetPoint := Point x: offset y: 0 ].

	aKeyboardKey isArrowUp ifTrue: [
		offsetPoint := Point x: 0 y: offset negated ].

	aKeyboardKey isArrowDown ifTrue: [
		offsetPoint := Point x: 0 y: offset ].

	offsetPoint ifNil: [ ^ self ].
	self transform
		translateBy: offsetPoint;
		apply.

	"I need the temp value because of a timing conflict.
	The centerPosition method may answer the old position when creating the announcement!"
	newCenterPosition := self centerPosition + offsetPoint.
	self centerPosition: newCenterPosition.
	self announcer announce:
		(self newMovedAnnouncementWithTarget: newCenterPosition)
]
