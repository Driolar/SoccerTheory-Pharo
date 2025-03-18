"
I am the user interface for the Soccer Theory Board.

I rely on STSoccerScene for rendering the soccer game view.
I rely on STGameCommander for soccer model control.

Start me doing this: STFrameEditor open.
"
Class {
	#name : 'STFrameEditor',
	#superclass : 'SpPresenterWithModel',
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
		'neutralPossessionButton'
	],
	#category : 'SoccerTheory-Application-Basic',
	#package : 'SoccerTheory-Application',
	#tag : 'Basic'
}

{ #category : 'instance creation' }
STFrameEditor class >> open [
	"Open the Soccer Theory Board."

	<script>
	self new asWindow
		title: 'SoTheBo – The Soccer Theory Board';
		initialExtent: 1180 @ 884;
		beNotResizable;
		open
]

{ #category : 'private' }
STFrameEditor >> announcer [
	"Answer the announcer I use to subscribe for announcements."

	^ STSoccerFrame announcer
]

{ #category : 'presenters' }
STFrameEditor >> controlsPresenter [
	"Answer the SpPresenter with the controls row."

	| presenter |
	presenter := SpPresenter new.
	dropListForOffsideRule := SpDropListPresenter new.
	dropListForOffsideRule disable.
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
STFrameEditor >> formattedStringForWorldPosition: aPosition [
	"Answer the formatted string for the given world position."

	^ '(' , (aPosition x printShowingDecimalPlaces: 1) , '@'
	  , (aPosition y printShowingDecimalPlaces: 1) , ')'
]

{ #category : 'layout' }
STFrameEditor >> frameControlsLayout [
	"Answer the layout for frame controls."

	^ SpBoxLayout newLeftToRight
		  add: self menuButtonForLoadingExamples width: 100;
		  add: self resettingButton expand: false;
		  yourself
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
			 add: (SpLabelPresenter new label: 'goalkeeper')).
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
STFrameEditor >> loadFrame: aFrame named: aFrameName [
	"Load the given STSoccerFrame on the scene."

	scene := STSoccerScene
		         newApplicationSceneWithFrame: aFrame
		         graphicFactory: graphicFactory.
	gameCommander := STGameCommander newWithFrame: aFrame.

	self registerAtAnnouncer.

	self updateDropListForOffsideRule.
	self updateRadioButtonsForBallPossession.

	board space setExtent: scene totalExtent.
	board space
		root: scene;
		becomeVisible.
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
				'Player ' , player jerseyNumber displayString , ' ('
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
		named: 'Start frame'
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
	"Answer the layout for shape controls."

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

{ #category : 'layout' }
STFrameEditor >> strategyControlsLayout [
	"Answer the layout for strategy controls."

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  add: dropListForOffsideRule expand: false;
		  yourself
]

{ #category : 'update' }
STFrameEditor >> updateDropListForOffsideRule [
	"Update the corresponding drop list with the current offside value."

	| label |
	label := gameCommander strategy displayRule.
	dropListForOffsideRule emptyList.
	dropListForOffsideRule items: (OrderedCollection new
			 add: label;
			 yourself)
]

{ #category : 'update' }
STFrameEditor >> updateRadioButtonsForBallPossession [
	"Update the buttons controlling the ball possession."

	| owningTeam |
	owningTeam := gameCommander owningTeam.
	leftTeamPossessionButton state: owningTeam == gameCommander teamLeft.
	rightTeamPossessionButton state:
		owningTeam == gameCommander teamRight.
	neutralPossessionButton state: owningTeam isNil
]
