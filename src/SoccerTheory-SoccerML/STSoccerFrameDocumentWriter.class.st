"
I produce a SoccerML document for a STSoccerFrame instance.
"
Class {
	#name : 'STSoccerFrameDocumentWriter',
	#superclass : 'Object',
	#instVars : [
		'socMLWriter'
	],
	#category : 'SoccerTheory-SoccerML-Base',
	#package : 'SoccerTheory-SoccerML',
	#tag : 'Base'
}

{ #category : 'instance creation' }
STSoccerFrameDocumentWriter class >> on: aSTSoccerFrame [
	
	^ self new initializeWith: aSTSoccerFrame 
]

{ #category : 'api' }
STSoccerFrameDocumentWriter >> writeWholeDocument [
	"Answer the whole document after having built it entirely."

	^ socMLWriter writeWholeDocument
]
