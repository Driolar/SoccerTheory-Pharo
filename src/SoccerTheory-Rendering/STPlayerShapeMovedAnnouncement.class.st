"
I announce that a player shape has been moved, typically by drap and drop.
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
STPlayerShapeMovedAnnouncement class >> newOnPlayer: aPlayer targetPosition: aTargetPosition [
	"Answer a new announcement about having moved a player to the given device point."

	^ self new
		  initializeOnPlayer: aPlayer
		  targetPosition: aTargetPosition
]

{ #category : 'initialization' }
STPlayerShapeMovedAnnouncement >> initializeOnPlayer: aPlayer targetPosition: aTargetPosition [
	"Initialize a new announcement about having moved a player to the given device point."

	player := aPlayer.
	targetDevicePoint := aTargetPosition
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
