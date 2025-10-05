"
I am the user interface for the Soccer Theory Board.

I rely on STSoccerSceneBuilder for rendering the soccer game view.

Start me doing either: 
- STFrameEditor openBloc (Bloc version)
- STFrameEditor openRoassal (Roassal version)
- STFrameEditor open (default ist Bloc version)
"
Class {
	#name : 'STFrameEditor',
	#superclass : 'STSoccerBoardPresenter',
	#instVars : [
		'scenePlug'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'TOREMOVE' }
STFrameEditor class >> aboutText [

	^ 'SoTheBoard, The Soccer Theory Board, is a software application to edit a single soccer scene (frame) on a two-dimensional play field. SoTheBoard belongs to the Soccer Theory software suite dedicated to visualize the Theory of Soccer.'
]

{ #category : 'instance creation' }
STFrameEditor class >> newWithBloc [

	^ (self basicNew scenePlug: STSoccerScenePlug newBloc)
		  initialize;
		  yourself
]

{ #category : 'instance creation' }
STFrameEditor class >> newWithRoassal [

	^ (self basicNew scenePlug: STSoccerScenePlug newRoassal)
		  initialize;
		  yourself
]

{ #category : 'instance creation' }
STFrameEditor class >> open [
	"Open the Soccer Theory Board."

	<script>
	self openBloc
]

{ #category : 'instance creation' }
STFrameEditor class >> openBloc [
	"Open the Soccer Theory Board with Bloc graphics."

	<script>
	self newWithBloc asWindow
		beNotResizable;
		open
]

{ #category : 'instance creation' }
STFrameEditor class >> openRoassal [
	"Open the Soccer Theory Board with Roassal graphics."

	<script>
	self newWithRoassal asWindow open
]

{ #category : 'showing' }
STFrameEditor >> asWindow [
	"Answer a new instance of mine as window."

	^ super asWindow
		  title: 'SoTheBoard – The Soccer Theory Board';
		  aboutText: self aboutText;
		  initialExtent: 1180 @ 884;
		  yourself
]

{ #category : 'presenters' }
STFrameEditor >> buttonForLoadingExamples [
	"Answer the SpButtonPresenter with menu items for loading soccer scene examples."

	| menu |
	menu := SpMenuPresenter new
		        addItem: [ :item |
				        item
					        name: 'Fixture 1';
					        action: [ self loadFixture1 ] ];
		        addItem: [ :item |
				        item
					        name: 'Fixture 2';
					        action: [ self loadFixture2 ] ];
		        addItem: [ :item |
				        item
					        name: 'Fixture 3';
					        action: [ self loadFixture3 ] ];
		        addItem: [ :item |
				        item
					        name: 'Fixture 4 (modern offside)';
					        action: [ self loadFixture4WithModernOffsideRule ] ];
		        yourself.

	^ self newButton
		  label: 'Examples';
		  iconName: #arrowDown;
		  action: [ menu openWithSpecAt: self currentHand position ];
		  yourself
]

{ #category : 'layout' }
STFrameEditor >> frameControlsLayout [
	"Answer the layout for frame controls."

	^ SpBoxLayout newLeftToRight
		  hAlignStart;
		  add: (SpToolbarPresenter new
				   beIcons;
				   add: self toolbarButtonToOpen;
				   add: self toolbarButtonToSave;
				   add: self toolbarButtonToReset;
				   yourself);
		  "add: self menuButtonForLoadingExamples width: 100;"add:
		  self buttonForLoadingExamples
		  expand: false;
		  yourself
]

{ #category : 'loading' }
STFrameEditor >> loadFixture1 [
	"Load the test frame named fixture 1."

	self loadFrame: STSoccerFrameBuilder fixture1Frame named: 'Fixture 1'
]

{ #category : 'loading' }
STFrameEditor >> loadFixture2 [
	"Load the test frame named fixture 2."

	self loadFrame: STSoccerFrameBuilder fixture2Frame named: 'Fixture 2'
]

{ #category : 'loading' }
STFrameEditor >> loadFixture3 [
	"Load the test frame named fixture 3."

	self loadFrame: STSoccerFrameBuilder fixture3Frame named: 'Fixture 3'
]

{ #category : 'loading' }
STFrameEditor >> loadFixture4WithModernOffsideRule [
	"Load the test frame named fixture 4 with modern offside."

	| builder |
	builder := STSoccerFrameBuilder fixture4FrameBuilder.
	builder setModernSoccerStrategy.
	self loadFrame: builder builtFrame named: 'Fixture 4'
]

{ #category : 'presenters' }
STFrameEditor >> menuButtonForLoadingExamples [
	"Answer the SpMenuButtonPresenter with menu items for loading soccer scene examples."

	| menuButton |
	menuButton := self newMenuButton.
	menuButton label: 'Examples'.
	menuButton menu: [
		SpMenuPresenter new
			addItem: [ :item |
				item
					name: 'Fixture 1';
					action: [ self loadFixture1 ] ];
			addItem: [ :item |
				item
					name: 'Fixture 2';
					action: [ self loadFixture2 ] ];
			addItem: [ :item |
				item
					name: 'Fixture 3';
					action: [ self loadFixture3 ] ];
			addItem: [ :item |
				item
					name: 'Fixture 4 (modern offside)';
					action: [ self loadFixture4WithModernOffsideRule ] ];
			addItem: [ :item |
				item
					name: 'Close this menu';
					action: [ "Remove this item as soon as Spec issue #1736 is resolved."
						 ] ];
			yourself ].
	^ menuButton
]

{ #category : 'loading' }
STFrameEditor >> scenePlug [
	"Answer the subclass of STSoccerSceneBuilder for rendering the soccer scene."

	^ scenePlug
]

{ #category : 'loading' }
STFrameEditor >> scenePlug: aSTSoccerSceneBuilder [
	"Set the subclass of STSoccerSceneBuilder for rendering the soccer scene."

	scenePlug := aSTSoccerSceneBuilder
]
