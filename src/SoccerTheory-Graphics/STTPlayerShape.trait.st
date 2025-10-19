"
I support the behavior of the player shapes common to the various specific graphics.
"
Trait {
	#name : 'STTPlayerShape',
	#instVars : [
		'player'
	],
	#category : 'SoccerTheory-Graphics-Basic',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Basic'
}

{ #category : 'accessing' }
STTPlayerShape >> ball [

	^ self player ball
]

{ #category : 'private' }
STTPlayerShape >> formattedPlayerPositionString [
	"Answer the formatted string representing the model player's position."

	^ '(' , (self player position x printShowingDecimalPlaces: 1) , '@'
	  , (self player position y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'private' }
STTPlayerShape >> hoverTextString [
	"Answer the string for the hover text element."

	^ '#',self jerseyString , ' ' , self formattedPlayerPositionString
]

{ #category : 'private' }
STTPlayerShape >> isOffside [
	"Answer whether player is in offside or not."

	^ self player isOffside isNotNil and: [ self player isOffside ]
]

{ #category : 'showing' }
STTPlayerShape >> isUncovered [

	^ self player isCovered isNotNil and: [ self player isCovered not ]
]

{ #category : 'private' }
STTPlayerShape >> jerseyNumber [
	"Answer the players jersey number"

	^ self player jerseyNumber
]

{ #category : 'private' }
STTPlayerShape >> jerseyString [
	"Answer the players jersey number asString"

	^ self jerseyNumber asString
]

{ #category : 'accessing' }
STTPlayerShape >> name [
	"Answer my name string."

	^ 'Player ' , self jerseyString , ' of ' , self player teamName
]

{ #category : 'accessing' }
STTPlayerShape >> player [

	^ player
]

{ #category : 'accessing' }
STTPlayerShape >> player: aSTPlayer [

	player := aSTPlayer
]

{ #category : 'initialization' }
STTPlayerShape >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self gameAnnouncer
		when: STOffsideSwitchedAnnouncement
		do: [ :ann | self updateOffside ]
		for: self.
	self gameAnnouncer
		when: STUncoveredSwitchedAnnouncement
		do: [ :ann | self updateUncovered ]
		for: self
]

{ #category : 'private' }
STTPlayerShape >> team [

	^ self player team
]
