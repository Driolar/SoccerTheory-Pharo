"
I announce that the offside line's position (x-coordinate) changed.
"
Class {
	#name : 'STOffsideLineChangedAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'offsideX'
	],
	#category : 'SoccerTheory-Model-Announcement',
	#package : 'SoccerTheory-Model',
	#tag : 'Announcement'
}

{ #category : 'instance creation' }
STOffsideLineChangedAnnouncement class >> newWithOffsideX: xCoordinate [

	^ self new initializeWithOffsideX: xCoordinate
]

{ #category : 'initialization' }
STOffsideLineChangedAnnouncement >> initializeWithOffsideX: xCoordinate [

	offsideX := xCoordinate
]

{ #category : 'accessing' }
STOffsideLineChangedAnnouncement >> offsideX [ 
	"Answer the current offside line's x-coordinate."

	^offsideX 
]
