"
I provide the strategy buttons like offside rule and geometric aspects, layouted for a STSoccerBoardPresenter.
"
Class {
	#name : 'STStrategyControlArea',
	#superclass : 'STControlArea',
	#instVars : [
		'dropListForOffsideRule',
		'coverageButton',
		'shotAngleButton',
		'goalPathButton',
		'spanningTreeButton',
		'geometryToolbar'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'initialization' }
STStrategyControlArea >> connectPresenters [

	coverageButton
		whenActivatedDo: [ self renderIndividualCoverageLayer ];
		whenDeactivatedDo: [ self removeIndividualCoverageLayer ].
	shotAngleButton whenActivatedDo: [
		self inform: 'Not yet implemented' ].
	goalPathButton whenActivatedDo: [ self inform: 'Not yet implemented' ].
	spanningTreeButton
		whenActivatedDo: [ self renderTeamSpanLayer ];
		whenDeactivatedDo: [ self removeTeamSpanLayer ]
]

{ #category : 'layout' }
STStrategyControlArea >> geometryAndOffsideControlsLayout [
	"Answer the layout for geometry and offside controls."

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  add: self geometryControlsLayout expand: false;
		  add: self offsideControlLayout expand: false;
		  yourself
]

{ #category : 'layout' }
STStrategyControlArea >> geometryControlsLayout [
	"Answer the layout for geometry controls."

	^ SpBoxLayout newLeftToRight
		  add: geometryToolbar expand: false;
		  yourself
]

{ #category : 'initialization' }
STStrategyControlArea >> initializeDropListForOffsideRule [

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
			self statusbar pushMessage: 'Offside set to ' , command name , '.' ]
]

{ #category : 'update' }
STStrategyControlArea >> initializeToggleButtonsForGeometry [

	geometryToolbar := self newToolbar.
	coverageButton := self newToolbarToggleButton.
	shotAngleButton := self newToolbarToggleButton.
	goalPathButton := self newToolbarToggleButton.
	spanningTreeButton := self newToolbarToggleButton.
	geometryToolbar
		beIcons;
		add: coverageButton;
		add: shotAngleButton;
		add: goalPathButton;
		add: spanningTreeButton.


	coverageButton associatedToggleButtons: {
			shotAngleButton.
			goalPathButton }.

	coverageButton
		help: 'Individual coverage layer';
		icon: graphicFactory coverageIconForm.
	shotAngleButton
		help: 'Shot angle layer';
		icon: graphicFactory shotAngleIconForm.
	goalPathButton
		help: 'Goal path layer';
		icon: graphicFactory goalPathIconForm.
	spanningTreeButton
		help: 'Team spanning tree layer';
		icon: graphicFactory spanningTreeIconForm
]

{ #category : 'layout' }
STStrategyControlArea >> offsideControlLayout [
	"Answer the layout for offside rule control."

	^ SpBoxLayout newLeftToRight
		  hAlignEnd;
		  add: dropListForOffsideRule expand: false;
		  yourself
]

{ #category : 'rendering' }
STStrategyControlArea >> removeIndividualCoverageLayer [

	boardPresenter removeIndividualCoverageLayer
]

{ #category : 'rendering' }
STStrategyControlArea >> removeTeamSpanLayer [ 

	boardPresenter removeTeamSpanLayer
]

{ #category : 'rendering' }
STStrategyControlArea >> renderIndividualCoverageLayer [

	boardPresenter renderIndividualCoverageLayer
]

{ #category : 'rendering' }
STStrategyControlArea >> renderTeamSpanLayer [

	boardPresenter renderTeamSpanLayer
]

{ #category : 'initialization' }
STStrategyControlArea >> resetGeometryButtons [

	coverageButton beUnselected.
	coverageButton associatedToggleButtons do: [ :each |
		each beUnselected ]
]

{ #category : 'update' }
STStrategyControlArea >> updateDropListForOffsideRule [
	"Update the corresponding drop list with the current offside value."

	dropListForOffsideRule selectItem:
		(dropListForOffsideRule items detect: [ :strategyCommand |
			 self gameCommander strategy isMemberOf:
				 strategyCommand strategyClass ])
]
