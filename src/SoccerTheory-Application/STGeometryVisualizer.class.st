"
I am the user interface for the Soccer Theory's GeometryVisualizer.

I rely on STSoccerSceneRSShape for rendering the soccer game view.

Start me doing this: STGeometryVisualizer open.
"
Class {
	#name : 'STGeometryVisualizer',
	#superclass : 'STSoccerBoardPresenter',
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

{ #category : 'layout' }
STGeometryVisualizer >> frameControlsLayout [
	"Answer the layout for frame controls."

	^ SpBoxLayout newLeftToRight
		  hAlignStart;
		  add: (SpToolbarPresenter new
				   beIcons;
				   add: self toolbarButtonToOpen;
				   add: self toolbarButtonToSave;
				   add: self toolbarButtonToReset;
				   yourself);
		  yourself
]

{ #category : 'initialization' }
STGeometryVisualizer >> newBoard [
	"Answer my presenter to render the board on."

	^ self instantiate: self scenePlug viewPresenterClass
]

{ #category : 'loading' }
STGeometryVisualizer >> refreshBoard [
	"Refresh scene depending on scene and board classes."

	scene := self scenePlug newSceneWithGameCommander: gameCommander.
	self scenePlug refreshViewOnPresenter: board sceneBuilder: scene
]

{ #category : 'loading' }
STGeometryVisualizer >> scenePlug [
	"Answer the plug for connecting with the soccer scene."

	^ STSoccerScenePlug newRoassal 
]
