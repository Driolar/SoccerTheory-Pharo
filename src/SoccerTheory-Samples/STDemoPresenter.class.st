Class {
	#name : 'STDemoPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'canva',
		'errorMessage',
		'code',
		'collector',
		'tree'
	],
	#category : 'SoccerTheory-Samples-Spec2',
	#package : 'SoccerTheory-Samples',
	#tag : 'Spec2'
}

{ #category : 'running' }
STDemoPresenter class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'Open Bloc Demo')
		action: [ self open ];
		parent: #Help;
		help: 'Open a demo browser of Bloc to display multiple example of Bloc usages.';
		iconName: #group;
		withSeparatorAfter
]

{ #category : 'running' }
STDemoPresenter class >> open [

	<script>
	self new asWindow initialExtent: 1500@800; open
]

{ #category : 'accessing' }
STDemoPresenter >> canva [ 
	^ canva 
]

{ #category : 'accessing' }
STDemoPresenter >> canva: aCanva [
	canva := aCanva 
]

{ #category : 'accessing' }
STDemoPresenter >> code [ 
	^ code
]

{ #category : 'accessing' }
STDemoPresenter >> collector [ 
	^ collector
]

{ #category : 'initialization' }
STDemoPresenter >> connectPresenters [

	tree whenSelectedItemChangedDo: [ :item |
		item ifNotNil: [
			item class = STDemoMethodNode
				ifTrue: [
					code beForMethod: item item.
					code text: item sourceCode.
					self executeCode ] ] ]
]

{ #category : 'layout' }
STDemoPresenter >> defaultLayout [

	^ SpPanedLayout newTopToBottom
		  add: (SpPanedLayout newLeftToRight
				   positionOfSlider: 300;
				   add: tree;
				   add: canva yourself);
		  add: code;
		  yourself
]

{ #category : 'drawing' }
STDemoPresenter >> drawOnCanvas: anElement [

	| root |
	root := self canva space root.
	root removeChildren.
	root addChild: ((anElement isKindOf: BlElement)
		ifTrue: [ anElement ]
		ifFalse: [ self errorMessage ])
]

{ #category : 'accessing' }
STDemoPresenter >> errorMessage [

	^ errorMessage ifNil: [
		  BlElement new
			  background: Color lightRed;
			  layout: BlFrameLayout new;
			  constraintsDo: [ :c |
				  c vertical matchParent.
				  c horizontal matchParent ];
			  addChild: (BlTextElement new
					   text:
						   'This method does not return any element for you to see'
							   asRopedText;
					   constraintsDo: [ :c |
						   c frame vertical alignCenter.
						   c frame horizontal alignCenter ]) ]
]

{ #category : 'operations' }
STDemoPresenter >> executeCode [

	| res |
	res := tree selectedItem execute.
	self drawOnCanvas: res
]

{ #category : 'TOREMOVE' }
STDemoPresenter >> initialExtent [

	| fontWidth rowHeight |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	rowHeight := self class inputTextHeight.

	^ (90@24) * (fontWidth @ rowHeight)
	
]

{ #category : 'initialization' }
STDemoPresenter >> initializeCanvaPresenter [ 
	
	canva := SpBlSpaceInMorphPresenter new
]

{ #category : 'initialization' }
STDemoPresenter >> initializeCodePresenter [

	code := self newCode
]

{ #category : 'initialization' }
STDemoPresenter >> initializeCollector [

	collector := STDemoCollector new.
	collector collectPackages: self packagesToCollect
]

{ #category : 'initialization' }
STDemoPresenter >> initializePathArray [

	| firstPackage firstClass firstItem |
	firstPackage := tree roots first.
	firstClass := firstPackage children first.
	firstItem := firstClass children first.
	^ {
		  firstPackage.
		  firstClass.
		  firstItem }
]

{ #category : 'initialization' }
STDemoPresenter >> initializePresenters [

	self initializeCollector.
	self initializeCanvaPresenter.
	self initializeTreePresenter.
	self initializeCodePresenter
]

{ #category : 'initialization' }
STDemoPresenter >> initializeTreePresenter [

	| pathArray |
	tree := SpTreePresenter new
		        roots: self collector packages;
		        children: [ :aPackageNode | aPackageNode children ];
		        displayIcon: [ :aNode | self iconNamed: aNode icon ];
		        display: [ :aPackageNode | aPackageNode name ];
		        expandRoots.
	pathArray := self initializePathArray.
	tree selectPathByItems: pathArray scrollToSelection: true
]

{ #category : 'accessing' }
STDemoPresenter >> packagesToCollect [

	^ self class packageOrganizer packages select: [ :each |
		  each name includesSubstring: 'SoccerTheory' ]
]

{ #category : 'TOREMOVE' }
STDemoPresenter >> title [ 
	^ 'Soccer Theory UI Demo'
]
