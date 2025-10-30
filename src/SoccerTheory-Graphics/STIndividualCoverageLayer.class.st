"
I render the layer that shows the computed individual coverage pairs.
"
Class {
	#name : 'STIndividualCoverageLayer',
	#superclass : 'Object',
	#instVars : [
		'scene',
		'shapes'
	],
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
STIndividualCoverageLayer class >> newOn: aSTRoassalSoccerScene [

	^self new initializeOn: aSTRoassalSoccerScene
]

{ #category : 'rendering' }
STIndividualCoverageLayer >> clearAll [

	shapes do: [ :shape | shape remove ].
	shapes removeAll. 
	scene signalUpdate
]

{ #category : 'private' }
STIndividualCoverageLayer >> gameAnnouncer [

	^ scene gameAnnouncer
]

{ #category : 'initialization' }
STIndividualCoverageLayer >> initialize [

	super initialize.
	shapes := OrderedCollection new
]

{ #category : 'initialization' }
STIndividualCoverageLayer >> initializeOn: aSTRoassalSoccerScene [

	scene := aSTRoassalSoccerScene.
	self registerAtAnnouncer
]

{ #category : 'accessing' }
STIndividualCoverageLayer >> lineColor [
	"Answer the line color depending on the defending team."

	^ scene defendingTeam
		  ifNotNil: [ :defendingTeam | defendingTeam gradientColorHigh ]
		  ifNil: [
				  (Color colorFrom: scene teamLeft gradientColorHigh)
					  alphaMixed: 0.5
					  with: (Color colorFrom: scene teamRight gradientColorHigh) ]
]

{ #category : 'initialization' }
STIndividualCoverageLayer >> registerAtAnnouncer [

	self gameAnnouncer
		when: STCoverageUpdatedAnnouncement
		do: [ :ann | self render ]
		for: self
]

{ #category : 'rendering' }
STIndividualCoverageLayer >> render [

	| coveragePairs |
	self clearAll.

	coveragePairs := (STIndividualCoverage newWithFrame: scene frame)
		                 cover.
	coveragePairs do: [ :coveragePair |
		self renderCoveragePair: coveragePair ].
	scene signalUpdate
]

{ #category : 'rendering' }
STIndividualCoverageLayer >> renderCoveragePair: aSTIndividualCoveragePair [

	| playerShape1 playerShape2 lineShape |
	playerShape1 := scene canvas shapeFromModel:
		                aSTIndividualCoveragePair player1.
	playerShape2 := scene canvas shapeFromModel:
		                aSTIndividualCoveragePair player2.
	lineShape := RSLine newFrom: playerShape1 to: playerShape2.
	lineShape popupText:
		(aSTIndividualCoveragePair distance printShowingDecimalPlaces: 1)
		, ' m'.
	lineShape color: self lineColor.
	lineShape width: 2.
	aSTIndividualCoveragePair isMisplaced ifTrue: [ lineShape dashed ].
	scene renderBeforeBall: lineShape.
	shapes add: lineShape
]

{ #category : 'initialization' }
STIndividualCoverageLayer >> unregisterAtAnnouncer [

	self gameAnnouncer unsubscribe: self
]
