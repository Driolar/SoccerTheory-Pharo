"
I am the abstract representation of two-dimensional soccer scenes.

I have a subclass for each graphical product.

Current concrete representations: STBlocSoccerScene (Bloc) and STRoassalSoccerScene (Roassal).
"
Class {
	#name : 'STSoccerScene',
	#superclass : 'Object',
	#instVars : [
		'transformer',
		'gameCommander'
	],
	#category : 'SoccerTheory-Graphics-Basic',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STSoccerScene class >> new [

	self shouldNotImplement
]

{ #category : 'instance creation' }
STSoccerScene class >> newWithGameCommander: aGameCommander [
	"Answer a new instance for application purpose with the given STGameCommander."

	^ self basicNew initializeWithGameCommander: aGameCommander
]

{ #category : 'viewing' }
STSoccerScene class >> viewPresenterClass [
	"Answer the SpPresenter class for presenting my views."

	self subclassResponsibility
]

{ #category : 'api' }
STSoccerScene >> addNewShapeOnPlayer: aPlayer [

	self subclassResponsibility
]

{ #category : 'private' }
STSoccerScene >> attackingTeam [
	"Answer the attacking team or nil if ball is neutral."

	^ gameCommander owningTeam
]

{ #category : 'private' }
STSoccerScene >> ball [
	"Answer the ball model."

	^ gameCommander ball
]

{ #category : 'paint' }
STSoccerScene >> borderExtent [
	"Answer the border extent as a Point."

	^ self borderWidth asPoint * 2
]

{ #category : 'accessing' }
STSoccerScene >> borderWidth [

	^ 30
]

{ #category : 'private' }
STSoccerScene >> defendingTeam [
	"Answer the defending team or nil if ball is neutral."

	^ gameCommander defendingTeam
]

{ #category : 'paint' }
STSoccerScene >> deviceGoalDepth [
	"Answer the goal depth in pixels."

	^ self borderWidth / 2
]

{ #category : 'paint' }
STSoccerScene >> deviceGoalWidth [
	"Answer the goal width in pixels."

	^ (transformer scaleWorldPoint: 0 @ self pitch goalWidth) y
]

{ #category : 'accessing' }
STSoccerScene >> gameAnnouncer [
	"Answer the announcer I register at."

	^ self ball gameAnnouncer 
]

{ #category : 'initialization' }
STSoccerScene >> initializeTransformerWithWorldExtent: aPoint [

	transformer := STCoordinatesTransformer
		               newWithWorldExtent: aPoint
]

{ #category : 'initialization' }
STSoccerScene >> initializeWithGameCommander: aSTGameCommander [

	self initialize.
	gameCommander := aSTGameCommander.
	self initializeTransformerWithWorldExtent:
		aSTGameCommander pitch extent
]

{ #category : 'private' }
STSoccerScene >> notifyCovering [

	gameCommander notifyCovering
]

{ #category : 'paint' }
STSoccerScene >> offsideLineColor [
	"Answer the current offside line Color."

	^ self defendingTeam ifNotNil: [ :team |
		  Color colorFrom: team gradientColorHigh ]
]

{ #category : 'private' }
STSoccerScene >> pitch [
	"Answer the pitch model."

	^ gameCommander pitch
]

{ #category : 'paint' }
STSoccerScene >> pitchColor [

	^ (Color fromHexString: '009666'). "dark cyan - lime green"
]

{ #category : 'paint' }
STSoccerScene >> pitchSurroundingColor [

	^ Color fromHexString: '66CC66' "Moderate lime green border"
]

{ #category : 'private' }
STSoccerScene >> playFieldExtent [
	"Answer the pitch's device extent."

	^ transformer deviceExtent
]

{ #category : 'initialization' }
STSoccerScene >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self gameAnnouncer
		when: STPlayerShapeMovedAnnouncement
		do: [ :ann |
				| player targetWorldPoint |
				player := ann player.
				targetWorldPoint := self toWorld: ann targetDevicePoint.
				gameCommander movePlayer: player toPosition: targetWorldPoint ]
		for: self.

	self gameAnnouncer
		when: STBallShapeMovedAnnouncement
		do: [ :ann |
				| targetWorldPoint |
				targetWorldPoint := self toWorld: ann targetDevicePoint.
				gameCommander moveBallToPosition: targetWorldPoint.
				self updateAttackLinePositionX: ann targetDevicePoint x ]
		for: self.

	self gameAnnouncer
		when: STBallPossessionChangedAnnouncement
		do: [ :ann | self updateAttackLineAppearance ]
		for: self.

	self gameAnnouncer
		when: STOffsideLineChangedAnnouncement
		do: [ :ann | self updateOffsideLinePositionX: ann offsideX ]
		for: self
]

{ #category : 'api' }
STSoccerScene >> renderViewIn: aBlSpaceOrRSCanvas [
	"Repopulate the play field with the current shapes."

	self subclassResponsibility
]

{ #category : 'initialization' }
STSoccerScene >> startAnnouncements [
	"Initiate my announcements."

	self registerAtAnnouncer.
	self notifyCovering
]

{ #category : 'private' }
STSoccerScene >> teamLeft [
	"Answer the team left."

	^ gameCommander teamLeft
]

{ #category : 'private' }
STSoccerScene >> teamRight [
	"Answer the team right."

	^ gameCommander teamRight
]

{ #category : 'api' }
STSoccerScene >> toWorld: aDevicePoint [
	"Transform device Point to world Point."

	^ transformer toWorld: aDevicePoint
]

{ #category : 'paint' }
STSoccerScene >> totalExtent [
	"Answer the total extent including the play field's border"

	^ self playFieldExtent + self borderExtent 
]

{ #category : 'paint' }
STSoccerScene >> updateAttackLineAppearance [
	"Update the attack line appearance depending on the attacking team."

	self subclassResponsibility
]

{ #category : 'paint' }
STSoccerScene >> updateAttackLinePositionX: deviceX [
	"Lazy create and add the attack line shape and update its position."

	self subclassResponsibility
]

{ #category : 'paint' }
STSoccerScene >> updateOffsideLinePositionX: worldX [
	"Lazy create and add the offside line shape and update its position."

	self subclassResponsibility
]
