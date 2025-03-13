"
I represent a soccer frame.

A soccer frame is a snapshot of a soccer play.
"
Class {
	#name : 'STSoccerFrame',
	#superclass : 'STSoccerPlay',
	#classVars : [
		'UniqueAnnouncer'
	],
	#category : 'SoccerTheory-Model-Operate',
	#package : 'SoccerTheory-Model',
	#tag : 'Operate'
}

{ #category : 'accessing' }
STSoccerFrame class >> announcer [
	"Answer the unique announcer (singleton)"

	UniqueAnnouncer ifNil: [ UniqueAnnouncer := Announcer new ].
	^ UniqueAnnouncer
]

{ #category : 'accessing' }
STSoccerFrame >> announcer [ 
	"Answer the unique announcer (singleton)"

	^self class announcer 
]
