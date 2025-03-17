"
I announce that a movable shape has been selected (for being moved through arrow keys).
"
Class {
	#name : 'STMovableShapeSelectedAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'movableShape'
	],
	#category : 'SoccerTheory-Rendering-Announcement',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Announcement'
}

{ #category : 'instance creation' }
STMovableShapeSelectedAnnouncement class >> newOn: aMovableShape [
	"Answer a new announcement that aMovableShape was selected."

	^ self new initializeOn: aMovableShape
]

{ #category : 'initialization' }
STMovableShapeSelectedAnnouncement >> initializeOn: aMovableShape [
	"Initialize on aMovableShape."

	movableShape := aMovableShape
]

{ #category : 'accessing' }
STMovableShapeSelectedAnnouncement >> movableShape [

	^ movableShape
]
