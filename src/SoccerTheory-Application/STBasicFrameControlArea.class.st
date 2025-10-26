"
I provide the basic buttons to open, save and reset frames layouted for a STSoccerBoardPresenter .
"
Class {
	#name : 'STBasicFrameControlArea',
	#superclass : 'STControlArea',
	#instVars : [
		'openFilePresenter',
		'saveFilePresenter'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'layout' }
STBasicFrameControlArea >> frameControlsLayout [
	"Answer the layout for frame controls."

	^ SpBoxLayout newLeftToRight
		  hAlignStart;
		  add: (SpToolbarPresenter new
				   beIcons;
				   add: self toolbarButtonToOpen;
				   add: self toolbarButtonToSave;
				   add: self toolbarButtonToReset;
				   yourself);
		  yourself
]

{ #category : 'initialization' }
STBasicFrameControlArea >> initializeButtons [

	openFilePresenter := self openingFilePresenter.
	saveFilePresenter := self savingFilePresenter
]

{ #category : 'presenters' }
STBasicFrameControlArea >> openingFilePresenter [

	^ (StOpenFilePresenter on: StFileSystemModel new)
		  openFolder: FileLocator documents;
		  extensions: #( 'socxml' );
		  okAction: [ :selectedFileReference |
			  boardPresenter loadFile: selectedFileReference ];
		  yourself
]

{ #category : 'presenters' }
STBasicFrameControlArea >> savingFilePresenter [

	^ (StSaveFilePresenter on: StFileSystemModel new)
		  openFolder: FileLocator documents;
		  extensions: #( 'socxml' );
		  okAction: [ :selectedFileReference |
			  boardPresenter saveFile: selectedFileReference ];
		  yourself
]

{ #category : 'presenters' }
STBasicFrameControlArea >> toolbarButtonToOpen [
	"Answer the toolbar button for opening a SoccerML file."

	^ self newToolbarButton
		  icon: (boardPresenter iconNamed: #open);
		  label: 'Open...';
		  help: 'Open a SoccerML file.';
		  action: [ openFilePresenter openModal ]
]

{ #category : 'presenters' }
STBasicFrameControlArea >> toolbarButtonToReset [
	"Answer the toolbar button for resetting the board."

	^ boardPresenter newToolbarButton
		  label: 'Reset';
		  icon: (boardPresenter iconNamed: #delete);
		  help:
			  'Clear irrevocably the scene and initialize it with just two goalkeepers and the ball in the middle.';
		  action: [ boardPresenter resetBoard ];
		  yourself
]

{ #category : 'presenters' }
STBasicFrameControlArea >> toolbarButtonToSave [
	"Answer the toolbar button for saving a SoccerML file."

	^ boardPresenter newToolbarButton
		  icon: (boardPresenter iconNamed: #save);
		  label: 'Save...';
		  help: 'Save the current frame to a SoccerML file.';
		  action: [ saveFilePresenter openModal ]
]
