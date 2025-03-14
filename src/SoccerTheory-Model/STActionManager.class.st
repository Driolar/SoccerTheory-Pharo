"
I am an Action Manager.

I can add players to a team.
I can determine the team that possesses the ball.

I notify relevant actions to observers.
"
Class {
	#name : 'STActionManager',
	#superclass : 'Object',
	#instVars : [
		'play'
	],
	#category : 'SoccerTheory-Model-Operate',
	#package : 'SoccerTheory-Model',
	#tag : 'Operate'
}

{ #category : 'instance creation' }
STActionManager class >> newWithPlay: aPlay [
	^ self new initializeWithPlay: aPlay
]

{ #category : 'actions api' }
STActionManager >> addPlayer: aPlayer toTeam: aTeam [
	aTeam addPlayer: aPlayer.
	self notifyCovering 
]

{ #category : 'actions api' }
STActionManager >> changeBallOwnerToTeam: aTeam [
	"Change the ball owner and notify the change."

	play ball owningTeam: aTeam.
	self notifyCovering
]

{ #category : 'initialization' }
STActionManager >> initializeWithPlay: aPlay [
	play := aPlay
]

{ #category : 'actions api' }
STActionManager >> moveBallToPosition: aPosition [
	play ball position: aPosition.
	self notifyCovering
]

{ #category : 'actions api' }
STActionManager >> movePlayer: aPlayer toPosition: aPosition [
	aPlayer position: aPosition.
	self notifyCovering
]

{ #category : 'notification' }
STActionManager >> notifyCovering [
	"Notify that some event affecting covering happened."

	play notifyCovering
]

{ #category : 'initialization' }
STActionManager >> setAncientSoccerStrategy [
	"The play is to be ruled by the ancient soccer strategy"

	play setAncientSoccerStrategy.
	self notifyCovering 
]

{ #category : 'initialization' }
STActionManager >> setClassicSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	play setClassicSoccerStrategy.
	self notifyCovering
]

{ #category : 'initialization' }
STActionManager >> setModernSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	play setModernSoccerStrategy.
	self notifyCovering
]

{ #category : 'initialization' }
STActionManager >> setNoOffsideSoccerStrategy [
	"The play is to be ruled with no offside rule."

	play setNoOffsideSoccerStrategy.
	self notifyCovering 
]
