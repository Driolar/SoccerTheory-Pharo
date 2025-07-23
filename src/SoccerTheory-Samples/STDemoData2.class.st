Class {
	#name : 'STDemoData2',
	#superclass : 'Object',
	#category : 'SoccerTheory-Samples-Node',
	#package : 'SoccerTheory-Samples',
	#tag : 'Node'
}

{ #category : 'instance creation' }
STDemoData2 >> newSampleSceneWithFrame: aFrame [

	^ STSoccerScene newSampleSceneWithGameCommander:
		  (STGameCommander newWithFrame: aFrame)
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture1 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ self newSampleSceneWithFrame: STSoccerFrameBuilder fixture1Frame
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture2 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ self newSampleSceneWithFrame: STSoccerFrameBuilder fixture2Frame
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture3 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ self newSampleSceneWithFrame: STSoccerFrameBuilder fixture3Frame
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture4 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ self newSampleSceneWithFrame: STSoccerFrameBuilder fixture4Frame
]
