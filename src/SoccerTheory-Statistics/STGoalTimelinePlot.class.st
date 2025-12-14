"
I render on a frame time line the goals scored by a team. 
"
Class {
	#name : 'STGoalTimelinePlot',
	#superclass : 'RSAbstractPlot',
	#instVars : [
		'ballShapes'
	],
	#category : 'SoccerTheory-Statistics',
	#package : 'SoccerTheory-Statistics'
}

{ #category : 'accessing' }
STGoalTimelinePlot >> createdShapes [

	^ { ballShapes }
]

{ #category : 'accessing - defaults' }
STGoalTimelinePlot >> defaultShape [

	^ RSCircle new noPaint
]

{ #category : 'accessing' }
STGoalTimelinePlot >> entries: aCollection at: aNumber [
	"Set the ball shape positions in aCollection."

	self x: aCollection y: (Array new: aCollection size withAll: aNumber)
]

{ #category : 'initialization' }
STGoalTimelinePlot >> initialize [

	super initialize.
	ballShapes := RSGroup new
]

{ #category : 'rendering' }
STGoalTimelinePlot >> renderIn: canvas [

	super renderIn: canvas.
	1 to: xValues size do: [ :index |
			ballShapes add: (self shape copy
					 position:
						 (self scalePoint: (xValues at: index) @ (yValues at: index));
					 model: (xValues at: index);
					 @ (RSPopup text: [ :frameNumber | frameNumber asString ]);
					 yourself) ].
	canvas addAll: ballShapes
]
