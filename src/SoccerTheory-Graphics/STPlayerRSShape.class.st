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
	#superclass : 'RSComposite',
	#instVars : [
		'centerPoint',
		'player'
	],
	#category : 'SoccerTheory-Graphics-Roassal',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Roassal'
}

{ #category : 'instance creation' }
STPlayerRSShape class >> newForPlayer: aSTPlayer centerPoint: aPoint [

	^ self new initializeForPlayer: aSTPlayer centerPoint: aPoint
]

{ #category : 'private' }
STPlayerRSShape >> circle [

	^ RSCircle new
		  center: centerPoint;
		  radius: 9;
		  color: self teamColor;
		  yourself
]

{ #category : 'private' }
STPlayerRSShape >> distinctColor [
	"Answer a color that won't be coincide with my team color."

	^ (Color fromHexString: self teamColor) negated asHexString
]

{ #category : 'private' }
STPlayerRSShape >> eye [

	| center correction |
	"Correct optical deceit."
	correction := player isGoalkeeper
		              ifTrue: [ 0 ]
		              ifFalse: [ 2 ].
	center := self team isTeamLeft
		          ifTrue: [ centerPoint x - correction @ centerPoint y ]
		          ifFalse: [ centerPoint x + correction @ centerPoint y ].

	^ (STGraphicFactory new svgEyeWithColor: self distinctColor)
		  fromRectangle: (Rectangle center: center extent: 22 @ 22);
		  scaleBy: 0.5;
		  yourself
]

{ #category : 'private' }
STPlayerRSShape >> flag [

	| flag |
	flag := self team isTeamLeft
		        ifTrue: [
			        STGraphicFactory new svgFlagWavingToRightWithColor:
				        self distinctColor ]
		        ifFalse: [
			        STGraphicFactory new svgFlagWavingToLeftWithColor:
				        self distinctColor ].

	^ flag
		  translateTo: centerPoint;
		  scaleBy: 0.7;
		  yourself
]

{ #category : 'initialization' }
STPlayerRSShape >> initializeForPlayer: aSTPlayer centerPoint: aPoint [

	player := aSTPlayer.
	centerPoint := aPoint.

	self
		shapes: self shapes;
		model: aSTPlayer;
		@ RSDraggable.	
]

{ #category : 'accessing' }
STPlayerRSShape >> shapes [

	| shapes |
	shapes := OrderedCollection new.
	shapes add: self triangle.
	player isGoalkeeper ifTrue: [ shapes add: self circle ].
	"	shapes add: self eye."
	shapes add: self flag.
	^ shapes
]

{ #category : 'private' }
STPlayerRSShape >> team [

	^ player team
]

{ #category : 'private' }
STPlayerRSShape >> teamColor [

	^ self team gradientColorHigh
]

{ #category : 'private' }
STPlayerRSShape >> triangle [

	| apex baseLeft baseRight trianglePoints triangle |
	apex := centerPoint x @ (centerPoint y - 9).
	baseLeft := centerPoint x - 9 @ (centerPoint y + 9).
	baseRight := centerPoint + 9.
	trianglePoints := {
		                  baseLeft.
		                  apex.
		                  baseRight }.
	triangle := RSPolygon new
		            points: trianglePoints;
		            color: self teamColor;
		            yourself.
	self team isTeamLeft
		ifTrue: [ triangle rotateByDegrees: 90 ]
		ifFalse: [ triangle rotateByDegrees: 90 negated ].
	^ triangle
]
