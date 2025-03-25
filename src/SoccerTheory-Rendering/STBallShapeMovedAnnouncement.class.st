"
I announce that the ball shape has been moved, typically by drag and drop.
"
Class {
	#name : 'STBallShapeMovedAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'targetDevicePoint'
	],
	#category : 'SoccerTheory-Rendering-Announcement',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Announcement'
}

{ #category : 'instance creation' }
STBallShapeMovedAnnouncement class >> newWithTargetPosition: aPoint [
	"Answer a new announcement about having moved the ball to the given device point."

	^ self new initializeWithTargetPosition: aPoint
]

{ #category : 'initialization' }
STBallShapeMovedAnnouncement >> initializeWithTargetPosition: aPoint [
	"Initialize a new announcement about having moved the ball to the given device point."

	targetDevicePoint := aPoint
]

{ #category : 'accessing' }
STBallShapeMovedAnnouncement >> targetDevicePoint [
	"Answer the device Point where the player shape was moved to."

	^ targetDevicePoint
]
