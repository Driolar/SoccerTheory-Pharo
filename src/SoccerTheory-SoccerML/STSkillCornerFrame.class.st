"
I am a wrapper for a single structured data frame line (JSON Dictionary). 
"
Class {
	#name : 'STSkillCornerFrame',
	#superclass : 'Object',
	#instVars : [
		'jsonFrame',
		'matchData',
		'frameBuilder',
		'ballPosition'
	],
	#category : 'SoccerTheory-SoccerML-SkillCorner',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'SkillCorner'
}

{ #category : 'instance creation' }
STSkillCornerFrame class >> jsonFrame: aDictionary matchData: aSTSkillCornerMatchData [
	"Answer a new SkillCorner frame wrapper."

	^ self new
		  initializeWithJsonFrame: aDictionary
		  matchData: aSTSkillCornerMatchData
]

{ #category : 'api' }
STSkillCornerFrame >> buildFrameForLeftTeamId: leftTeamId rightTeamId: rightTeamId [
	"Answer the STSoccerFrame after having built it completely."

	self isValid ifFalse: [ ^ nil ].

	frameBuilder := self
		                createFrameBuilderForLeftTeamId: leftTeamId
		                rightTeamId: rightTeamId.
	self setOfficialTime.
	self
		setBallPossessionForLeftTeamId: leftTeamId
		rightTeamId: rightTeamId.

	self playerTracks do: [ :track |
			matchData playersById
				at: (track at: 'trackable_object')
				ifPresent: [ :playerDictionary |
						| position |
						position := (track at: 'x') @ (track at: 'y').
						leftTeamId = (playerDictionary at: 'team_id') ifTrue: [
							self buildLeftPlayerOn: playerDictionary position: position ].
						rightTeamId = (playerDictionary at: 'team_id') ifTrue: [
							self buildRightPlayerOn: playerDictionary position: position ] ] ].
	^ frameBuilder builtFrame
]

{ #category : 'private' }
STSkillCornerFrame >> buildLeftPlayerOn: jsonPlayer position: aPoint [
	"Build a left team player based on the given JSON player dictionary and position Point."

	| isGoalkeeper |
	isGoalkeeper := (jsonPlayer at: 'player_role' at: 'id') = 0.
	isGoalkeeper
		ifTrue: [
				frameBuilder
					createGoalkeeperInTeamLeftAtPosition: aPoint
					number: (jsonPlayer at: 'number') ]
		ifFalse: [
				frameBuilder
					createPlayerInTeamLeftAtPosition: aPoint
					number: (jsonPlayer at: 'number') ]
]

{ #category : 'private' }
STSkillCornerFrame >> buildRightPlayerOn: jsonPlayer position: aPoint [
	"Build a right team player based on the given JSON player dictionary and position Point."

	| isGoalkeeper |
	isGoalkeeper := (jsonPlayer at: 'player_role' at: 'id') = 0.
	isGoalkeeper
		ifTrue: [
				frameBuilder
					createGoalkeeperInTeamRightAtPosition: aPoint
					number: (jsonPlayer at: 'number') ]
		ifFalse: [
				frameBuilder
					createPlayerInTeamRightAtPosition: aPoint
					number: (jsonPlayer at: 'number') ]
]

{ #category : 'private' }
STSkillCornerFrame >> createFrameBuilderForLeftTeamId: leftTeamId rightTeamId: rightTeamId [
	"Answer a new STSoccerFrameBuilder on the given ball position Point."

	^ (STSoccerFrameBuilder
		   newWithTeamLeft: (matchData teamNameAt: leftTeamId)
		   teamRight: (matchData teamNameAt: rightTeamId)
		   pitch: matchData pitch
		   ball: (STBall newWithPosition: ballPosition))
		  setModernSoccerStrategy;
		  framesPerSecond: matchData framesPerSecond;
		  yourself
]

{ #category : 'private' }
STSkillCornerFrame >> homePlayerTracks [
	"Answer a Collection of player tracks for home team."

	^ self playerTracks select: [ :track |
		  (track at: 'team_id') = matchData homeTeamId ]
]

{ #category : 'initialization' }
STSkillCornerFrame >> initializeWithJsonFrame: aDictionary matchData: aSTSkillCornerMatchData [

	| ballItem |
	jsonFrame := aDictionary.
	matchData := aSTSkillCornerMatchData.
	ballItem := (jsonFrame at: 'data') asOrderedCollection
		            detect: [ :track |
			            (track at: 'trackable_object' ifAbsent: [ nil ])
			            = matchData ballId ]
		            ifNone: [ nil ].
	ballItem ifNotNil: [
		ballPosition := (ballItem at: 'x') @ (ballItem at: 'y') ]
]

{ #category : 'private' }
STSkillCornerFrame >> isNotEmptyAwayTeam [
	"Answer true if there is at least one away team player tracked."

	^ self isNotEmptyTeam: matchData awayTeamId
]

{ #category : 'private' }
STSkillCornerFrame >> isNotEmptyHomeTeam [
	"Answer true if there is at least one home team player tracked."

	^ self isNotEmptyTeam: matchData homeTeamId
]

{ #category : 'private' }
STSkillCornerFrame >> isNotEmptyTeam: teamId [
	"Answer true if there is at least one player with teamId tracked."

	^ self playerTracks anySatisfy: [ :playerTrack |
			  (matchData playersById
				   at: (playerTrack at: 'trackable_object')
				   at: 'team_id') = teamId ]
]

{ #category : 'api' }
STSkillCornerFrame >> isValid [
	"Answer true if the frame is valid, otherwise false."

	^ ballPosition notNil and: [
		  self isNotEmptyHomeTeam and: [ self isNotEmptyAwayTeam ] ]
]

{ #category : 'private' }
STSkillCornerFrame >> leftmostPlayer [
	"Answer the player item with the least x-coordinate track."

	^ matchData playersById at:
		  (self playerTracksSortedByAscendingX first at: 'trackable_object')
]

{ #category : 'private' }
STSkillCornerFrame >> playerTracks [
	"Answer a Collection of player tracks for both teams."

	^ (jsonFrame at: 'data') asOrderedCollection select: [ :track |
			  track
				  at: 'trackable_object'
				  ifPresent: [ :playerId |
				  matchData playersById keys includes: playerId ]
				  ifAbsent: [ false ] ]
]

{ #category : 'private' }
STSkillCornerFrame >> playerTracksSortedByAscendingX [
	"Answer the player tracks sorted by x-coordinate."

	^ self playerTracks sort: [ :a :b | (a at: 'x') <= (b at: 'x') ]
]

{ #category : 'private' }
STSkillCornerFrame >> setBallPossessionForLeftTeamId: leftTeamId rightTeamId: rightTeamId [

	(jsonFrame at: 'possession' at: 'group') ifNotNil: [ :possessionGroup |
			(possessionGroup beginsWith: 'home') ifTrue: [
					leftTeamId = matchData homeTeamId
						ifTrue: [ frameBuilder setBallPosessionLeft ]
						ifFalse: [ frameBuilder setBallPosessionRight ] ].
			(possessionGroup beginsWith: 'away') ifTrue: [
					leftTeamId = matchData awayTeamId
						ifTrue: [ frameBuilder setBallPosessionLeft ]
						ifFalse: [ frameBuilder setBallPosessionRight ] ] ]
]

{ #category : 'private' }
STSkillCornerFrame >> setOfficialTime [

	frameBuilder officialTime:
		(jsonFrame at: 'time' ifAbsent: [ jsonFrame at: 'frame' ])
]
