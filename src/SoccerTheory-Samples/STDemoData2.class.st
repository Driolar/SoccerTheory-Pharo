Class {
	#name : 'STDemoData2',
	#superclass : 'Object',
	#category : 'SoccerTheory-Samples-Node',
	#package : 'SoccerTheory-Samples',
	#tag : 'Node'
}

{ #category : 'instance creation' }
STDemoData2 >> newSampleSceneWithFrame: aFrame [

	^ STBlocSoccerSceneSampleBuilder newWithGameCommander:
		  (STGameCommander newWithFrame: aFrame)
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture1 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ (self newSampleSceneWithFrame: STSoccerFrameBuilder fixture1Frame)
		  surface
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture2 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ (self newSampleSceneWithFrame: STSoccerFrameBuilder fixture2Frame)
		  surface
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture3 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ (self newSampleSceneWithFrame: STSoccerFrameBuilder fixture3Frame)
		  surface
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture4 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ (self newSampleSceneWithFrame: STSoccerFrameBuilder fixture4Frame)
		  surface
]
