"
I am the legend presenter for STFrameEditor in its Roassal version.
"
Class {
	#name : 'STRoassalLegendPresenter',
	#superclass : 'SpRoassalPresenter',
	#instVars : [
		'legend',
		'graphicFactory'
	],
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'instance creation' }
STRoassalLegendPresenter class >> newWithGraphicFactory: aGraphicFactory [

	^ self new initializeWith: aGraphicFactory
]

{ #category : 'private' }
STRoassalLegendPresenter >> attackLine [
	"Answer the attack line symbol."

	^ graphicFactory roassalAttackLine
		  startPoint: 0 @ 0;
		  endPoint: 60 @ 0;
		  color: self theme backgroundColor negated;
		  yourself
]

{ #category : 'private' }
STRoassalLegendPresenter >> eye [
	"Answer the eye for uncovered."

	^ graphicFactory roassalEyeWithColor: self theme backgroundColor negated
]

{ #category : 'private' }
STRoassalLegendPresenter >> goalkeeper [
	"Answer the goalkeeper symbol."

	^ graphicFactory
		  roassalLeftGoalkeeperWithCenter: 0 @ 0
		  color: self theme backgroundColor negated
]

{ #category : 'initialization' }
STRoassalLegendPresenter >> initialize [

	super initialize.
	legend := RSLegend new.
	legend layout horizontal
		alignBottom;
		horizontalGap: 20.
	legend location middle.
	legend defaultLabel
		fontSize: 9;
		color: self theme textColor.
	legend defaultTitle: (RSLabel new
			 bold;
			 fontSize: 9;
			 color: self theme textColor)
]

{ #category : 'initialization' }
STRoassalLegendPresenter >> initializeWith: aGraphicFactory [

	graphicFactory := aGraphicFactory.
	legend
		title: 'Legend: ';
		text: 'is offside' withShape: self offsideFlag;
		text: 'is uncovered' withShape: self eye;
		text: 'goalkeeper' withShape: self goalkeeper;
		text: 'attack line' withShape: self attackLine;
		text: 'offside line' withShape: self offsideLine.
	self canvas
		color: Color transparent;
		add: legend asShape
]

{ #category : 'private' }
STRoassalLegendPresenter >> offsideFlag [
	"Answer the offside flag."

	^ graphicFactory roassalFlagWavingToLeftWithColor:
		  self theme backgroundColor negated
]

{ #category : 'private' }
STRoassalLegendPresenter >> offsideLine [
	"Answer the attack line symbol."

	^ graphicFactory roassalOffsideLine
		  startPoint: 0 @ 0;
		  endPoint: 60 @ 0;
		  color: self theme backgroundColor negated;
		  yourself
]
