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
		'team',
		'goalMoments',
		'possessionEndpoints',
		'numericalSuperiorityEndPoints'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'accessing' }
STMatchEventExtract >> goalMoments [

	^ goalMoments
]

{ #category : 'accessing' }
STMatchEventExtract >> goalMoments: anObject [

	goalMoments := anObject
]

{ #category : 'accessing' }
STMatchEventExtract >> numericalSuperiorityEndPoints [

	^ numericalSuperiorityEndPoints
]

{ #category : 'accessing' }
STMatchEventExtract >> numericalSuperiorityEndPoints: anObject [

	numericalSuperiorityEndPoints := anObject
]

{ #category : 'accessing' }
STMatchEventExtract >> possessionEndpoints [

	^ possessionEndpoints
]

{ #category : 'accessing' }
STMatchEventExtract >> possessionEndpoints: anObject [

	possessionEndpoints := anObject
]

{ #category : 'accessing' }
STMatchEventExtract >> team [

	^ team
]

{ #category : 'accessing' }
STMatchEventExtract >> team: anObject [

	team := anObject
]
