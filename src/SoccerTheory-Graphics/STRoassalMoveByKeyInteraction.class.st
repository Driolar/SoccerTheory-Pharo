"
I facilitate the moving of a selected player or ball by pressing the arrow keys.
"
Class {
	#name : 'STRoassalMoveByKeyInteraction',
	#superclass : 'RSInteraction',
	#instVars : [
		'movableShape'
	],
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'hooks' }
STRoassalMoveByKeyInteraction >> onShape: aShape [

	movableShape := aShape.
	aShape canvas when: RSKeyDown send: #stepTheArrowWay: to: self
]

{ #category : 'private' }
STRoassalMoveByKeyInteraction >> stepTheArrowWay: aRSKeyDown [
	"Move me one step following the given keyboard key if it is an arrow key."
	
	movableShape stepTheArrowWay: aRSKeyDown 
]
