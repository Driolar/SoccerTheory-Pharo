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
		'statusbar',
		'openFilePresenter',
		'offsideRuleLabel',
		'reader',
		'frameIndexPresenter',
		'playTaskAction',
		'playButton',
		'stopButton',
		'restartButton',
		'openingButton',
		'refreshButton',
		'lastStartingFrameIndex',
		'officialTimeLabel'
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
		  add: self controlsPresenter expand: false;
		  add: board;
		  add: self legendPresenter expand: false;
		  add: statusbar expand: false;
		  yourself
]

{ #category : 'layout' }
STSequencePlayer >> fileControlsLayout [
	"Answer the layout for file controls."

	^ SpBoxLayout newLeftToRight
		  add: openingButton expand: false;
		  yourself
]

{ #category : 'private' }
STSequencePlayer >> formattedStringForWorldPosition: aPoint [
	"Answer the formatted string for the given world position."

	^ '(' , (aPoint x printShowingDecimalPlaces: 1) , '@'
	  , (aPoint y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'layout' }
STSequencePlayer >> frameIndexLayout [
	"Answer the layout for frame index controls."

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
				   add: refreshButton;
				   yourself);
		  yourself
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

{ #category : 'layout' }
STSequencePlayer >> framePlayerLayout [
	"Answer the layout for frame player controls."

	^ SpBoxLayout newLeftToRight
		  add: (SpToolbarPresenter new
				   beIcons;
				   add: playButton;
				   add: stopButton;
				   add: restartButton;
				   yourself);
		  yourself
]

{ #category : 'loading' }
STSequencePlayer >> gotoRestart [

	(lastStartingFrameIndex isNil or: [ self isPlaying ]) ifTrue: [
		^ self ].

	frameIndexPresenter number: lastStartingFrameIndex.
	self refreshFrame
]

{ #category : 'private' }
STSequencePlayer >> graphicFactory [

	^ STGraphicFactory new
]

{ #category : 'initialization' }
STSequencePlayer >> initializeButtons [

	playButton := self playButton.
	stopButton := self stopButton.
	restartButton := self restartButton.
	openingButton := self openingButton.
	refreshButton := self refreshButton
]

{ #category : 'initialization' }
STSequencePlayer >> initializePresenters [
	"Initialize the main presenters."

	super initializePresenters.
	self initializeButtons. 
	board := SpBlSpaceInMorphPresenter new.
	statusbar := self newStatusBar.
	openFilePresenter := self openingFilePresenter.
	offsideRuleLabel := self newLabel.
	officialTimeLabel := self newLabel.
	self resetBoard
]

{ #category : 'private' }
STSequencePlayer >> isPlaying [

	^ playTaskAction notNil
]

{ #category : 'presenters' }
STSequencePlayer >> legendPresenter [
	"Answer the SpPresenter containing the legend."

	^ STLegendPresenter newWithGraphicFactory: self graphicFactory
]

{ #category : 'loading' }
STSequencePlayer >> loadFile: aFileReference [
	"Extract the first STSoccerFrame from the given SoccerML file, display it and push a message on the status bar."

	reader := STSoccerDocumentReader onFileNamed: aFileReference fullName.
	reader parse.

	self updateFrameIndexPresenter.
	self updateButtons.
	lastStartingFrameIndex := nil.

	self loadFrame: reader currentSoccerFrame.
	statusbar pushMessage:
		aFileReference basename , ' (' , reader numberOfFrames asString
		, ' frames) loaded.'
]

{ #category : 'loading' }
STSequencePlayer >> loadFrame: aFrame [
	"Load the given STSoccerFrame on the scene."

	| scene |
	scene := STSoccerScene
		         newApplicationSceneWithGameCommander:
		         (STGameCommander newWithFrame: aFrame)
		         graphicFactory: self graphicFactory.

	offsideRuleLabel label: aFrame strategy offsideRuleName.
	aFrame officialTime ifNotNil: [ :officialTime |
		officialTimeLabel label: officialTime ].

	board space root removeChildren.
	board space setExtent: scene totalExtent.
	board space root addChild: scene
]

{ #category : 'layout' }
STSequencePlayer >> officialTimeLayout [
	"Answer the layout for strategy controls."

	^ SpBoxLayout newLeftToRight
		  vAlignCenter;
		  add: 'official time: ' expand: false;
		  add: officialTimeLabel width: 100;
		  yourself
]

{ #category : 'presenters' }
STSequencePlayer >> openingButton [
	"Answer the button for opening a SoccerML file."

	^ SpButtonPresenter new
		  label: 'Open...';
		  help: 'Open a SoccerML file.';
		  action: [ openFilePresenter openModal ];
		  yourself
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
STSequencePlayer >> playButton [

	^ SpToolbarButtonPresenter new
		  icon: (self iconNamed: #go);
		  label: 'Play';
		  help: 'Play the frames starting with the specified frame number.';
		  action: [ self playSequence ];
		  disable;
		  yourself
]

{ #category : 'loading' }
STSequencePlayer >> playSequence [

	(reader isNil or: [ self isPlaying ]) ifTrue: [ ^ self ].
	frameIndexPresenter number = reader numberOfFrames ifTrue: [ ^ self ].

	lastStartingFrameIndex := frameIndexPresenter number.

	playTaskAction := BlRepeatedTaskAction new
		                  action: [
				                  self refreshFrame.
				                  reader numberOfFrames
				                  > frameIndexPresenter number
					                  ifTrue: [
						                  frameIndexPresenter number:
								                  frameIndexPresenter number + 1 ]
					                  ifFalse: [ self stopSequence ] ];
		                  delay: (Duration milliSeconds: 100). "RoboCup standard"
	board space enqueueTask: playTaskAction
]

{ #category : 'presenters' }
STSequencePlayer >> refreshButton [

	^ SpToolbarButtonPresenter new
		  icon: (self iconNamed: #refreshCircling);
		  label: 'Refresh';
		  help: '(Re)load the frame with the specified sequence number.';
		  action: [ self refreshFrame ];
		  disable;
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
	self loadFrame: reader currentSoccerFrame.
	self updateButtons
]

{ #category : 'private' }
STSequencePlayer >> resetBoard [
	"Reset the board to an empty frame."

	self loadFrame:
		(STSoccerFrameBuilder emptyFrameWithPitch: STPitch newDefault)
]

{ #category : 'presenters' }
STSequencePlayer >> restartButton [

	^ SpToolbarButtonPresenter new
		  icon: (self iconNamed: #back);
		  label: 'Restart';
		  help: 'Go to the last starting frame.';
		  action: [ self gotoRestart ];
		  disable;
		  yourself
]

{ #category : 'layout' }
STSequencePlayer >> sequenceControlsLayout [
	"Answer the layout for sequence controls."

	^ SpBoxLayout newLeftToRight
		  hAlignCenter;
		  spacing: 20;
		  add: self frameIndexLayout expand: false;
		  add: self framePlayerLayout expand: false;
		  add: self officialTimeLayout expand: false;
		  yourself
]

{ #category : 'presenters' }
STSequencePlayer >> stopButton [

	^ SpToolbarButtonPresenter new
		  icon: (self iconNamed: #stop);
		  label: 'Stop';
		  help: 'Stop the sequence playing.';
		  action: [ self stopSequence ];
		  disable;
		  yourself
]

{ #category : 'loading' }
STSequencePlayer >> stopSequence [

	self isPlaying ifFalse: [ ^ self ].
	playTaskAction stop.
	playTaskAction := nil.
	self refreshFrame
]

{ #category : 'layout' }
STSequencePlayer >> strategyControlsLayout [
	"Answer the layout for strategy controls."

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  vAlignCenter;
		  add: offsideRuleLabel expand: false;
		  yourself
]

{ #category : 'private' }
STSequencePlayer >> updateButtons [
	"Enable/Disable relevant playing buttons."

	openingButton enabled: self isPlaying not.
	refreshButton enabled: self isPlaying not.
	playButton enabled: (self isPlaying not and: [
			 frameIndexPresenter number < reader numberOfFrames ]).
	restartButton enabled:
		(lastStartingFrameIndex notNil and: [ self isPlaying not ]).
	stopButton enabled: self isPlaying
]

{ #category : 'private' }
STSequencePlayer >> updateFrameIndexPresenter [

	frameIndexPresenter
		enable;
		number: 1;
		minimum: 1;
		maximum: reader numberOfFrames
]
