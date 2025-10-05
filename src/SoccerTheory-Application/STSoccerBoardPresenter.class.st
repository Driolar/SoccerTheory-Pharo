"
I am an abstract framework that can be subclassed for similar applications of the Soccer Theory Suite.

I provide a standard layout and standard controls, e.g. to load or save soccer files.

I rely on TSTSoccerSceneRendering for rendering the soccer game view.
I rely on STGameCommander for soccer model control.
"
Class {
	#name : 'STSoccerBoardPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'gameCommander',
		'scene',
		'board',
		'statusbar',
		'dropListForOffsideRule',
		'graphicFactory',
		'rightTeamPossessionButton',
		'leftTeamPossessionButton',
		'neutralPossessionButton',
		'leftTeamAddPlayerButton',
		'rightTeamAddPlayerButton',
		'openFilePresenter',
		'saveFilePresenter'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'TOREMOVE' }
STSoccerBoardPresenter class >> aboutText [

	self subclassResponsibility 
]

{ #category : 'instance creation' }
STSoccerBoardPresenter class >> open [
	"Open the Soccer Theory board application."

	self subclassResponsibility 
]

{ #category : 'private' }
STSoccerBoardPresenter >> addNewPlayerToTeam: aSTTeam [
	"Add a new player to aTeam and place its shape on the play field."

	| player |
	player := gameCommander addNewPlayerToTeam: aSTTeam.
	scene addNewShapeOnPlayer: player.
	statusbar pushMessage:
		'new player #' , player jerseyNumber displayString , ' ('
		, player teamName , ') added on '
		, (self formattedStringForWorldPosition: player position)
]

{ #category : 'accessing' }
STSoccerBoardPresenter >> announcer [
	"Answer the announcer I use to subscribe for announcements."

	^ scene announcer
]

{ #category : 'layout' }
STSoccerBoardPresenter >> ballPossessionControlsLayout [
	"Answer the layout for ball possession controls."

	^ SpBoxLayout newLeftToRight
		  add: leftTeamPossessionButton;
		  add: neutralPossessionButton;
		  add: rightTeamPossessionButton;
		  yourself
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> controlsPresenter [
	"Answer the SpPresenter with the controls row."

	| presenter |
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newLeftToRight
			 beHomogeneous;
			 add: self frameControlsLayout;
			 add: self shapeControlsLayout;
			 add: self strategyControlsLayout;
			 yourself).
	^ presenter
]

{ #category : 'layout' }
STSoccerBoardPresenter >> defaultLayout [
	"Answer the composed layout."

	^ SpBoxLayout newTopToBottom
		  add: self controlsPresenter expand: false;
		  add: board;
		  add: self legendPresenter expand: false;
		  add: statusbar expand: false;
		  yourself
]

{ #category : 'private' }
STSoccerBoardPresenter >> formattedStringForWorldPosition: aPoint [
	"Answer the formatted string for the given world position."

	^ '(' , (aPoint x printShowingDecimalPlaces: 1) , '@'
	  , (aPoint y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'layout' }
STSoccerBoardPresenter >> frameControlsLayout [
	"Answer the layout for frame controls."

	self subclassResponsibility
]

{ #category : 'accessing' }
STSoccerBoardPresenter >> gameCommander [
	"Answer my game commander."

	^ gameCommander
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> initializeBallPossessionButtons [

	leftTeamPossessionButton := self newRadioButton
		                            label: 'Ball team left';
		                            whenActivatedDo: [
			                            gameCommander changeBallOwnerToTeam:
					                            gameCommander teamLeft ];
		                            yourself.

	rightTeamPossessionButton := self newRadioButton
		                             label: 'Ball team right';
		                             whenActivatedDo: [
			                             gameCommander changeBallOwnerToTeam:
					                             gameCommander teamRight ];
		                             yourself.

	neutralPossessionButton := self newRadioButton
		                           label: 'Ball neutral';
		                           whenActivatedDo: [
			                           gameCommander changeBallOwnerToTeam: nil ];
		                           yourself.

	leftTeamPossessionButton associatedRadioButtons: {
			neutralPossessionButton.
			rightTeamPossessionButton }
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> initializeDropListForOffsideRule [

	dropListForOffsideRule := SpDropListPresenter new.
	dropListForOffsideRule items: (OrderedCollection new
			 add: (STNoOffsideStrategyCommand forContext: self);
			 add: (STAncientStrategyCommand forContext: self);
			 add: (STClassicStrategyCommand forContext: self);
			 add: (STModernStrategyCommand forContext: self);
			 yourself).
	dropListForOffsideRule display: [ :command | command name ].
	dropListForOffsideRule whenSelectedItemChangedDo: [ :command |
			command execute.
			statusbar pushMessage: 'Offside set to ' , command name , '.' ]
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> initializePresenters [
	"Initialize the main presenters."

	super initializePresenters.
	graphicFactory := STGraphicFactory new.
	board := self newBoard.
	statusbar := self newStatusBar.
	openFilePresenter := self openingFilePresenter.
	saveFilePresenter := self savingFilePresenter.
	leftTeamAddPlayerButton := self newButton.
	rightTeamAddPlayerButton := self newButton.
	self initializeBallPossessionButtons.
	self initializeDropListForOffsideRule.
	self resetBoard
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> legendPresenter [
	"Answer the SpPresenter containing the legend."

	^ STLegendPresenter newWithGraphicFactory: graphicFactory
]

{ #category : 'loading' }
STSoccerBoardPresenter >> loadFile: aFileReference [
	"Extract the first STSoccerFrame from the given SoccerML file, display it and push a message on the status bar."

	| reader |
	reader := STSoccerDocumentReader on: aFileReference contents.
	reader parseFirstFrame.
	self
		loadFrame: reader currentSoccerFrame
		named: aFileReference basename
]

{ #category : 'loading' }
STSoccerBoardPresenter >> loadFrame: aFrame [
	"Load the given STSoccerFrame on the scene."

	gameCommander := STGameCommander newWithFrame: aFrame.
	self updateControls.
	self refreshBoard.
	self registerAtAnnouncer
]

{ #category : 'loading' }
STSoccerBoardPresenter >> loadFrame: aFrame named: aFrameName [
	"Load the given STSoccerFrame on the scene and push a message on the status bar."

	self loadFrame: aFrame.
	statusbar pushMessage: aFrameName , ' loaded.'
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> newBoard [
	"Answer my presenter to render the board on."

	^ self instantiate: self scenePlug viewPresenterClass
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> openingFilePresenter [

	^ (StOpenFilePresenter on: StFileSystemModel new)
		  openFolder: FileLocator documents;
		  extensions: #( 'socxml' );
		  okAction: [ :selectedFileReference |
			  self loadFile: selectedFileReference ];
		  yourself
]

{ #category : 'loading' }
STSoccerBoardPresenter >> refreshBoard [
	"Refresh scene depending on scene and board classes."

	scene := self scenePlug newSceneWithGameCommander: gameCommander.
	self scenePlug refreshViewOnPresenter: board sceneBuilder: scene
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self announcer
		when: STPlayerShapeMovedAnnouncement
		do: [ :ann |
			| player targetWorldPoint |
			player := ann player.
			targetWorldPoint := scene toWorld: ann targetDevicePoint.
			statusbar pushMessage:
				'Player #' , player jerseyNumber displayString , ' ('
				, player teamName , ') moved to '
				, (self formattedStringForWorldPosition: targetWorldPoint) ]
		for: self.

	self announcer
		when: STBallShapeMovedAnnouncement
		do: [ :ann |
			| targetWorldPoint |
			targetWorldPoint := scene toWorld: ann targetDevicePoint.
			statusbar pushMessage: 'Ball moved to '
				, (self formattedStringForWorldPosition: targetWorldPoint) ]
		for: self.

	self announcer
		when: STMovableShapeSelectedAnnouncement
		do: [ :ann |
		statusbar pushMessage: ann movableShape name , ' selected.' ]
		for: self
]

{ #category : 'update' }
STSoccerBoardPresenter >> resetBoard [
	"Reset the board to the start frame."

	self
		loadFrame:
		(STSoccerFrameBuilder startFrameWithPitch: STPitch newDefault)
		named: 'Initial scene'
]

{ #category : 'private' }
STSoccerBoardPresenter >> saveFile: aFileReference [
	"Write the STSoccerFrame to SoccerML and save the document under the given file reference. Push a message on the status bar."

	| writer |
	writer := STSoccerFrameDocumentWriter on: gameCommander frame.
	aFileReference writeStreamDo: [ :stream |
		stream nextPutAll: writer writeWholeDocument ].
	statusbar pushMessage: aFileReference basename , ' saved.'
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> savingFilePresenter [

	^ (StSaveFilePresenter on: StFileSystemModel new)
		  openFolder: FileLocator documents;
		  extensions: #( 'socxml' );
		  okAction: [ :selectedFileReference |
			  self saveFile: selectedFileReference ];
		  yourself
]

{ #category : 'loading' }
STSoccerBoardPresenter >> scenePlug [
	"Answer the subclass of STSoccerSceneBuilder for rendering the soccer scene."

	self subclassResponsibility
]

{ #category : 'layout' }
STSoccerBoardPresenter >> shapeControlsLayout [
	"Answer the layout for shape (ball, players) controls."

	^ SpBoxLayout newLeftToRight
		  add: leftTeamAddPlayerButton;
		  add: self ballPossessionControlsLayout;
		  add: rightTeamAddPlayerButton;
		  yourself
]

{ #category : 'layout' }
STSoccerBoardPresenter >> strategyControlsLayout [
	"Answer the layout for strategy controls."

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  add: dropListForOffsideRule expand: false;
		  yourself
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> toolbarButtonToOpen [
	"Answer the toolbar button for opening a SoccerML file."

	^ self newToolbarButton
		  icon: (self iconNamed: #open);
		  label: 'Open...';
		  help: 'Open a SoccerML file.';
		  action: [ openFilePresenter openModal ]
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> toolbarButtonToReset [
	"Answer the toolbar button for resetting the board."

	^ self newToolbarButton
		  label: 'Reset';
		  icon: (self iconNamed: #delete);
		  help:
			  'Clear irrevocably the scene and initialize it with just two goalkeepers and the ball in the middle.';
		  action: [ self resetBoard ];
		  yourself
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> toolbarButtonToSave [
	"Answer the toolbar button for saving a SoccerML file."

	^ self newToolbarButton
		  icon: (self iconNamed: #save);
		  label: 'Save...';
		  help: 'Save the current frame to a SoccerML file.';
		  action: [ saveFilePresenter openModal ]
]

{ #category : 'update' }
STSoccerBoardPresenter >> updateButton: aSpButtonPresenter forAddingPlayerOfTeam: aSTTeam [
	"Update the given player addition button for the corresponding team."

	| playerSquare |
	playerSquare := BlElement new
		                background: aSTTeam jerseyGradient;
		                extent: 18 asPoint;
		                yourself.
	playerSquare addChild: graphicFactory plusSignElement.
	aSpButtonPresenter
		icon: playerSquare asForm;
		help: 'Add field player to ' , aSTTeam teamName;
		action: [ self addNewPlayerToTeam: aSTTeam ]
]

{ #category : 'update' }
STSoccerBoardPresenter >> updateButtonsForAddingPlayer [
	"Update both buttons for team player addition."

	self
		updateButton: leftTeamAddPlayerButton
		forAddingPlayerOfTeam: gameCommander teamLeft.
	self
		updateButton: rightTeamAddPlayerButton
		forAddingPlayerOfTeam: gameCommander teamRight
]

{ #category : 'update' }
STSoccerBoardPresenter >> updateControls [

	self updateButtonsForAddingPlayer.
	self updateDropListForOffsideRule.
	self updateRadioButtonsForBallPossession
]

{ #category : 'update' }
STSoccerBoardPresenter >> updateDropListForOffsideRule [
	"Update the corresponding drop list with the current offside value."

	dropListForOffsideRule selectItem:
		(dropListForOffsideRule items detect: [ :strategyCommand |
			 gameCommander strategy isMemberOf: strategyCommand strategyClass ])
]

{ #category : 'update' }
STSoccerBoardPresenter >> updateRadioButtonsForBallPossession [
	"Update the buttons that control the ball possession."

	| owningTeam |
	owningTeam := gameCommander owningTeam.
	leftTeamPossessionButton state: owningTeam == gameCommander teamLeft.
	rightTeamPossessionButton state:
		owningTeam == gameCommander teamRight.
	neutralPossessionButton state: owningTeam isNil
]
