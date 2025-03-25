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
STMovableShapeSelectedAnnouncement class >> newOn: aSTMovableShape [
	"Answer a new announcement that aMovableShape was selected."

	^ self new initializeOn: aSTMovableShape
]

{ #category : 'initialization' }
STMovableShapeSelectedAnnouncement >> initializeOn: aSTMovableShape [
	"Initialize on aMovableShape."

	movableShape := aSTMovableShape
]

{ #category : 'accessing' }
STMovableShapeSelectedAnnouncement >> movableShape [

	^ movableShape
]
