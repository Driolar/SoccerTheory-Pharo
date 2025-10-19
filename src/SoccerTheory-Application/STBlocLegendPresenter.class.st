"
I am the legend presenter for STFrameEditor (Bloc based) and STSequencePlayer.
"
Class {
	#name : 'STBlocLegendPresenter',
	#superclass : 'SpPresenter',
	#category : 'SoccerTheory-Application-Presenter',
	#package : 'SoccerTheory-Application',
	#tag : 'Presenter'
}

{ #category : 'instance creation' }
STBlocLegendPresenter class >> newWithGraphicFactory: aGraphicFactory [

	^ self new initializeWith: aGraphicFactory
]

{ #category : 'private' }
STBlocLegendPresenter >> attackLineFormForLegend [
	"Answer a sample attack line for legend as Form."

^ self legendFormForStrategicLineClass: STBlocAttackLineShape
]

{ #category : 'presenters' }
STBlocLegendPresenter >> initializeWith: aGraphicFactory [

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
STBlocLegendPresenter >> legendFormForStrategicLineClass: aClass [
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
STBlocLegendPresenter >> offsideLineFormForLegend [
	"Answer a sample offside line for legend as Form."

	^ self legendFormForStrategicLineClass: STBlocOffsideLineShape
]
