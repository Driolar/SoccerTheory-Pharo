"
I am the user interface for the Soccer Theory Board.

I rely on STSoccerScene for rendering the soccer game view.
I rely on STGameCommander for soccer model control.

Start me doing this: STFrameEditor open.
"
Class {
	#name : 'STSequencePlayer',
	#superclass : 'SpPresenter',
	#instVars : [
		'board',
		'controls',
		'statusbar',
		'graphicFactory',
		'openFilePresenter',
		'offsideRuleLabel',
		'reader'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'TOREMOVE' }
STSequencePlayer class >> aboutText [

	^ 'SoThePlayer, The Soccer Theory Player, is a software application to visualize the Theory of Soccer.'
]

{ #category : 'instance creation' }
STSequencePlayer class >> open [
	"Open the Soccer Theory Player."

	<script>
	self new asWindow
		title: 'SoThePlayer – The Soccer Theory Player';
		aboutText: self aboutText;
		initialExtent: 1180 @ 884;
		beNotResizable; 
		open
]

{ #category : 'presenters' }
STSequencePlayer >> controlsPresenter [
	"Answer the SpPresenter with the controls row."

	| presenter |
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newLeftToRight
			 beHomogeneous;
			 add: self frameControlsLayout;
			 add: self strategyControlsLayout;
			 yourself).
	^ presenter
]

{ #category : 'layout' }
STSequencePlayer >> defaultLayout [
	"Answer the composed layout."

	^ SpBoxLayout newTopToBottom
		  add: controls expand: false;
		  add: board;
		  add: self legendPresenter expand: false;
		  add: statusbar expand: false;
		  yourself
]

{ #category : 'private' }
STSequencePlayer >> formattedStringForWorldPosition: aPoint [
	"Answer the formatted string for the given world position."

	^ '(' , (aPoint x printShowingDecimalPlaces: 1) , '@'
	  , (aPoint y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'layout' }
STSequencePlayer >> frameControlsLayout [
	"Answer the layout for frame controls."

	^ SpBoxLayout newLeftToRight
		  add: self openingButton expand: false;
		  yourself
]

{ #category : 'initialization' }
STSequencePlayer >> initializePresenters [
	"Initialize the main presenters."

	super initializePresenters.
	graphicFactory := STGraphicFactory new.
	controls := self controlsPresenter.
	board := SpBlSpaceInMorphPresenter new.
	statusbar := self newStatusBar.
	openFilePresenter := self openingFilePresenter.
	self resetBoard
]

{ #category : 'presenters' }
STSequencePlayer >> legendPresenter [
	"Answer the SpPresenter containing the legend."

	^ STLegendPresenter newWithGraphicFactory: graphicFactory
]

{ #category : 'loading' }
STSequencePlayer >> loadFile: aFileReference [
	"Extract the first STSoccerFrame from the given SoccerML file, display it and push a message on the status bar."

	reader := STSoccerDocumentReader onFileNamed: aFileReference fullName.
	reader parse.
	self
		loadFrame: reader currentSoccerFrame
		named: aFileReference basename
]

{ #category : 'loading' }
STSequencePlayer >> loadFrame: aFrame [
	"Load the given STSoccerFrame on the scene."

	| scene |
	scene := STSoccerScene
		         newApplicationSceneWithGameCommander:
		         (STGameCommander newWithFrame: aFrame)
		         graphicFactory: graphicFactory.

	offsideRuleLabel label: aFrame strategy offsideRuleName.

	board space setExtent: scene totalExtent.
	board space root addChild: scene
]

{ #category : 'loading' }
STSequencePlayer >> loadFrame: aFrame named: aFrameName [
	"Load the given STSoccerFrame on the scene and push a message on the status bar."

	self loadFrame: aFrame.
	statusbar pushMessage: aFrameName , ' loaded.'
]

{ #category : 'presenters' }
STSequencePlayer >> openingButton [
	"Answer the button for opening a SoccerML file."

	^ SpButtonPresenter new
		  label: 'Open...';
		  action: [ openFilePresenter openModal ]
]

{ #category : 'presenters' }
STSequencePlayer >> openingFilePresenter [

	^ (StOpenFilePresenter on: StFileSystemModel new)
		  openFolder: FileLocator documents;
		  extensions: #( 'socxml' );
		  okAction: [ :selectedFileReference |
			  self loadFile: selectedFileReference ];
		  yourself
]

{ #category : 'update' }
STSequencePlayer >> resetBoard [
	"Reset the board to the start frame."

	self
		loadFrame:
		(STSoccerFrameBuilder startFrameWithPitch: STPitch newDefault)
		named: 'Initial scene'
]

{ #category : 'presenters' }
STSequencePlayer >> resettingButton [
	"Answer the button for resetting the board."

	^ SpButtonPresenter new
		  label: 'Reset';
		  action: [ self resetBoard ];
		  yourself
]

{ #category : 'layout' }
STSequencePlayer >> strategyControlsLayout [
	"Answer the layout for strategy controls."

	offsideRuleLabel := self newLabel.

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  add: offsideRuleLabel expand: false;
		  yourself
]
