"
I am the user interface for the Soccer Theory's GeometryVisualizer.

I rely on STSoccerSceneRSShape for rendering the soccer game view.

Start me doing this: STGeometryVisualizer open.
"
Class {
	#name : 'STGeometryVisualizer',
	#superclass : 'STSoccerBoardPresenter',
	#instVars : [
		'individualCoverageLayer',
		'teamSpanLayer',
		'shootingAngleLayer',
		'shortPathToGoalLayer'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'TOREMOVE' }
STGeometryVisualizer class >> aboutText [

	^ 'SoTheGeometry, The Soccer Theory''s Geometry Visualizer, is a software application to visualize soccer geometry on a two-dimensional soccer field. SoTheGeometry belongs to the Soccer Theory software suite dedicated to visualize the Theory of Soccer.'
]

{ #category : 'instance creation' }
STGeometryVisualizer class >> open [
	"Open the Soccer Theory Graph Visualizer."

	<script>
	self new asWindow
		title: 'SoTheGeometry – The Soccer Theory''s Geometry Visualizer';
		aboutText: self aboutText;
		initialExtent: 1180 @ 884;
		open
]

{ #category : 'initialization' }
STGeometryVisualizer >> connectPresenters [

	super connectPresenters.
	strategyController connectPresenters
]

{ #category : 'initialization' }
STGeometryVisualizer >> initializeStrategyButtons [

	super initializeStrategyButtons.
	strategyController initializeToggleButtonsForGeometry
]

{ #category : 'rendering' }
STGeometryVisualizer >> removeAssociatedLayers [

	individualCoverageLayer ifNotNil: [
		self removeIndividualCoverageLayer ].
	shootingAngleLayer ifNotNil: [ self removeShootingAngleLayer ].
	shortPathToGoalLayer ifNotNil: [ self removeShortPathToGoalLayer ]
]

{ #category : 'rendering' }
STGeometryVisualizer >> removeIndividualCoverageLayer [

	individualCoverageLayer ifNotNil: [ :layer |
			layer disappear.
			individualCoverageLayer := nil ]
]

{ #category : 'rendering' }
STGeometryVisualizer >> removeShootingAngleLayer [

	shootingAngleLayer ifNotNil: [ :layer |
			layer disappear.
			shootingAngleLayer := nil ]
]

{ #category : 'rendering' }
STGeometryVisualizer >> removeShortPathToGoalLayer [

	shortPathToGoalLayer ifNotNil: [ :layer |
			layer disappear.
			shortPathToGoalLayer := nil ]
]

{ #category : 'rendering' }
STGeometryVisualizer >> removeTeamSpanLayer [

	teamSpanLayer disappear.
	teamSpanLayer := nil
]

{ #category : 'rendering' }
STGeometryVisualizer >> renderIndividualCoverageLayer [

	self removeAssociatedLayers.
	individualCoverageLayer := STIndividualCoverageLayer newOn: scene.
	individualCoverageLayer render
]

{ #category : 'rendering' }
STGeometryVisualizer >> renderShootingAngleLayer [

	self removeAssociatedLayers.
	shootingAngleLayer := STShootingAngleLayer newOn: scene.
	shootingAngleLayer render
]

{ #category : 'rendering' }
STGeometryVisualizer >> renderShortPathToGoalLayer [

	self removeAssociatedLayers.
	shortPathToGoalLayer := STShortPathToGoalLayer newOn: scene.
	shortPathToGoalLayer render
]

{ #category : 'rendering' }
STGeometryVisualizer >> renderTeamSpanLayer [

	teamSpanLayer ifNotNil: [
		self removeTeamSpanLayer ].
	teamSpanLayer := STTeamSpanLayer newOn: scene.
	teamSpanLayer render
]

{ #category : 'initialization' }
STGeometryVisualizer >> resetGeometryButtons [

	strategyController resetGeometryButtons
]

{ #category : 'loading' }
STGeometryVisualizer >> scenePlug [
	"Answer the plug for connecting with the soccer scene."

	^ STSoccerScenePlug newRoassal 
]

{ #category : 'layout' }
STGeometryVisualizer >> strategyControlsLayout [

	^ strategyController geometryAndOffsideControlsLayout
]

{ #category : 'update' }
STGeometryVisualizer >> updateControls [

	super updateControls.
	self resetGeometryButtons
]
