"
I render a soccer pitch just for demo/test purposes.

Currently using me: STDemoData and STDemoData2.
"
Class {
	#name : 'STBlocSoccerSceneSampleBuilder',
	#superclass : 'STBlocSoccerSceneBuilder',
	#category : 'SoccerTheory-Graphics-Bloc',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Bloc'
}

{ #category : 'accessing' }
STBlocSoccerSceneSampleBuilder >> borderWidth [

	^ 10
]

{ #category : 'initialization' }
STBlocSoccerSceneSampleBuilder >> initializeTransformerWithWorldExtent: aPoint [

	transformer := (STCoordinatesTransformer
		                newForSampleWithWorldExtent: aPoint)
		               setDeviceToBloc;
		               yourself
]
