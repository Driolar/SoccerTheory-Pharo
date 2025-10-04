"
I am the plug to connect a STSoccerSceneBuilder with the corresponding presenter.
I care on rendering the scene in the corresponding SpPresenter.  
"
Class {
	#name : 'STSoccerScenePlug',
	#superclass : 'Object',
	#instVars : [
		'viewPresenterClass',
		'sceneBuilderClass',
		'refreshBlock'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'instance creation' }
STSoccerScenePlug class >> newBloc [

	^ self new initializeBloc
]

{ #category : 'instance creation' }
STSoccerScenePlug class >> newRoassal [

	^ self new initializeRoassal
]

{ #category : 'initialization' }
STSoccerScenePlug >> initializeBloc [

	sceneBuilderClass := STBlocSoccerSceneBuilder.
	viewPresenterClass := SpBlSpaceInMorphPresenter.
	refreshBlock := [ :spaceInMorphPresenter :blocSoccerSceneBuilder |
		                spaceInMorphPresenter space root removeChildren.
		                spaceInMorphPresenter space setExtent:
			                blocSoccerSceneBuilder totalExtent.
		                spaceInMorphPresenter space root addChild:
			                blocSoccerSceneBuilder surface ]
]

{ #category : 'initialization' }
STSoccerScenePlug >> initializeRoassal [

	sceneBuilderClass := STRoassalSoccerSceneBuilder.
	viewPresenterClass := SpRoassalPresenter.
	refreshBlock := [ :roassalPresenter :roassalSoccerSceneBuilder |
		                roassalPresenter script: [ :canvas |
			                roassalSoccerSceneBuilder refreshCanvas: canvas ] ]
]

{ #category : 'instance creation' }
STSoccerScenePlug >> newSceneWithGameCommander: aSTGameCommander [
	"Answer a new STSoccerSceneBuilder subclass instance."

	^ sceneBuilderClass newWithGameCommander: aSTGameCommander
]

{ #category : 'api' }
STSoccerScenePlug >> refreshViewOnPresenter: aSpPresenter sceneBuilder: sceneBuilder [

	refreshBlock value: aSpPresenter value: sceneBuilder
]

{ #category : 'accessing' }
STSoccerScenePlug >> viewPresenterClass [

	^ viewPresenterClass
]
