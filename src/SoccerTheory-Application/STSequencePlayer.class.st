"
I am the user interface for the Soccer Theory Player.

I rely on STSoccerDocumentReader for reading soccer game sequences from SoccerML files.
I rely on STSoccerScene for displaying each frame.


Start me doing this: STSequencePlayer open.
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
		'reader',
		'frameIndexPresenter'
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
			 add: self fileControlsLayout;
			 add: self sequenceControlsLayout;
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

{ #category : 'layout' }
STSequencePlayer >> fileControlsLayout [
	"Answer the layout for file controls."

	^ SpBoxLayout newLeftToRight
		  add: self openingButton expand: false;
		  yourself
]

{ #category : 'private' }
STSequencePlayer >> formattedStringForWorldPosition: aPoint [
	"Answer the formatted string for the given world position."

	^ '(' , (aPoint x printShowingDecimalPlaces: 1) , '@'
	  , (aPoint y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'presenters' }
STSequencePlayer >> frameIndexPresenter [

	^ SpNumberInputFieldPresenter new
		  number: 0;
		  minimum: 0;
		  maximum: 0;
		  climbRate: 1;
		  disable;
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

	self updateFrameIndexPresenter.

	self loadFrame: reader currentSoccerFrame.
	statusbar pushMessage:
		aFileReference basename , ' (' , reader frameNodes size asString
		, ' frames) loaded.'
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

{ #category : 'presenters' }
STSequencePlayer >> refreshButton [

	^ SpToolbarButtonPresenter new
		  icon: (self iconNamed: #refreshCircling);
		  label: 'Refresh';
		  help: '(Re)load the frame with the specified sequence number.';
		  action: [ self refreshFrame ];
		  yourself
]

{ #category : 'loading' }
STSequencePlayer >> refreshFrame [
	"Validate the displayed frame index and load the corresponding frame."

	"Remedy wrong values entered by keyboard."

	frameIndexPresenter number ifNil: [ frameIndexPresenter number: 0 ].
	frameIndexPresenter number:
		(frameIndexPresenter minimum max: frameIndexPresenter number).
	frameIndexPresenter number:
		(frameIndexPresenter maximum min: frameIndexPresenter number).


	reader ifNil: [ ^ self ].
	reader currentFrameIndex: frameIndexPresenter number.
	self loadFrame: reader currentSoccerFrame
]

{ #category : 'update' }
STSequencePlayer >> resetBoard [
	"Reset the board to an empty frame."

	self loadFrame:
		(STSoccerFrameBuilder emptyFrameWithPitch: STPitch newDefault)
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
STSequencePlayer >> sequenceControlsLayout [
	"Answer the layout for sequence controls."

	^ SpBoxLayout newLeftToRight
		  hAlignCenter;
		  vAlignCenter;
		  add: (SpLabelPresenter new
				   label: 'frame #';
				   yourself)
		  expand: false;
		  add: (frameIndexPresenter := self frameIndexPresenter) width: 100;
		  add: (SpToolbarPresenter new
				   beIcons;
				   add: self refreshButton;
				   yourself);
		  yourself
]

{ #category : 'layout' }
STSequencePlayer >> strategyControlsLayout [
	"Answer the layout for strategy controls."

	offsideRuleLabel := self newLabel.

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  vAlignCenter;
		  add: offsideRuleLabel expand: false;
		  yourself
]

{ #category : 'update' }
STSequencePlayer >> updateFrameIndexPresenter [

	frameIndexPresenter
		enable;
		number: 1;
		minimum: 1;
		maximum: reader frameNodes size
]
