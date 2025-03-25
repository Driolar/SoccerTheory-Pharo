"
I am an Action Manager.

I can add players to a team.
I can determine the team that possesses the ball.
I can set the soccer strategy.
I can move a player or the ball.

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

{ #category : 'notification' }
STActionManager >> announceBallPossessionChanged [
	"Announce that the ball possession has changed."

	self announcer announce: STBallPossessionChangedAnnouncement new
]

{ #category : 'notification' }
STActionManager >> announceStrategyChanged [
	"Announce that the soccer strategy has been changed."

	self announcer announce: STSoccerStrategyChangedAnnouncement new
]

{ #category : 'notification' }
STActionManager >> announcer [

	^ frame announcer
]

{ #category : 'actions api' }
STActionManager >> changeBallOwnerToTeam: aTeam [
	"Change the ball owner and notify the change."

	frame ball owningTeam: aTeam.
	self announceBallPossessionChanged
]

{ #category : 'initialization' }
STActionManager >> initializeWithFrame: aFrame [

	frame := aFrame.
	self registerAtAnnouncer
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

{ #category : 'notification' }
STActionManager >> registerAtAnnouncer [

	self announcer
		when: STSoccerStrategyChangedAnnouncement
		do: [ :ann | self notifyCovering ]
		for: self.

	self announcer
		when: STBallPossessionChangedAnnouncement
		do: [ :ann | self notifyCovering ]
		for: self
]

{ #category : 'actions api' }
STActionManager >> setAncientSoccerStrategy [
	"The play is to be ruled by the ancient soccer strategy"

	frame setAncientSoccerStrategy.
	self announceStrategyChanged
]

{ #category : 'actions api' }
STActionManager >> setClassicSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	frame setClassicSoccerStrategy.
	self announceStrategyChanged
]

{ #category : 'actions api' }
STActionManager >> setModernSoccerStrategy [
	"The play is to be ruled by the classic soccer strategy"

	frame setModernSoccerStrategy.
	self announceStrategyChanged
]

{ #category : 'actions api' }
STActionManager >> setNoOffsideSoccerStrategy [
	"The play is to be ruled with no offside rule."

	frame setNoOffsideSoccerStrategy.
	self announceStrategyChanged
]
