"
I render a soccer pitch just for demo/test purposes.

Currently using me: STDemoData and STDemoData2.
"
Class {
	#name : 'STBlocSoccerSceneSampleBuilder',
	#superclass : 'STBlocSoccerSceneBuilder',
	#category : 'SoccerTheory-Samples-Bloc',
	#package : 'SoccerTheory-Samples',
	#tag : 'Bloc'
}

{ #category : 'accessing' }
STBlocSoccerSceneSampleBuilder class >> sampleDeviceExtent [

	^ 556 @ 360
]

{ #category : 'accessing' }
STBlocSoccerSceneSampleBuilder >> borderWidth [

	^ 10
]

{ #category : 'initialization' }
STBlocSoccerSceneSampleBuilder >> initializeTransformerWithWorldExtent: aPoint [

	transformer := (STCoordinatesTransformer
		                newWithWorldExtent: aPoint
		                deviceExtent: self class sampleDeviceExtent)
		               setDeviceToBloc;
		               yourself
]
