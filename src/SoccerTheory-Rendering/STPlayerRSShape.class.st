"
I am a visual player whose model is STPlayer.

I visualize

•	my team color
•	my jersey number
•	if I am offside
•	if I am uncovered
•	if I am goalkeeper.


Also I am pullable.
"
Class {
	#name : 'STPlayerRSShape',
	#superclass : 'RSPolygon',
	#category : 'SoccerTheory-Rendering-Roassal',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
STPlayerRSShape class >> newForPlayer: aSTPlayer centerPoint: aPoint [

	^ self new initializeForPlayer: aSTPlayer centerPoint: aPoint
]

{ #category : 'initialization' }
STPlayerRSShape >> initializeForPlayer: aSTPlayer centerPoint: center [

	| team apex baseLeft baseRight trianglePoints |
	team := aSTPlayer team.	
	apex := center x @ (center y - 9).
	baseLeft := center x - 9 @ (center y + 9).
	baseRight := center + 9.
	trianglePoints := {
		                  baseLeft.
		                  apex.
		                  baseRight }.
	self
		points: trianglePoints;
		color: team gradientColorHigh;
		model: aSTPlayer;
		@ RSDraggable.
	team isTeamLeft
		ifTrue: [ self rotateByDegrees: 90 ]
		ifFalse: [ self rotateByDegrees: 90 negated ]
]
