"
I provide the layouted ball possession buttons for a STSoccerBoardPresenter including behaviour.
"
Class {
	#name : 'STBallPossessionControlArea',
	#superclass : 'STControlArea',
	#instVars : [
		'rightTeamPossessionButton',
		'leftTeamPossessionButton',
		'neutralPossessionButton'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'layout' }
STBallPossessionControlArea >> controlsLayout [
	"Answer the layout for ball possession controls."

	^ SpBoxLayout newLeftToRight
		  add: leftTeamPossessionButton;
		  add: neutralPossessionButton;
		  add: rightTeamPossessionButton;
		  yourself
]

{ #category : 'initialization' }
STBallPossessionControlArea >> initializeButtons [

	leftTeamPossessionButton := self newRadioButton
		                            label: 'Ball team left';
		                            whenActivatedDo: [
			                            self gameCommander
				                            changeBallOwnerToTeam:
					                            self gameCommander teamLeft ];
		                            yourself.

	rightTeamPossessionButton := self newRadioButton
		                             label: 'Ball team right';
		                             whenActivatedDo: [
			                             self gameCommander
				                             changeBallOwnerToTeam:
					                             self gameCommander teamRight ];
		                             yourself.

	neutralPossessionButton := self newRadioButton
		                           label: 'Ball neutral';
		                           whenActivatedDo: [
			                           self gameCommander
				                           changeBallOwnerToTeam: nil ];
		                           yourself.

	leftTeamPossessionButton associatedRadioButtons: {
			neutralPossessionButton.
			rightTeamPossessionButton }
]

{ #category : 'update' }
STBallPossessionControlArea >> updateRadioButtons [
	"Update the buttons that control the ball possession."

	| owningTeam |
	owningTeam := self gameCommander owningTeam.
	leftTeamPossessionButton state:
		owningTeam == self gameCommander teamLeft.
	rightTeamPossessionButton state:
		owningTeam == self gameCommander teamRight.
	neutralPossessionButton state: owningTeam isNil
]
