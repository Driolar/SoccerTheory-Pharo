"
I am the user interface for the Soccer Theory Player.

I rely on STSoccerDocumentReader for reading soccer game sequences from SoccerML files.
I rely on STSoccerSceneBlElement for displaying each frame.


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
		'savingButton',
		'refreshButton',
		'lastStartingFrameIndex',
		'officialTimeLabel',
		'saveFilePresenter',
		'framesPerSecond',
		'fileReference'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'TOREMOVE' }
STSequencePlayer class >> aboutText [

	^ 'SoTheReplay, The Soccer Theory Player, is a software application to replay sequences of soccer scene frames on a two-dimensional play field. SoTheReplay belongs to the Soccer Theory software suite dedicated to visualize the Theory of Soccer.'
]

{ #category : 'instance creation' }
STSequencePlayer class >> open [
	"Open the Soccer Theory Player."

	<script>
	self new asWindow
		title: 'SoTheReplay – The Soccer Theory Player';
		aboutText: self aboutText;
		initialExtent: 1180 @ 884;
		beNotResizable; 
		open
]

{ #category : 'private' }
STSequencePlayer >> alertFileNotFound [

	SpAlertDialog new
		title: 'Statistic charts';
		label: 'File: ' , fileReference fullname , ' not found.';
		acceptLabel: 'Close';
		openModal
]

{ #category : 'private' }
STSequencePlayer >> alertNoFileReference [

	SpAlertDialog new
		title: 'Statistic charts';
		label: 'Please load first a SoccerML file.';
		acceptLabel: 'Close';
		openModal
]

{ #category : 'private' }
STSequencePlayer >> alertNoPossessionData [

	SpAlertDialog new
		title: 'Statistic charts';
		label: 'There is no possession data available.';
		acceptLabel: 'Close';
		openModal
]

{ #category : 'private' }
STSequencePlayer >> checkFileReference [
	"Answer true if file reference fits, else false.
	Show appropriate message if file reference is missing or file is not existing."

	fileReference ifNil: [
			self alertNoFileReference.
			^ false ].
	fileReference exists ifFalse: [
			self alertFileNotFound.
			^ false ].
	^ true
]

{ #category : 'presenters' }
STSequencePlayer >> controlsPresenter [
	"Answer the SpPresenter with the controls row."

	| presenter |
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newLeftToRight
			 add: self fileControlsLayout;
			 add: self statisticsButton expand: false;
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
		  add: (SpToolbarPresenter new
				   beIcons;
				   add: openingButton;
				   add: savingButton;
				   yourself);
		  yourself
]

{ #category : 'private' }
STSequencePlayer >> formattedStringForWorldPosition: aPoint [
	"Answer the formatted string for the given world position."

	^ '(' , (aPoint x printShowingDecimalPlaces: 1) , '@'
	  , (aPoint y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'loading' }
STSequencePlayer >> frameDuration [
	"Answer the frame Duration according to the frame rate."

	^ Duration milliSeconds: (framesPerSecond
			   ifNotNil: [ 1000 / framesPerSecond asNumber ]
			   ifNil: [ 100 "RoboCup standard" ])
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

{ #category : 'initialization' }
STSequencePlayer >> initializeButtons [

	playButton := self playButton.
	stopButton := self stopButton.
	restartButton := self restartButton.
	openingButton := self toolbarButtonToOpen.
	savingButton := self toolbarButtonToSave. 
	refreshButton := self refreshButton
]

{ #category : 'initialization' }
STSequencePlayer >> initializePresenters [
	"Initialize the main presenters."

	super initializePresenters.
	self initializeButtons.
	board := self newBoard.
	statusbar := self newStatusBar.
	openFilePresenter := self openingFilePresenter.
	saveFilePresenter := self savingFilePresenter.
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

	^ STBlocLegendPresenter newWithGraphicFactory: STGraphicFactory new
]

{ #category : 'loading' }
STSequencePlayer >> loadFile: aFileReference [
	"Extract the first STSoccerFrame from the given SoccerML file, display it and push a message on the status bar."

	fileReference := aFileReference.
	reader := STSoccerDocumentReader onFileNamed: aFileReference fullName.
	reader optimizeForLargeDocuments.
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
	scene := self scenePlug newSceneWithGameCommander:
		         (STGameCommander newWithFrame: aFrame).

	offsideRuleLabel label: aFrame strategy offsideRuleName.
	aFrame officialTime ifNotNil: [ :officialTime |
		officialTimeLabel label: officialTime ].
	framesPerSecond := aFrame framesPerSecond.

	self scenePlug refreshViewOnPresenter: board scene: scene
]

{ #category : 'initialization' }
STSequencePlayer >> newBoard [
	"Answer my presenter to render the board on."

	^ self instantiate: self scenePlug viewPresenterClass
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

{ #category : 'private' }
STSequencePlayer >> openContinuousPossessionTimelineChart [

	self openMatchChart: STContinuousPossessionTimelineChart
]

{ #category : 'private' }
STSequencePlayer >> openMatchChart: aSTMatchChartSubclass [

	| extractor |
	self checkFileReference ifFalse: [ ^ self ].

	extractor := STMatchEventExtractor onFileNamed: fileReference.
	extractor extract.

	(extractor team1Extract possessionEndpoints notEmpty or: [
		 extractor team2Extract possessionEndpoints notEmpty ])
		ifTrue: [
				(aSTMatchChartSubclass
					 team1Extract: extractor team1Extract
					 team2Extract: extractor team2Extract) open ]
		ifFalse: [ self alertNoPossessionData ]
]

{ #category : 'private' }
STSequencePlayer >> openMeanPossessionTimelineChart [

	self openMatchChart: STMeanPossessionTimelineChart
]

{ #category : 'private' }
STSequencePlayer >> openPossessionBarChart [

	self openMatchChart: STPossessionBarChart
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
		                  delay: self frameDuration.
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

{ #category : 'private' }
STSequencePlayer >> saveFile: aFileReference [
	"Write the STSoccerFrame to SoccerML and save the document under the given file reference. Push a message on the status bar."

	| writer |
	writer := STSoccerFrameDocumentWriter on: reader currentSoccerFrame.
	aFileReference writeStreamDo: [ :stream |
		stream nextPutAll: writer writeWholeDocument ].
	statusbar pushMessage: aFileReference basename , ' saved.'
]

{ #category : 'presenters' }
STSequencePlayer >> savingFilePresenter [

	^ (StSaveFilePresenter on: StFileSystemModel new)
		  openFolder: FileLocator documents;
		  extensions: #( 'socxml' );
		  okAction: [ :selectedFileReference |
			  self saveFile: selectedFileReference ];
		  yourself
]

{ #category : 'private' }
STSequencePlayer >> scenePlug [

	^ STSoccerScenePlug newBloc
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
STSequencePlayer >> statisticsButton [

	^ self newButton
		  label: 'Statistics';
		  iconName: #arrowDown;
		  action: [
			  self statisticsMenuPresenter openWithSpecAt:
					  self currentHand position ];
		  yourself
]

{ #category : 'presenters' }
STSequencePlayer >> statisticsMenuPresenter [

	^ SpMenuPresenter new
		  addItem: [ :item |
				  item
					  name: 'Possession bar chart';
					  action: [ self openPossessionBarChart ] ];
		  addItem: [ :item |
				  item
					  name: 'Mean Possession timeline';
					  action: [ self openMeanPossessionTimelineChart ] ];
		  addItem: [ :item |
				  item
					  name: 'Continuous Possession timeline';
					  action: [ self openContinuousPossessionTimelineChart ] ];
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

{ #category : 'presenters' }
STSequencePlayer >> toolbarButtonToOpen [
	"Answer the toolbar button for opening a SoccerML file."

	^ self newToolbarButton
		  icon: (self iconNamed: #open);
		  label: 'Open...';
		  help: 'Open a SoccerML file.';
		  action: [ openFilePresenter openModal ];
		  yourself
]

{ #category : 'presenters' }
STSequencePlayer >> toolbarButtonToSave [
	"Answer the toolbar button to export a SoccerML file."

	^ self newToolbarButton
		  icon: (self iconNamed: #save);
		  label: 'Save...';
		  help: 'Save current frame as a SoccerML file.';
		  action: [ "Guard until Spec issue #1560 is solved."
				  (reader isNil or: [ self isPlaying ]) ifFalse: [
						  saveFilePresenter openModal ] ];
		  disable;
		  yourself
]

{ #category : 'private' }
STSequencePlayer >> updateButtons [
	"Enable/Disable relevant playing buttons."

	openingButton enabled: self isPlaying not.
	savingButton enabled: (reader notNil and: [ self isPlaying not ]).
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
