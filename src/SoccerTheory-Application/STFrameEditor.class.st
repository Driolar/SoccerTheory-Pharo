"
I am the user interface for the Soccer Theory Board.

I rely on STSoccerScene for rendering the soccer game view.
I rely on STGameCommander for soccer model control.

Start me doing this: STFrameEditor open.
"
Class {
	#name : 'STFrameEditor',
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
STFrameEditor class >> aboutText [

	^ 'SoTheBoard, The Soccer Theory Board, is a software application to edit a single soccer scene (frame) on a two-dimensional play field. SoTheBoard belongs to the Soccer Theory software suite dedicated to visualize the Theory of Soccer.'
]

{ #category : 'instance creation' }
STFrameEditor class >> open [
	"Open the Soccer Theory Board."

	<script>
	self new asWindow
		title: 'SoTheBoard – The Soccer Theory Board';
		aboutText: self aboutText;
		initialExtent: 1180 @ 884;
		beNotResizable; 
		open
]

{ #category : 'private' }
STFrameEditor >> addNewPlayerToTeam: aSTTeam [
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
STFrameEditor >> announcer [
	"Answer the announcer I use to subscribe for announcements."

	^ scene announcer
]

{ #category : 'layout' }
STFrameEditor >> ballPossessionControlsLayout [
	"Answer the layout for ball possession controls."

	^ SpBoxLayout newLeftToRight
		  add: leftTeamPossessionButton;
		  add: neutralPossessionButton;
		  add: rightTeamPossessionButton;
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

{ #category : 'presenters' }
STFrameEditor >> controlsPresenter [
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
STFrameEditor >> defaultLayout [
	"Answer the composed layout."

	^ SpBoxLayout newTopToBottom
		  add: self controlsPresenter expand: false;
		  add: board;
		  add: self legendPresenter expand: false;
		  add: statusbar expand: false;
		  yourself
]

{ #category : 'private' }
STFrameEditor >> formattedStringForWorldPosition: aPoint [
	"Answer the formatted string for the given world position."

	^ '(' , (aPoint x printShowingDecimalPlaces: 1) , '@'
	  , (aPoint y printShowingDecimalPlaces: 1) , ')'
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

{ #category : 'accessing' }
STFrameEditor >> gameCommander [
	"Answer my game commander."

	^ gameCommander
]

{ #category : 'initialization' }
STFrameEditor >> initializeBallPossessionButtons [

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
STFrameEditor >> initializeDropListForOffsideRule [

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
STFrameEditor >> initializePresenters [
	"Initialize the main presenters."

	super initializePresenters.
	graphicFactory := STGraphicFactory new.
	board := SpBlSpaceInMorphPresenter new.
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
STFrameEditor >> legendPresenter [
	"Answer the SpPresenter containing the legend."

	^ STLegendPresenter newWithGraphicFactory: graphicFactory
]

{ #category : 'loading' }
STFrameEditor >> loadFile: aFileReference [
	"Extract the first STSoccerFrame from the given SoccerML file, display it and push a message on the status bar."

	| reader |
	reader := STSoccerDocumentReader on: aFileReference contents.
	reader parseFirstFrame.
	self
		loadFrame: reader currentSoccerFrame
		named: aFileReference basename
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

{ #category : 'loading' }
STFrameEditor >> loadFrame: aFrame [
	"Load the given STSoccerFrame on the scene."

	gameCommander := STGameCommander newWithFrame: aFrame.
	scene := STSoccerScene
		         newApplicationSceneWithGameCommander: gameCommander
		         graphicFactory: graphicFactory.

	self updateButtonsForAddingPlayer.
	self updateDropListForOffsideRule.
	self updateRadioButtonsForBallPossession.

	board space root removeChildren.
	board space setExtent: scene totalExtent.
	board space root addChild: scene.

	self registerAtAnnouncer
]

{ #category : 'loading' }
STFrameEditor >> loadFrame: aFrame named: aFrameName [
	"Load the given STSoccerFrame on the scene and push a message on the status bar."

	self loadFrame: aFrame.
	statusbar pushMessage: aFrameName , ' loaded.'
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

{ #category : 'presenters' }
STFrameEditor >> openingFilePresenter [

	^ (StOpenFilePresenter on: StFileSystemModel new)
		  openFolder: FileLocator documents;
		  extensions: #( 'socxml' );
		  okAction: [ :selectedFileReference |
			  self loadFile: selectedFileReference ];
		  yourself
]

{ #category : 'initialization' }
STFrameEditor >> registerAtAnnouncer [
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
STFrameEditor >> resetBoard [
	"Reset the board to the start frame."

	self
		loadFrame:
		(STSoccerFrameBuilder startFrameWithPitch: STPitch newDefault)
		named: 'Initial scene'
]

{ #category : 'private' }
STFrameEditor >> saveFile: aFileReference [
	"Write the STSoccerFrame to SoccerML and save the document under the given file reference. Push a message on the status bar."

	| writer |
	writer := STSoccerDocumentWriter on: gameCommander frame.
	aFileReference writeStreamDo: [ :stream |
		stream nextPutAll: writer writeWholeDocument ]
]

{ #category : 'presenters' }
STFrameEditor >> savingFilePresenter [

	^ (StSaveFilePresenter on: StFileSystemModel new)
		  openFolder: FileLocator documents;
		  extensions: #( 'socxml' );
		  okAction: [ :selectedFileReference |
			  self saveFile: selectedFileReference ];
		  yourself
]

{ #category : 'layout' }
STFrameEditor >> shapeControlsLayout [
	"Answer the layout for shape (ball, players) controls."

	^ SpBoxLayout newLeftToRight
		  add: leftTeamAddPlayerButton;
		  add: self ballPossessionControlsLayout;
		  add: rightTeamAddPlayerButton;
		  yourself
]

{ #category : 'layout' }
STFrameEditor >> strategyControlsLayout [
	"Answer the layout for strategy controls."

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  add: dropListForOffsideRule expand: false;
		  yourself
]

{ #category : 'presenters' }
STFrameEditor >> toolbarButtonToOpen [
	"Answer the toolbar button for opening a SoccerML file."

	^ self newToolbarButton
		  icon: (self iconNamed: #open);
		  label: 'Open...';
		  help: 'Open a SoccerML file.';
		  action: [ openFilePresenter openModal ]
]

{ #category : 'presenters' }
STFrameEditor >> toolbarButtonToReset [
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
STFrameEditor >> toolbarButtonToSave [
	"Answer the toolbar button for saving a SoccerML file."

	^ self newToolbarButton
		  icon: (self iconNamed: #save);
		  label: 'Save...';
		  help: 'Save the current frame to a SoccerML file.';
		  action: [ saveFilePresenter openModal ]
]

{ #category : 'update' }
STFrameEditor >> updateButton: aSpButtonPresenter forAddingPlayerOfTeam: aSTTeam [
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
STFrameEditor >> updateButtonsForAddingPlayer [
	"Update both buttons for team player addition."

	self
		updateButton: leftTeamAddPlayerButton
		forAddingPlayerOfTeam: gameCommander teamLeft.
	self
		updateButton: rightTeamAddPlayerButton
		forAddingPlayerOfTeam: gameCommander teamRight
]

{ #category : 'update' }
STFrameEditor >> updateDropListForOffsideRule [
	"Update the corresponding drop list with the current offside value."

	dropListForOffsideRule selectItem:
		(dropListForOffsideRule items detect: [ :strategyCommand |
			 gameCommander strategy isMemberOf: strategyCommand strategyClass ])
]

{ #category : 'update' }
STFrameEditor >> updateRadioButtonsForBallPossession [
	"Update the buttons that control the ball possession."

	| owningTeam |
	owningTeam := gameCommander owningTeam.
	leftTeamPossessionButton state: owningTeam == gameCommander teamLeft.
	rightTeamPossessionButton state:
		owningTeam == gameCommander teamRight.
	neutralPossessionButton state: owningTeam isNil
]
