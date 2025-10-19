"
I represent the Common Soccer Strategy.
The Common Soccer Strategy orders the moves of the soccer game.
The Common Soccer Strategy is part of the Theory of Soccer.

Following the strategy pattern, STCommonSoccerStrategy is an abstract class.
The concrete subclasses correspond to the historical soccer strategies.
The context of the strategic class STCommonSoccerStrategy ist STSoccerPlay.

The most important method of STCommonSoccerStrategy is #updateCovering.
This method updates the covering states of the players belonging to the attacking team.
The covering aims to subtly avoid the advance of any attacking player that has no ball at his feet.





"
Class {
	#name : 'STCommonSoccerStrategy',
	#superclass : 'Object',
	#instVars : [
		'frame'
	],
	#category : 'SoccerTheory-Model-Strategy',
	#package : 'SoccerTheory-Model',
	#tag : 'Strategy'
}

{ #category : 'instance creation' }
STCommonSoccerStrategy class >> newWithFrame: aPlay [
	^self new initializeWithFrame: aPlay
]

{ #category : 'naming' }
STCommonSoccerStrategy class >> offsideRuleName [

	self subclassResponsibility
]

{ #category : 'accessing' }
STCommonSoccerStrategy >> attackingTeam [

	^ frame owningTeam
]

{ #category : 'accessing' }
STCommonSoccerStrategy >> defendingTeam [

	^ frame defendingTeam
]

{ #category : 'flagging' }
STCommonSoccerStrategy >> flagCoveredPlayers [

	^ self subclassResponsibility
]

{ #category : 'flagging' }
STCommonSoccerStrategy >> flagManCoveredPlayers [
	"I find out which attackers are man covered and which not and set the covering flag correspondingly. According to the Theory of Soccer, man covering is the modern method required to cover the attacking team. Each player of the defending team has an opponent player assigned one-to-one. This makes sure that if the opponent gets the ball, the assigned defending player can hinder him before he can either score or destabilise the defence."

	| playersSortedByX relevantAttackingPlayers numberOfDefenders numberOfAttackers |
	"Players in offside are trivially covered."
	self attackingTeam players
		do: [ :player | 
			player isOffside
				ifTrue: [ player isCovered: true ] ].

	"Merge defenders and attackers sorted by the defender's attack direction."
	playersSortedByX := frame sortedDefendingFieldPlayers.
	relevantAttackingPlayers := self attackingTeam players
		reject: [ :player | player isOffside or: [ player isGoalkeeper ] ].
	playersSortedByX addAll: relevantAttackingPlayers.


	"Now sweep along x and find out for each attacker if there are enough defenders in front of him so that one of them would cover him. Note that we dont compute the concrete assignment man to man."
	numberOfDefenders := 0.
	numberOfAttackers := 0.
	playersSortedByX
		do: [ :player | 
			player isAttacking
				ifTrue: [ numberOfAttackers := numberOfAttackers + 1.
					player isCovered: numberOfDefenders >= numberOfAttackers ]
				ifFalse: [ numberOfDefenders := numberOfDefenders + 1 ] ]
]

{ #category : 'flagging' }
STCommonSoccerStrategy >> flagOffsidePlayers [

	self offsideX
		ifNotNil: [ :offsideX |
			self attackingTeam players do: [ :player |
				player isOffside:
					(self isOffsidePlayer: player offsideX: offsideX) ] ]
		ifNil: [
			self attackingTeam players do: [ :player | player isOffside: false ] ]
]

{ #category : 'private' }
STCommonSoccerStrategy >> gameAnnouncer [
	"Answer the announcer singleton."

	^ frame gameAnnouncer
]

{ #category : 'initialization' }
STCommonSoccerStrategy >> initializeWithFrame: aSTSoccerFrame [
	frame := aSTSoccerFrame 
]

{ #category : 'accessing' }
STCommonSoccerStrategy >> isAncient [
	"Answer true if I am the ancient soccer strategy, otherwise false."

	^ false
]

{ #category : 'accessing' }
STCommonSoccerStrategy >> isNone [
	"Answer true if I am the no offside soccer strategy, otherwise false."

	^ false
]

{ #category : 'testing' }
STCommonSoccerStrategy >> isOffsidePlayer: aSTPlayer offsideX: xCoordinate [
	"Answer true if aSTPlayer is offside considering offside level at xCoordinate."

	self subclassResponsibility 
]

{ #category : 'accessing' }
STCommonSoccerStrategy >> offsideRuleName [

	^ self class offsideRuleName
]

{ #category : 'private' }
STCommonSoccerStrategy >> offsideX [
	"Answer the current offside line's x-coordinate. Answer nil if offside does not apply."

	self subclassResponsibility
]

{ #category : 'flagging' }
STCommonSoccerStrategy >> offsideXAccordingToDefender: aSTPlayer [
	"Answer the offside line's x-coordinate according to the given defender. 
	aSTPlayer may be nil if there are (too) few players on the pitch."

	| offsideX |
	offsideX := (aSTPlayer notNil and: [ aSTPlayer isBehindTheBall ])
		            ifTrue: [ aSTPlayer position x ]
		            ifFalse: [ frame ball position x ].

	"Since 1907, a player in the own half (including the middle line) is never offside."

	^ self defendingTeam isTeamLeft
		  ifTrue: [ offsideX min: self pitch middle x ]
		  ifFalse: [ offsideX max: self pitch middle x ]
]

{ #category : 'accessing' }
STCommonSoccerStrategy >> pitch [

	^ frame pitch
]

{ #category : 'flagging' }
STCommonSoccerStrategy >> resetCoveringStates [

	frame teamLeft players do: [ :player | player isOffside: nil. player isCovered: nil ].
	frame teamRight players do: [ :player | player isOffside: nil. player isCovered: nil ]
]

{ #category : 'model updates' }
STCommonSoccerStrategy >> updateCovering [

	self resetCoveringStates.

	"Respect the sequence: First flag offside, then flag covering."
	"Covering flags depend on offside flags."
	self attackingTeam ifNotNil: [
			self flagOffsidePlayers.
			self flagCoveredPlayers ].

	"Maybe to do: If performance suffers, optimize by firing the announcements only if something really changed."
	self gameAnnouncer
		announce: STOffsideSwitchedAnnouncement new;
		announce: STUncoveredSwitchedAnnouncement new;
		announce:
			(STOffsideLineChangedAnnouncement newWithOffsideX: self offsideX)
]

{ #category : 'accessing' }
STCommonSoccerStrategy >> xmlText [
	"Answer the String for my xml tag."

	self subclassResponsibility
]
