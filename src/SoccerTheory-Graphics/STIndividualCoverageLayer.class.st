"
I render the layer that shows the computed individual coverage pairs.
"
Class {
	#name : 'STIndividualCoverageLayer',
	#superclass : 'STStrategyLayer',
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'rendering' }
STIndividualCoverageLayer >> clearAll [

	self resetRotation.
	super clearAll
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
