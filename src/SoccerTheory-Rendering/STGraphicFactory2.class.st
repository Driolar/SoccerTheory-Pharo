"
I am a second graphic factory to demonstrate easy factory replacement.

Only the samples demonstration uses me.
"
Class {
	#name : 'STGraphicFactory2',
	#superclass : 'STGraphicFactory',
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'accessing' }
STGraphicFactory2 >> offsideElement [
	"Answer an alternate BlElement tagging a player as being offside."

	^ BlElement new
		  background: Color yellow;
		  geometry: BlTriangleGeometry new beRight;
		  extent: 12 @ 12;
		  position: 3 asPoint
]

{ #category : 'accessing' }
STGraphicFactory2 >> uncoveredElement [
	"Answer an alternate BlElement tagging a player as being uncovered."

	^ BlElement new
		  background: Color black;
		  geometry: BlCircleGeometry new;
		  extent: 12 @ 12;
		  position: 3 asPoint
]
