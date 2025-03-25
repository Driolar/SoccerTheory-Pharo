"
I announce that a player shape has been moved, typically by drag and drop.
"
Class {
	#name : 'STPlayerShapeMovedAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'player',
		'targetDevicePoint'
	],
	#category : 'SoccerTheory-Rendering-Announcement',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Announcement'
}

{ #category : 'instance creation' }
STPlayerShapeMovedAnnouncement class >> newOnPlayer: aSTPlayer targetPosition: aPoint [
	"Answer a new announcement about having moved a player to the given device point."

	^ self new
		  initializeOnPlayer: aSTPlayer
		  targetPosition: aPoint
]

{ #category : 'initialization' }
STPlayerShapeMovedAnnouncement >> initializeOnPlayer: aSTPlayer targetPosition: aPoint [
	"Initialize a new announcement about having moved a player to the given device point."

	player := aSTPlayer.
	targetDevicePoint := aPoint
]

{ #category : 'accessing' }
STPlayerShapeMovedAnnouncement >> player [
	"Answer the model player involved."

	^ player
]

{ #category : 'accessing' }
STPlayerShapeMovedAnnouncement >> targetDevicePoint [
	"Answer the device point where the player shape was moved to."

	^ targetDevicePoint
]
