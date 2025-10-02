Class {
	#name : 'STDemoData',
	#superclass : 'Object',
	#category : 'SoccerTheory-Samples-Node',
	#package : 'SoccerTheory-Samples',
	#tag : 'Node'
}

{ #category : 'private' }
STDemoData >> defaultOutfieldPlayer [

	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: 0 @ 0
		          team: soccerFrame teamLeft
		          frame: soccerFrame
		          number: 2.
	^ player
]

{ #category : 'showing scenes' }
STDemoData >> newEmptyFrame [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ STSoccerFrameBuilder emptyFrameWithPitch: STPitch newDefault
]

{ #category : 'private' }
STDemoData >> newSampleSceneWithFrame: aFrame [

	^ STSoccerSceneBlocSample newWithGameCommander:
		  (STGameCommander newWithFrame: aFrame)
]

{ #category : 'showing scenes' }
STDemoData >> newStartFrame [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ STSoccerFrameBuilder startFrameWithPitch: STPitch newDefault
]

{ #category : 'show icons' }
STDemoData >> showAttackLine [

	<demo>
	^ STAttackLineBlElement
		  newWithSegmentLength: 100
		  strategicX: 5
		  color: Color black
]

{ #category : 'showing shapes' }
STDemoData >> showBall [

	<demo>
	^ STBallBlElement
		  newForBall: self newEmptyFrame ball
		  graphicFactory: STGraphicFactory new
		  playFieldExtent: STCoordinatesTransformer sampleDeviceExtent
]

{ #category : 'showing shapes' }
STDemoData >> showBallWithShadow [

	<demo>
	^ (STBallBlElement
		   newForBall: self newEmptyFrame ball
		   graphicFactory: STGraphicFactory new
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showShadow
]

{ #category : 'show icons' }
STDemoData >> showDefenceLine [

	<demo>
	^ STOffsideLineBlElement
	newWithSegmentLength: 100
	strategicX: 5
	color: Color black
]

{ #category : 'showing scenes' }
STDemoData >> showEmptyPitch [

	<demo>
	^ (self newSampleSceneWithFrame: self newEmptyFrame) surface
]

{ #category : 'showing shapes' }
STDemoData >> showGoalkeeperOffside [

	<demo>
	| player |
	player := self defaultOutfieldPlayer.
	player makeGoalkeeper.
	^ (STPlayerBlElement
		   newWithPlayer: player
		   graphicFactory: self symbolFactory
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showOffside
]

{ #category : 'showing shapes' }
STDemoData >> showGoalkeeperOffside2 [

	<demo>
	| player |
	player := self defaultOutfieldPlayer.
	player makeGoalkeeper.
	^ (STPlayerBlElement
		   newWithPlayer: player
		   graphicFactory: self symbolFactory2
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showOffside
]

{ #category : 'showing shapes' }
STDemoData >> showGoalkeeperUncovered [

	<demo>
	| player |
	player := self defaultOutfieldPlayer.
	player makeGoalkeeper.
	^ (STPlayerBlElement
		   newWithPlayer: player
		   graphicFactory: self symbolFactory
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showUncovered
]

{ #category : 'showing shapes' }
STDemoData >> showGoalkeeperUncovered2 [

	<demo>
	| player |
	player := self defaultOutfieldPlayer.
	player makeGoalkeeper.
	^ (STPlayerBlElement
		   newWithPlayer: player
		   graphicFactory: self symbolFactory2
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showUncovered
]

{ #category : 'show icons' }
STDemoData >> showIconForBall [

	<demo>
	^ STGraphicFactory new ballForm asElement
]

{ #category : 'showing shapes' }
STDemoData >> showOutfieldPlayerOffside [

	<demo>
	^ (STPlayerBlElement
		   newWithPlayer: self defaultOutfieldPlayer
		   graphicFactory: self symbolFactory
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showOffside
]

{ #category : 'showing shapes' }
STDemoData >> showOutfieldPlayerOffside2 [

	<demo>
	^ (STPlayerBlElement
		   newWithPlayer: self defaultOutfieldPlayer
		   graphicFactory: self symbolFactory2
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showOffside
]

{ #category : 'showing shapes' }
STDemoData >> showOutfieldPlayerUncovered [

	<demo>
	^ (STPlayerBlElement
		   newWithPlayer: self defaultOutfieldPlayer
		   graphicFactory: self symbolFactory
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showUncovered
]

{ #category : 'showing shapes' }
STDemoData >> showOutfieldPlayerUncovered2 [

	<demo>
	^ (STPlayerBlElement
		   newWithPlayer: self defaultOutfieldPlayer
		   graphicFactory: self symbolFactory2
		   playFieldExtent: STCoordinatesTransformer sampleDeviceExtent)
		  showUncovered
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerAtBottomLeft [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := self newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition: (pitchExtent / 2) negated
		          team: soccerFrame teamLeft
		          frame: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene surface
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerAtBottomRight [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := self newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition:
		          pitchExtent x / 2 @ (pitchExtent y / 2) negated
		          team: soccerFrame teamLeft
		          frame: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene surface
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerAtTopLeft [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := self newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition:
		          (pitchExtent x / 2) negated @ pitchExtent y / 2
		          team: soccerFrame teamLeft
		          frame: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene surface
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerAtTopRight [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := self newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition: pitchExtent / 2
		          team: soccerFrame teamLeft
		          frame: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene surface
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerInMiddle [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := self newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition: soccerFrame pitch middle
		          team: soccerFrame teamLeft
		          frame: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene surface
]

{ #category : 'showing scenes' }
STDemoData >> showStartPitch [

	<demo>
	^ (self newSampleSceneWithFrame: self newStartFrame) surface
]

{ #category : 'show icons' }
STDemoData >> showSymbolForAddingToTeam [

	<demo>
	^ STGraphicFactory new plusSignElement 
]

{ #category : 'show icons' }
STDemoData >> showSymbolForGoalkeeper [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ STGraphicFactory new goalkeeperElement 
]

{ #category : 'show icons' }
STDemoData >> showSymbolForOffside [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ STGraphicFactory new offsideElement 
]

{ #category : 'show icons' }
STDemoData >> showSymbolForOffside2 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ STGraphicFactory2 new offsideElement
]

{ #category : 'show icons' }
STDemoData >> showSymbolForUncovered [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ STGraphicFactory new uncoveredElement 
]

{ #category : 'show icons' }
STDemoData >> showSymbolForUncovered2 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ STGraphicFactory2 new uncoveredElement 
]

{ #category : 'private' }
STDemoData >> symbolFactory [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ STGraphicFactory new
]

{ #category : 'private' }
STDemoData >> symbolFactory2 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ STGraphicFactory2 new
]
