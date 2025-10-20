"
I render a soccer pitch just for demo/test purposes.

Currently using me: STDemoData and STDemoData2.
"
Class {
	#name : 'STBlocSoccerSceneSample',
	#superclass : 'STBlocSoccerScene',
	#category : 'SoccerTheory-Samples-Bloc',
	#package : 'SoccerTheory-Samples',
	#tag : 'Bloc'
}

{ #category : 'accessing' }
STBlocSoccerSceneSample class >> sampleDeviceExtent [

	^ 556 @ 360
]

{ #category : 'accessing' }
STBlocSoccerSceneSample >> borderWidth [

	^ 10
]

{ #category : 'initialization' }
STBlocSoccerSceneSample >> initializeTransformerWithWorldExtent: aPoint [

	transformer := (STCoordinatesTransformer
		                newWithWorldExtent: aPoint
		                deviceExtent: self class sampleDeviceExtent)
		               setDeviceToBloc;
		               yourself
]

{ #category : 'initialization' }
STBlocSoccerSceneSample >> initializeWithGameCommander: aSTGameCommander [

	super initializeWithGameCommander: aSTGameCommander.
	self renderShapes.
	self startAnnouncements
]

{ #category : 'accessing' }
STBlocSoccerSceneSample >> transformer [

	^ transformer
]
