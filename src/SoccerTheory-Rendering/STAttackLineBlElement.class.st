"
I am the attack line (ball crossing line).

I run at ball's level in parallel to the goal lines.
I take the color of the attacking team.
If ball possession is neutral, my color is also neutral.

I am a boundary of the active zone, a rectangle where it is specially important to observe the covering relations.
The active zone boundaries are: both side lines, the defending team's goal line and me.

My both segment end points are decorated by a triagle each.
The triangle point to the attack direction.
"
Class {
	#name : 'STAttackLineBlElement',
	#superclass : 'STStrategicLineBlElement',
	#instVars : [
		'attackingTeam'
	],
	#category : 'SoccerTheory-Rendering-Bloc',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Bloc'
}

{ #category : 'initialization' }
STAttackLineBlElement class >> newWithSegmentLength: length strategicX: xCoordinate attackingTeam: aSTTeam [

	^ self new
		  initializeWithSegmentLength: length
		  strategicX: xCoordinate
		  attackingTeam: aSTTeam
]

{ #category : 'private' }
STAttackLineBlElement >> borderBuilder [
	"Answer my border builder."

	^ super borderBuilder dashed
]

{ #category : 'private' }
STAttackLineBlElement >> bottomEndPointTriangle [
	"Answer the bottom end point triangle."

	^ self childWithId: #bottomEndPoint
]

{ #category : 'accessing' }
STAttackLineBlElement >> changeAppearanceForAttackingTeam: aSTTeam [
	"Take the appearance (color and orientation of the end point triangles) for aSTTeam."

	attackingTeam := aSTTeam.
	self color: self teamColor.
	self orientateEndPointTriangles
]

{ #category : 'initialization' }
STAttackLineBlElement >> initializeWithSegmentLength: length strategicX: xCoordinate attackingTeam: aSTTeam [

	attackingTeam := aSTTeam.
	self
		initializeWithSegmentLength: length
		strategicX: xCoordinate
		color: self teamColor.
	self orientateEndPointTriangles
]

{ #category : 'private' }
STAttackLineBlElement >> newBottomEndPoint [
	"Answer a new BlElement to decorate the segment's bottom end."

	| endPoint |
	endPoint := self newEndPointTrianglePrototype.
	endPoint geometry beBottom.
	^ endPoint
]

{ #category : 'private' }
STAttackLineBlElement >> newTopEndPoint [
	"Answer a new BlElement to decorate the segment's top end."

	| endPoint |
	endPoint := self newEndPointTrianglePrototype.
	endPoint geometry beTop.
	^ endPoint
]

{ #category : 'private' }
STAttackLineBlElement >> orientateEndPointTriangles [
	"Orientate my end point triangles to the attack direction."

	attackingTeam
		ifNotNil: [ :team |
			team isTeamLeft
				ifTrue: [ self orientateEndPointTrianglesRight ]
				ifFalse: [ self orientateEndPointTrianglesLeft ] ]
		ifNil: [ self orientateEndPointTrianglesVertical ]
]

{ #category : 'private' }
STAttackLineBlElement >> orientateEndPointTrianglesLeft [
	"Orientate my end point triangles to the left."

	self topEndPointTriangle geometry beLeft.
	self topEndPointTriangle position: self endPointSize negated @ 0.
	self bottomEndPointTriangle geometry beLeft.
	self bottomEndPointTriangle position:
		self endPointSize negated @ (segmentLength - self endPointSize)
]

{ #category : 'private' }
STAttackLineBlElement >> orientateEndPointTrianglesRight [
	"Orientate my end point triangles to the right."

	self topEndPointTriangle geometry beRight.
	self topEndPointTriangle position: 0 / 2 @ 0.
	self bottomEndPointTriangle geometry beRight.
	self bottomEndPointTriangle position:
		0 @ (segmentLength - self endPointSize)
]

{ #category : 'private' }
STAttackLineBlElement >> orientateEndPointTrianglesVertical [
	"Orientate my end point triangles vertical."

	self topEndPointTriangle geometry beTop.
	self topEndPointTriangle position:
		(self endPointSize / 2) negated @ 0.
	self bottomEndPointTriangle geometry beBottom.
	self bottomEndPointTriangle position:
		(self endPointSize / 2) negated
		@ (segmentLength - self endPointSize)
]

{ #category : 'accessing' }
STAttackLineBlElement >> strategicXValue: xDeviceCoordinate attackingTeam: aSTTeam [
	"Set my current (sliding) device x-coordinate and the attacking team."

	attackingTeam := aSTTeam.
	self strategicXValue: xDeviceCoordinate color: self teamColor
]

{ #category : 'private' }
STAttackLineBlElement >> teamColor [
	"Answer the line color to represent the attacking team."

	^ attackingTeam
		  ifNotNil: [ :team | Color colorFrom: team gradientColorHigh ]
		  ifNil: [ Color yellow ]
]

{ #category : 'private' }
STAttackLineBlElement >> topEndPointTriangle [
	"Answer the top end point triangle."

	^ self childWithId: #topEndPoint
]
