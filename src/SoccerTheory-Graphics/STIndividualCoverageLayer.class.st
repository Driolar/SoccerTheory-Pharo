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

	self resetRotation.
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

{ #category : 'private' }
STIndividualCoverageLayer >> lineColor [
	"Answer the line color depending on the defending team."

	^ scene defendingTeam
		  ifNotNil: [ :defendingTeam | defendingTeam gradientColorHigh ]
		  ifNil: [
				  (Color colorFrom: scene teamLeft gradientColorHigh)
					  alphaMixed: 0.5
					  with: (Color colorFrom: scene teamRight gradientColorHigh) ]
]

{ #category : 'rendering' }
STIndividualCoverageLayer >> lineShapeForCoveragePair: aSTIndividualCoveragePair [

	| playerShape1 playerShape2 lineShape |
	playerShape1 := self shapeFromModel:
		                aSTIndividualCoveragePair player1.
	playerShape2 := self shapeFromModel:
		                aSTIndividualCoveragePair player2.
	lineShape := RSLine newFrom: playerShape1 to: playerShape2.
	lineShape popupText:
		(aSTIndividualCoveragePair distance printShowingDecimalPlaces: 1)
		, ' m'.
	lineShape color: self lineColor.
	lineShape width: 2.
	aSTIndividualCoveragePair isMisplaced ifTrue: [ lineShape dashed ].
	^ lineShape
]

{ #category : 'rendering' }
STIndividualCoverageLayer >> orientDefender: aSTIndividualCoveragePair [
	"Let point the defender directly to the opponent, coinciding with connecting line orientation."

	"Negate the coverage rotation because world rotates counterclockwise but device clockwise."

	aSTIndividualCoveragePair defendingPlayer ifNotNil: [ :player |
			| shape |
			shape := self shapeFromModel: player.
			shape rotateByRadians:
				aSTIndividualCoveragePair coverageRotation negated ]
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

	| lineShape |
	lineShape := self lineShapeForCoveragePair: aSTIndividualCoveragePair.
	scene renderBeforeBall: lineShape.
	shapes add: lineShape.
	self orientDefender: aSTIndividualCoveragePair 
]

{ #category : 'initialization' }
STIndividualCoverageLayer >> resetRotation [

	(scene canvas shapesFromModels: scene teamLeft players) do: [
		:playerShape | playerShape resetRotation ].
	(scene canvas shapesFromModels: scene teamRight players) do: [
		:playerShape | playerShape resetRotation ]
]

{ #category : 'private' }
STIndividualCoverageLayer >> shapeFromModel: model [

	^ scene canvas shapeFromModel: model
]

{ #category : 'initialization' }
STIndividualCoverageLayer >> unregisterAtAnnouncer [

	self gameAnnouncer unsubscribe: self
]
