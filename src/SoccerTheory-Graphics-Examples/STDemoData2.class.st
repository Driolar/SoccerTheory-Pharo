Class {
	#name : 'STDemoData2',
	#superclass : 'Object',
	#category : 'SoccerTheory-Graphics-Examples-Node',
	#package : 'SoccerTheory-Graphics-Examples',
	#tag : 'Node'
}

{ #category : 'instance creation' }
STDemoData2 >> newSampleSceneWithFrame: aFrame [

	^ STBlocSoccerSceneSample newWithGameCommander:
		  (STGameCommander newWithFrame: aFrame)
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture1 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ (self newSampleSceneWithFrame: STSoccerFrameBuilder fixture1Frame)
		  sceneView
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture2 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ (self newSampleSceneWithFrame: STSoccerFrameBuilder fixture2Frame)
		  sceneView
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture3 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ (self newSampleSceneWithFrame: STSoccerFrameBuilder fixture3Frame)
		  sceneView
]

{ #category : 'showing scenes' }
STDemoData2 >> showFixture4 [
	"comment stating purpose of instance-side method"

	"scope: class-variables  &  instance-variables"

	<demo>
	^ (self newSampleSceneWithFrame: STSoccerFrameBuilder fixture4Frame)
		  sceneView
]
