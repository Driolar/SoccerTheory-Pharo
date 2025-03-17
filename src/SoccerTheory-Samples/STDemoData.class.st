Class {
	#name : 'STDemoData',
	#superclass : 'Object',
	#category : 'SoccerTheory-Samples-Node',
	#package : 'SoccerTheory-Samples',
	#tag : 'Node'
}

{ #category : 'showing scenes' }
STDemoData >> newEmptyFrame [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ STSoccerFrameBuilder emptyFrameWithPitch: STPitch newDefault
]

{ #category : 'showing scenes' }
STDemoData >> newStartFrame [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	^ STSoccerFrameBuilder startFrameWithPitch: STPitch newDefault
]

{ #category : 'showing shapes' }
STDemoData >> showBall [

	<demo>
	^ STBallShape
		  newForBall: self newEmptyFrame ball
		  graphicFactory: STGraphicFactory new
]

{ #category : 'showing shapes' }
STDemoData >> showBallWithShadow [

	<demo>
	^ (STBallShape
		  newForBall: self newEmptyFrame ball
		  graphicFactory: STGraphicFactory new) showShadow 
]

{ #category : 'showing scenes' }
STDemoData >> showEmptyPitch [

	<demo>
	^ STSoccerScene newSampleSceneWithFrame: self newEmptyFrame
]

{ #category : 'showing shapes' }
STDemoData >> showGoalkeeperOffside [

	<demo>
	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: (Point x: 0 negated y: 0)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	player makeGoalkeeper.
	^ (STPlayerShape
		   newWithPlayer: player
		   graphicFactory: self symbolFactory) showOffside
]

{ #category : 'showing shapes' }
STDemoData >> showGoalkeeperOffside2 [

	<demo>
	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: (Point x: 0 negated y: 0)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	player makeGoalkeeper.
	^ (STPlayerShape
		   newWithPlayer: player
		   graphicFactory: self symbolFactory2) showOffside
]

{ #category : 'showing shapes' }
STDemoData >> showGoalkeeperUncovered [

	<demo>
	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: (Point x: 0 negated y: 0)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	player makeGoalkeeper.
	^ (STPlayerShape
		   newWithPlayer: player
		   graphicFactory: self symbolFactory) showUncovered
]

{ #category : 'showing shapes' }
STDemoData >> showGoalkeeperUncovered2 [

	<demo>
	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: (Point x: 0 negated y: 0)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	player makeGoalkeeper.
	^ (STPlayerShape
		   newWithPlayer: player
		   graphicFactory: self symbolFactory2) showUncovered
]

{ #category : 'show icons' }
STDemoData >> showIconForBall [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ STGraphicFactory new ballForm asElement 
]

{ #category : 'showing shapes' }
STDemoData >> showOutfieldPlayerOffside [

	<demo>
	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: (Point x: 0 negated y: 0)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	^ (STPlayerShape
		   newWithPlayer: player
		   graphicFactory: self symbolFactory) showOffside
]

{ #category : 'showing shapes' }
STDemoData >> showOutfieldPlayerOffside2 [

	<demo>
	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: (Point x: 0 negated y: 0)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	^ (STPlayerShape
		   newWithPlayer: player
		   graphicFactory: self symbolFactory2) showOffside
]

{ #category : 'showing shapes' }
STDemoData >> showOutfieldPlayerUncovered [

	<demo>
	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: (Point x: 0 negated y: 0)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	^ (STPlayerShape
		   newWithPlayer: player
		   graphicFactory: self symbolFactory) showUncovered
]

{ #category : 'showing shapes' }
STDemoData >> showOutfieldPlayerUncovered2 [

	<demo>
	| soccerFrame player |
	soccerFrame := self newEmptyFrame.
	player := STPlayer
		          newWithPosition: (Point x: 0 negated y: 0)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	^ (STPlayerShape
		   newWithPlayer: player
		   graphicFactory: self symbolFactory2) showUncovered
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerAtBottomLeft [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := STSoccerScene newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition: (pitchExtent / 2) negated
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerAtBottomRight [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := STSoccerScene newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition:
		          (Point x: pitchExtent x / 2 y: (pitchExtent y / 2) negated)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerAtTopLeft [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := STSoccerScene newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition:
		          (Point x: (pitchExtent x / 2) negated y: pitchExtent y / 2)
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerAtTopRight [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := STSoccerScene newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition: pitchExtent / 2
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene
]

{ #category : 'showing scenes' }
STDemoData >> showPitchWithPlayerInMiddle [

	<demo>
	| soccerFrame soccerScene pitchExtent player |
	soccerFrame := self newEmptyFrame.
	pitchExtent := soccerFrame pitch extent.
	soccerScene := STSoccerScene newSampleSceneWithFrame: soccerFrame.
	player := STPlayer
		          newWithPosition: soccerFrame pitch middle
		          team: soccerFrame teamLeft
		          play: soccerFrame
		          number: 2.
	soccerScene addNewShapeOnPlayer: player.
	^ soccerScene
]

{ #category : 'showing scenes' }
STDemoData >> showStartPitch [

	<demo>
	^ STSoccerScene newSampleSceneWithFrame: self newStartFrame
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
