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
				 self announcer announce: self movedAnnouncement ])
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

{ #category : 'private' }
STMovableShape >> movedAnnouncement [
	"Answer the announcement that I have been moved."

	^ self subclassResponsibility
]
