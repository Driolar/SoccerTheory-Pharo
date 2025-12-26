"
I contain an extract of game events for a STTeam:
- goal moments
- possession share intervals
- intervals of numerical superiority
"
Class {
	#name : 'STMatchEventExtract',
	#superclass : 'Object',
	#instVars : [
		'goalMoments',
		'possessionEndpoints',
		'numericalSuperiorityEndPoints',
		'teamName',
		'teamGradientColorLow',
		'teamGradientColorHigh'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'instance creation' }
STMatchEventExtract class >> newAwayTeamName: aString [

	^ self new initializeAwayTeamName: aString
]

{ #category : 'instance creation' }
STMatchEventExtract class >> newHomeTeamName: aString [

	^ self new initializeHomeTeamName: aString
]

{ #category : 'private' }
STMatchEventExtract >> countFramesFromEndpoints: endpointCollection [

	^ endpointCollection
		  ifNotEmpty: [ :endpoints |
			  (endpoints pairsCollect: [ :from :to | to - from + 1 ]) sum ]
		  ifEmpty: [ 0 ]
]

{ #category : 'accessing' }
STMatchEventExtract >> countNumericalSuperiorityFrames [

	^ self countFramesFromEndpoints: self numericalSuperiorityEndPoints
]

{ #category : 'accessing' }
STMatchEventExtract >> countPossessionFrames [

	^ self countFramesFromEndpoints: self possessionEndpoints
]

{ #category : 'api' }
STMatchEventExtract >> goalMoments [

	^ goalMoments
]

{ #category : 'accessing' }
STMatchEventExtract >> goalMoments: anObject [

	goalMoments := anObject
]

{ #category : 'initialization' }
STMatchEventExtract >> initialize [

	super initialize.
	goalMoments := SortedCollection new.
	numericalSuperiorityEndPoints := SortedCollection new.
	possessionEndpoints := SortedCollection new
]

{ #category : 'initialization' }
STMatchEventExtract >> initializeAwayTeamName: aString [

	teamName := aString.
	teamGradientColorLow := '#00FFFF'.
	teamGradientColorHigh := '#0000FF'
]

{ #category : 'initialization' }
STMatchEventExtract >> initializeHomeTeamName: aString [

	teamName := aString.
	teamGradientColorLow := '#FF00FF'.
	teamGradientColorHigh := '#FF0000'
]

{ #category : 'accessing' }
STMatchEventExtract >> numericalSuperiorityEndPoints [

	^ numericalSuperiorityEndPoints
]

{ #category : 'accessing' }
STMatchEventExtract >> numericalSuperiorityEndPoints: anObject [

	numericalSuperiorityEndPoints := anObject
]

{ #category : 'api' }
STMatchEventExtract >> possessionEndpoints [

	^ possessionEndpoints
]

{ #category : 'accessing' }
STMatchEventExtract >> possessionEndpoints: anObject [

	possessionEndpoints := anObject
]

{ #category : 'accessing' }
STMatchEventExtract >> teamGradientColorHigh [

	^ teamGradientColorHigh 
]

{ #category : 'accessing' }
STMatchEventExtract >> teamGradientColorLow [

	^ teamGradientColorLow
]

{ #category : 'accessing' }
STMatchEventExtract >> teamName [

	^ teamName
]

{ #category : 'accessing' }
STMatchEventExtract >> teamName: aString [

	teamName := aString
]
