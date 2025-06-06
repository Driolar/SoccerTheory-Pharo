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
		'controls',
		'statusbar',
		'dropListForOffsideRule',
		'graphicFactory',
		'rightTeamPossessionButton',
		'leftTeamPossessionButton',
		'neutralPossessionButton',
		'leftTeamAddPlayerButton',
		'rightTeamAddPlayerButton'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'TOREMOVE' }
STFrameEditor class >> aboutText [

	^ 'SoTheBo, The Soccer Theory Board, is a software application to visualize the Theory of Soccer.'
]

{ #category : 'instance creation' }
STFrameEditor class >> open [
	"Open the Soccer Theory Board."

	<script>
	self new asWindow
		title: 'SoTheBo – The Soccer Theory Board';
		aboutText: self aboutText;
		initialExtent: 1180 @ 884;
		beNotResizable; "but is still maximizable"
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

	^ STSoccerFrame announcer
]

{ #category : 'private' }
STFrameEditor >> attackLineFormForLegend [
	"Answer a sample attack line for legend as Form."

^ self legendFormForStrategicLineClass: STAttackLineShape
]

{ #category : 'layout' }
STFrameEditor >> ballPossessionControlsLayout [
	"Answer the layout for ball possession controls."

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
			rightTeamPossessionButton }.

	^ SpBoxLayout newLeftToRight
		  add: leftTeamPossessionButton;
		  add: neutralPossessionButton;
		  add: rightTeamPossessionButton;
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
		  add: controls expand: false;
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
		  add: self menuButtonForLoadingExamples width: 100;
		  add: self resettingButton expand: false;
		  yourself
]

{ #category : 'accessing' }
STFrameEditor >> gameCommander [
	"Answer my game commander."

	^ gameCommander
]

{ #category : 'initialization' }
STFrameEditor >> initializePresenters [
	"Initialize the main presenters."

	super initializePresenters.
	graphicFactory := STGraphicFactory new.
	controls := self controlsPresenter.
	board := SpBlSpaceInMorphPresenter new.
	statusbar := self newStatusBar.
	self resetBoard
]

{ #category : 'private' }
STFrameEditor >> legendFormForStrategicLineClass: aClass [ 
	"Answer a sample strategic line for the legend as Form."

	| strategicLine |
	strategicLine := aClass 
		              newWithSegmentLength: 100
		              strategicX: 0
		              color: Color black.
	strategicLine transform
		topLeftOrigin;
		rotateBy: -90;
		translateBy: 0 @ 5;
		apply.

	^ BlElement new
		  size: 100 @ 10;
		  background: Color white;
		  addChild: strategicLine;
		  asForm
]

{ #category : 'presenters' }
STFrameEditor >> legendPresenter [
	"Answer the SpPresenter containing the legend."

	| presenter |
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newLeftToRight
			 hAlignCenter;
			 add: (SpLabelPresenter new
					  label: 'Legend:';
					  displayBold: [ :aClass | true ];
					  yourself)
			 width: 60;
			 add: (SpImagePresenter new image: graphicFactory offsideForm);
			 add: (SpLabelPresenter new label: '') width: 2;
			 add: (SpLabelPresenter new label: 'is offside');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: graphicFactory uncoveredForm);
			 add: (SpLabelPresenter new label: '') width: 2;
			 add: (SpLabelPresenter new label: 'is uncovered');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: graphicFactory goalkeeperForm);
			 add: (SpLabelPresenter new label: '') width: 2;
			 add: (SpLabelPresenter new label: 'goalkeeper');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: self attackLineFormForLegend);
			 add: (SpLabelPresenter new label: '') width: 5;
			 add: (SpLabelPresenter new label: 'attack line');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: self offsideLineFormForLegend);
			 add: (SpLabelPresenter new label: '') width: 5;
			 add: (SpLabelPresenter new label: 'offside line')).
	^ presenter
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

	scene := STSoccerScene
		         newApplicationSceneWithFrame: aFrame
		         graphicFactory: graphicFactory.
	gameCommander := STGameCommander newWithFrame: aFrame.

	self updateButtonsForAddingPlayer.
	self updateDropListForOffsideRule.
	self updateRadioButtonsForBallPossession.

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

{ #category : 'private' }
STFrameEditor >> offsideLineFormForLegend [
	"Answer a sample offside line for legend as Form."

	^ self legendFormForStrategicLineClass: STOffsideLineShape
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
			gameCommander movePlayer: player toPosition: targetWorldPoint.
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
			gameCommander moveBallToPosition: targetWorldPoint.
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

{ #category : 'presenters' }
STFrameEditor >> resettingButton [
	"Answer the button for resetting the board."

	^ SpButtonPresenter new
		  label: 'Reset';
		  action: [ self resetBoard ];
		  yourself
]

{ #category : 'layout' }
STFrameEditor >> shapeControlsLayout [
	"Answer the layout for shape (ball, players) controls."

	^ SpBoxLayout newLeftToRight
		  add: (leftTeamAddPlayerButton := self newButton);
		  add: self ballPossessionControlsLayout;
		  add: (rightTeamAddPlayerButton := self newButton);
		  yourself
]

{ #category : 'layout' }
STFrameEditor >> strategyControlsLayout [
	"Answer the layout for strategy controls."

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
		statusbar pushMessage: 'Offside set to ' , command name , '.' ].

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  add: dropListForOffsideRule expand: false;
		  yourself
]

{ #category : 'update' }
STFrameEditor >> updateButton: aSpButtonPresenter forAddingPlayerOfTeam: aSTTeam [
	"Update the given player addition button for the corresponding team."

	| playerSquare |
	playerSquare := BlElement new
		                background: aSTTeam jerseyGradient;
		                size: 18 asPoint;
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
