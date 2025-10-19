"
I support the behavior of the ball shapes common to the various specific graphics.
"
Trait {
	#name : 'STTBallShape',
	#instVars : [
		'ball'
	],
	#category : 'SoccerTheory-Graphics-Basic',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Basic'
}

{ #category : 'accessing' }
STTBallShape >> ball [

	^ ball
]

{ #category : 'accessing' }
STTBallShape >> ball: aSTBall [

	ball := aSTBall
]

{ #category : 'private' }
STTBallShape >> hoverTextString [
	"Answer the string for the hover text element."

	^ '(' , (self ball position x printShowingDecimalPlaces: 1) , '@'
	  , (self ball position y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'accessing' }
STTBallShape >> name [
	"Answer my name string."

	^ 'Ball'
]

{ #category : 'initialization' }
STTBallShape >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self gameAnnouncer
		when: STBallPossessionChangedAnnouncement
		do: [ :ann | self updatePossession ]
		for: self
]
