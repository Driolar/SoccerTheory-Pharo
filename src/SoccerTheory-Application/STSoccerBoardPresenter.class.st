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
		'graphicFactory',
		'leftTeamAddPlayerButton',
		'rightTeamAddPlayerButton',
		'ballPossessionController',
		'basicFrameController',
		'strategyController'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

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

{ #category : 'layout' }
STSoccerBoardPresenter >> ballPossessionControlsLayout [
	"Answer the layout for ball possession controls."

	^ ballPossessionController controlsLayout
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> connectPresenters [

	super connectPresenters.
	strategyController connectPresenters
]

{ #category : 'layout' }
STSoccerBoardPresenter >> controlsLayout [
	"Answer the layout for the common controls row."

	^ SpBoxLayout newLeftToRight
		  beHomogeneous;
		  add: self frameControlsLayout;
		  add: self shapeControlsLayout;
		  add: self strategyControlsLayout;
		  yourself
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> controlsPresenter [
	"Answer the SpPresenter with the controls row."

	| presenter |
	presenter := SpPresenter new.
	presenter layout: self controlsLayout.
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

	^ basicFrameController frameControlsLayout
]

{ #category : 'accessing' }
STSoccerBoardPresenter >> gameAnnouncer [
	"Answer the announcer I use to subscribe for announcements."

	^ scene gameAnnouncer
]

{ #category : 'accessing' }
STSoccerBoardPresenter >> gameCommander [
	"Answer my game commander."

	^ gameCommander
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> initializeBallPossessionButtons [

	ballPossessionController := STBallPossessionControlArea newOn: self.
	ballPossessionController initializeButtons
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> initializeBasicFrameButtons [

	basicFrameController := STBasicFrameControlArea newOn: self.
	basicFrameController initializeButtons
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> initializePresenters [
	"Initialize the main presenters."

	super initializePresenters.
	graphicFactory := STGraphicFactory new.
	board := self newBoard.
	statusbar := self newStatusBar.
	self initializeBasicFrameButtons. 
	leftTeamAddPlayerButton := self newButton.
	rightTeamAddPlayerButton := self newButton.
	self initializeBallPossessionButtons.
	self initializeStrategyButtons.
	self resetBoard
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> initializeStrategyButtons [

	strategyController := STStrategyControlArea newOn: self.
	strategyController initializeDropListForOffsideRule
]

{ #category : 'presenters' }
STSoccerBoardPresenter >> legendPresenter [
	"Answer the SpPresenter containing the legend."

	^ self scenePlug legendPresenterClass newWithGraphicFactory:
		  graphicFactory
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

{ #category : 'loading' }
STSoccerBoardPresenter >> refreshBoard [
	"Refresh scene depending on scene and board classes."

	scene := self scenePlug
		         newSceneWithGameCommander: gameCommander.
	self scenePlug refreshViewOnPresenter: board scene: scene
]

{ #category : 'initialization' }
STSoccerBoardPresenter >> registerAtAnnouncer [
	"Register to the announcements I am interested in."

	self gameAnnouncer
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

	self gameAnnouncer
		when: STBallShapeMovedAnnouncement
		do: [ :ann |
				| targetWorldPoint |
				targetWorldPoint := scene toWorld: ann targetDevicePoint.
				statusbar pushMessage: 'Ball moved to '
					, (self formattedStringForWorldPosition: targetWorldPoint) ]
		for: self.

	self gameAnnouncer
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

{ #category : 'accessing' }
STSoccerBoardPresenter >> statusbar [

	^ statusbar
]

{ #category : 'layout' }
STSoccerBoardPresenter >> strategyControlsLayout [
	"Answer the default layout for strategy controls."

	^ strategyController offsideControlLayout
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

	strategyController updateDropListForOffsideRule
]

{ #category : 'update' }
STSoccerBoardPresenter >> updateRadioButtonsForBallPossession [
	"Update the buttons that control the ball possession."

	ballPossessionController updateRadioButtons
]
