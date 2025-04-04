Class {
	#name : 'BaselineOfSoccerTheory',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSoccerTheory',
	#package : 'BaselineOfSoccerTheory'
}

{ #category : 'baselines' }
BaselineOfSoccerTheory >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Bloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc:v2.2.0/src' ].

		spec
			package: 'SoccerTheory-Model';
			package: 'SoccerTheory-Rendering'
			with: [ spec requires: #( 'SoccerTheory-Model' 'Bloc' ) ];
			package: 'SoccerTheory-Application'
			with: [ spec requires: #( 'SoccerTheory-Rendering' ) ];
			package: 'SoccerTheory-Samples'
			with: [ spec requires: #( 'SoccerTheory-Rendering' ) ];
			package: 'SoccerTheory-Model-Tests'
			with: [ spec requires: #( 'SoccerTheory-Model' ) ];
			package: 'SoccerTheory-Rendering-Tests'
			with: [ spec requires: #( 'SoccerTheory-Rendering' ) ] ]
]
