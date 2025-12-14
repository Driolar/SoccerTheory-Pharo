"
I render a soccer pitch just for demo/test purposes.

Currently using me: STDemoData and STDemoData2.
"
Class {
	#name : 'STBlocSoccerSceneSample',
	#superclass : 'STBlocSoccerScene',
	#category : 'SoccerTheory-Graphics-Examples-Bloc',
	#package : 'SoccerTheory-Graphics-Examples',
	#tag : 'Bloc'
}

{ #category : 'accessing' }
STBlocSoccerSceneSample >> borderWidth [

	^ 10
]

{ #category : 'initialization' }
STBlocSoccerSceneSample >> initializeTransformerWithWorldExtent: aPoint [

	transformer := (STCoordinatesTransformer
		                newWithWorldExtent: aPoint
		                deviceExtent: self sampleDeviceExtent)
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
STBlocSoccerSceneSample >> sampleDeviceExtent [

	^ 556 @ 360
]

{ #category : 'accessing' }
STBlocSoccerSceneSample >> transformer [

	^ transformer
]
