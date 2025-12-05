"
I am the abstract class for strategy layers.
"
Class {
	#name : 'STStrategyLayer',
	#superclass : 'Object',
	#instVars : [
		'scene',
		'shapes'
	],
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
STStrategyLayer class >> newOn: aSTRoassalSoccerScene [

	^self new initializeOn: aSTRoassalSoccerScene
]

{ #category : 'rendering' }
STStrategyLayer >> clearAll [

	shapes do: [ :shape | shape remove ].
	shapes removeAll.
	scene signalUpdate
]

{ #category : 'rendering' }
STStrategyLayer >> disappear [
	"Clear all shapes and unsubscribe announcements."

	self clearAll.
	self unregisterAtAnnouncer
]

{ #category : 'private' }
STStrategyLayer >> gameAnnouncer [

	^ scene gameAnnouncer
]

{ #category : 'initialization' }
STStrategyLayer >> initialize [

	super initialize.
	shapes := OrderedCollection new
]

{ #category : 'initialization' }
STStrategyLayer >> initializeOn: aSTRoassalSoccerScene [

	scene := aSTRoassalSoccerScene.
	self registerAtAnnouncer
]

{ #category : 'initialization' }
STStrategyLayer >> registerAtAnnouncer [

	self gameAnnouncer
		when: STCoverageUpdatedAnnouncement
		do: [ :ann | self render ]
		for: self
]

{ #category : 'rendering' }
STStrategyLayer >> render [
	^ self subclassResponsibility
]

{ #category : 'rendering' }
STStrategyLayer >> resetRotation [

	(scene canvas shapesFromModels: scene teamLeft players) do: [
		:playerShape | playerShape resetRotation ].
	(scene canvas shapesFromModels: scene teamRight players) do: [
		:playerShape | playerShape resetRotation ]
]

{ #category : 'private' }
STStrategyLayer >> shapeFromModel: model [

	^ scene canvas shapeFromModel: model
]

{ #category : 'initialization' }
STStrategyLayer >> unregisterAtAnnouncer [

	self gameAnnouncer unsubscribe: self
]
