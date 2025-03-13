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
STBallShapeMovedAnnouncement class >> newWithTargetPosition: aTargetPosition [
	"Answer a new announcement about having moved the ball to the given device point."

	^ self new initializeWithTargetPosition: aTargetPosition
]

{ #category : 'initialization' }
STBallShapeMovedAnnouncement >> initializeWithTargetPosition: aTargetPosition [
	"Initialize a new announcement about having moved the ball to the given device point."

	targetDevicePoint := aTargetPosition
]

{ #category : 'accessing' }
STBallShapeMovedAnnouncement >> targetDevicePoint [
	"Answer the device point where the player shape was moved to."

	^ targetDevicePoint
]
