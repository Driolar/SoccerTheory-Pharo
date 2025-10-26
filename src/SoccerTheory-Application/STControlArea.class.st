"
I provide for a STSoccerBoardPresenter a control area with buttons including behavior.
"
Class {
	#name : 'STControlArea',
	#superclass : 'Object',
	#instVars : [
		'boardPresenter',
		'graphicFactory'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'instance creation' }
STControlArea class >> newOn: aSTSoccerBoardPresenter [

	^ self new initializeOn: aSTSoccerBoardPresenter
]

{ #category : 'accessing' }
STControlArea >> gameCommander [

	^ boardPresenter gameCommander
]

{ #category : 'ui requests' }
STControlArea >> inform: aString [

	boardPresenter inform: aString
]

{ #category : 'initialization' }
STControlArea >> initialize [

	super initialize.
	graphicFactory := STGraphicFactory new
]

{ #category : 'initialization' }
STControlArea >> initializeOn: aSTSoccerBoardPresenter [

	boardPresenter := aSTSoccerBoardPresenter
]

{ #category : 'instance creation' }
STControlArea >> newRadioButton [

	^ boardPresenter newRadioButton
]

{ #category : 'instance creation' }
STControlArea >> newToolbar [

	^ boardPresenter newToolbar
]

{ #category : 'instance creation' }
STControlArea >> newToolbarButton [

	^ boardPresenter newToolbarButton
]

{ #category : 'instance creation' }
STControlArea >> newToolbarToggleButton [

	^ boardPresenter newToolbarToggleButton
]

{ #category : 'accessing' }
STControlArea >> statusbar [

	^ boardPresenter statusbar
]
