"
I render a soccer pitch just for demo/test purposes.

Currently using me: STDemoData and STDemoData2.
"
Class {
	#name : 'STSoccerSceneBlocSample',
	#superclass : 'STSoccerSceneBloc',
	#category : 'SoccerTheory-Samples-Bloc',
	#package : 'SoccerTheory-Samples',
	#tag : 'Bloc'
}

{ #category : 'accessing' }
STSoccerSceneBlocSample >> borderWidth [

	^ 10
]

{ #category : 'initialization' }
STSoccerSceneBlocSample >> initializeTransformerWithWorldExtent: aPoint [

	transformer := (STCoordinatesTransformer
		                newForSampleWithWorldExtent: aPoint)
		               setDeviceToBloc;
		               yourself
]
