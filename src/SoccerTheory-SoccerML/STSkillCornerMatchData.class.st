"
I am a wrapper for the SkillCorner match data (metadata).
"
Class {
	#name : 'STSkillCornerMatchData',
	#superclass : 'Object',
	#instVars : [
		'pitch',
		'homeTeamId',
		'teamNames',
		'awayTeamId',
		'playersById',
		'ballId'
	],
	#category : 'SoccerTheory-SoccerML-SkillCorner',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'SkillCorner'
}

{ #category : 'instance creation' }
STSkillCornerMatchData class >> on: aReadStream [
	
	^ self new initializeWith: aReadStream 
]

{ #category : 'instance creation' }
STSkillCornerMatchData class >> onFileNamed: fileName [

	^ self new initializeWith: fileName asFileReference readStream
]

{ #category : 'accessing' }
STSkillCornerMatchData >> awayTeamId [
	"Answer the away team's id."

	^ awayTeamId
]

{ #category : 'accessing' }
STSkillCornerMatchData >> ballId [
	"Answer the ball id."

	^ ballId
]

{ #category : 'accessing' }
STSkillCornerMatchData >> framesPerSecond [
	"This value is documented here: https://github.com/SkillCorner/opendata/tree/master."

	^ '10'
]

{ #category : 'accessing' }
STSkillCornerMatchData >> homeTeamId [
	"Answer the home team's id."

	^ homeTeamId 
]

{ #category : 'initialization' }
STSkillCornerMatchData >> initialize [

	super initialize.
	teamNames := Dictionary new
]

{ #category : 'initialization' }
STSkillCornerMatchData >> initializeWith: aReadStream [

	| jsonReader contents |
	jsonReader := NeoJSONReader on: aReadStream.
	contents := jsonReader next.
	pitch := STPitch extent:
		         (contents at: 'pitch_length')
		         @ (contents at: 'pitch_width').
	homeTeamId := contents at: 'home_team' at: 'id'.
	awayTeamId := contents at: 'away_team' at: 'id'.
	teamNames
		at: homeTeamId
		put: (contents at: 'home_team' at: 'short_name').
	teamNames
		at: awayTeamId
		put: (contents at: 'away_team' at: 'short_name').
	ballId := contents at: 'ball' at: 'trackable_object'.
	playersById := (contents at: 'players')
		               inject: Dictionary new
		               into: [ :result :playerDictionary |
				               result
					               at: (playerDictionary at: 'trackable_object')
					               put: playerDictionary;
					               yourself ]
]

{ #category : 'accessing' }
STSkillCornerMatchData >> pitch [
	"Answer the STPitch"

	^ pitch
]

{ #category : 'accessing' }
STSkillCornerMatchData >> playersById [
	"Answer the players accessible by player id."

	^ playersById
]

{ #category : 'accessing' }
STSkillCornerMatchData >> teamNameAt: teamId [
	"Answer the team (short) name for the given teamId."

	^ teamNames at: teamId
]
