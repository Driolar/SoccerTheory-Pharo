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
		'symbolFactory'
	],
	#category : 'SoccerTheory-Application',
	#package : 'SoccerTheory-Application'
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
			  spacing: 20;
			 hAlignCenter;
			 add: dropListForOffsideRule;
			 add: self menuButtonForLoadingExamples width: 100;
			 add: self resettingButton;
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

{ #category : 'initialization' }
STFrameEditor >> initializePresenters [
	"Initialize the main presenters."

	super initializePresenters.
	symbolFactory := STGraphicFactory new.
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
			 add: (SpImagePresenter new image: symbolFactory offsideForm);
			 add: (SpLabelPresenter new label: '') width: 2;
			 add: (SpLabelPresenter new label: 'is offside');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: symbolFactory uncoveredForm);
			 add: (SpLabelPresenter new label: '') width: 2;
			 add: (SpLabelPresenter new label: 'is uncovered');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: symbolFactory goalkeeperForm);
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
		         symbolFactory: symbolFactory.
	gameCommander := STGameCommander newWithFrame: aFrame.

	self registerAtAnnouncer.

	self updateDropListForOffsideRule.

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
			targetWorldPoint := scene toWorld:
				                    ann targetDevicePoint - scene borderWidth.
			gameCommander movePlayer: player toPosition: targetWorldPoint.
			statusbar message:
				'Player ' + player jerseyNumber asString + ' (team ' , player teamName
				, ') moved to '
				, (self formattedStringForWorldPosition: targetWorldPoint) ]
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

{ #category : 'update' }
STFrameEditor >> updateDropListForOffsideRule [
	"Update the corresponding drop list with the current offside value."

	| label |
	label := gameCommander strategy
		         ifNotNil: [ gameCommander strategy displayRule ]
		         ifNil: [ 'No offside rule' ].
	dropListForOffsideRule emptyList.
	dropListForOffsideRule items: (OrderedCollection new
			 add: label;
			 yourself)
]
