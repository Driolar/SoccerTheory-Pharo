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
		'frame'
	],
	#category : 'SoccerTheory-Model-Operate',
	#package : 'SoccerTheory-Model',
	#tag : 'Operate'
}

{ #category : 'instance creation' }
STActionManager class >> newWithFrame: aPlay [
	^ self new initializeWithFrame: aPlay
]

{ #category : 'actions api' }
STActionManager >> addPlayer: aPlayer toTeam: aTeam [
	aTeam addPlayer: aPlayer.
	self notifyCovering 
]

{ #category : 'actions api' }
STActionManager >> changeBallOwnerToTeam: aTeam [
	"Change the ball owner and notify the change."

	frame ball owningTeam: aTeam.
	self notifyCovering
]

{ #category : 'initialization' }
STActionManager >> initializeWithFrame: aFrame [
	frame := aFrame
]

{ #category : 'actions api' }
STActionManager >> moveBallToPosition: aPosition [
	frame ball position: aPosition.
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

	frame notifyCovering
]

{ #category : 'initialization' }
STActionManager >> setAncientSoccerStrategy [
	"The play is to be ruled by the ancient soccer strategy"

	frame setAncientSoccerStrategy.
	self notifyCovering 
]

{ #category : 'initialization' }
STActionManager >> setClassicSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	frame setClassicSoccerStrategy.
	self notifyCovering
]

{ #category : 'initialization' }
STActionManager >> setModernSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	frame setModernSoccerStrategy.
	self notifyCovering
]

{ #category : 'initialization' }
STActionManager >> setNoOffsideSoccerStrategy [
	"The play is to be ruled with no offside rule."

	frame setNoOffsideSoccerStrategy.
	self notifyCovering 
]
