"
I am the plug to connect a STSoccerScene (subclass) with the corresponding Spresenter (subclass).
I care on rendering the scene in the corresponding presenter.
"
Class {
	#name : 'STSoccerScenePlug',
	#superclass : 'Object',
	#instVars : [
		'viewPresenterClass',
		'sceneClass',
		'renderBlock',
		'legendPresenterClass'
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

	sceneClass := STBlocSoccerScene.
	viewPresenterClass := SpBlSpaceInMorphPresenter.
	legendPresenterClass := STBlocLegendPresenter.
	renderBlock := [ :spaceInMorphPresenter :blocSoccerScene |
	               blocSoccerScene renderViewIn:
		               spaceInMorphPresenter space ]
]

{ #category : 'initialization' }
STSoccerScenePlug >> initializeRoassal [

	sceneClass := STRoassalSoccerScene.
	viewPresenterClass := SpRoassalPresenter.
	legendPresenterClass := STRoassalLegendPresenter.
	renderBlock := [ :roassalPresenter :roassalSoccerScene |
		               roassalPresenter script: [ :canvas |
			               roassalSoccerScene renderViewIn: canvas ].
		               roassalSoccerScene startAnnouncements ]
]

{ #category : 'accessing' }
STSoccerScenePlug >> legendPresenterClass [

	^ legendPresenterClass
]

{ #category : 'instance creation' }
STSoccerScenePlug >> newSceneWithGameCommander: aSTGameCommander [
	"Answer a new STSoccerSceneBuilder subclass instance."

	^ sceneClass newWithGameCommander: aSTGameCommander
]

{ #category : 'api' }
STSoccerScenePlug >> refreshViewOnPresenter: aSpPresenter scene: scene [

	renderBlock value: aSpPresenter value: scene
]

{ #category : 'accessing' }
STSoccerScenePlug >> viewPresenterClass [

	^ viewPresenterClass
]
