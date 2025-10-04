"
I am the legend presenter for STFrameEditor and STSequencePlayer.
"
Class {
	#name : 'STLegendPresenter',
	#superclass : 'SpPresenter',
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'instance creation' }
STLegendPresenter class >> newWithGraphicFactory: aGraphicFactory [

	^ self new initializeWith: aGraphicFactory
]

{ #category : 'private' }
STLegendPresenter >> attackLineFormForLegend [
	"Answer a sample attack line for legend as Form."

^ self legendFormForStrategicLineClass: STBlocAttackLineShape
]

{ #category : 'presenters' }
STLegendPresenter >> initializeWith: aGraphicFactory [

	self layout: (SpBoxLayout newLeftToRight
			 hAlignCenter;
			 add: (SpLabelPresenter new
					  label: 'Legend:';
					  displayBold: [ :aClass | true ];
					  yourself)
			 width: 60;
			 add: (SpImagePresenter new image: aGraphicFactory offsideForm);
			 add: (SpLabelPresenter new label: '') width: 2;
			 add: (SpLabelPresenter new label: 'is offside');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: aGraphicFactory uncoveredForm);
			 add: (SpLabelPresenter new label: '') width: 2;
			 add: (SpLabelPresenter new label: 'is uncovered');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: aGraphicFactory goalkeeperForm);
			 add: (SpLabelPresenter new label: '') width: 2;
			 add: (SpLabelPresenter new label: 'goalkeeper');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: self attackLineFormForLegend);
			 add: (SpLabelPresenter new label: '') width: 5;
			 add: (SpLabelPresenter new label: 'attack line');
			 add: (SpLabelPresenter new label: '') width: 20;
			 add: (SpImagePresenter new image: self offsideLineFormForLegend);
			 add: (SpLabelPresenter new label: '') width: 5;
			 add: (SpLabelPresenter new label: 'offside line'))
]

{ #category : 'private' }
STLegendPresenter >> legendFormForStrategicLineClass: aClass [
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
		  extent: 100 @ 10;
		  background: Color white;
		  addChild: strategicLine;
		  asForm
]

{ #category : 'private' }
STLegendPresenter >> offsideLineFormForLegend [
	"Answer a sample offside line for legend as Form."

	^ self legendFormForStrategicLineClass: STBlocOffsideLineShape
]
