"
I am the baseline for the Soccer Theory Suite.

Specially, I save the file soccerML.dtd at the working directory for being resolved as external entity by the validating XML parser.
"
Class {
	#name : 'BaselineOfSoccerTheory',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSoccerTheory-Baseline',
	#package : 'BaselineOfSoccerTheory',
	#tag : 'Baseline'
}

{ #category : 'baselines' }
BaselineOfSoccerTheory >> baseline: spec [

	<baseline>
	spec for: #common do: [
			self blocOn: spec.
			self xmlParserOn: spec.
			self neoJsonOn: spec.
			self graphAlgorithmsOn: spec.

			spec
				package: 'SoccerTheory-Model'
				with: [ spec requires: #( 'AIGraphAlgorithms' ) ];
				package: 'SoccerTheory-Graphics'
				with: [ spec requires: #( 'SoccerTheory-Model'
						   'Bloc' ) ];
				package: 'SoccerTheory-Application'
				with: [
					spec requires:
							#( 'SoccerTheory-Graphics' 'SoccerTheory-SoccerML' ) ];
				package: 'SoccerTheory-Samples'
				with: [ spec requires: #( 'SoccerTheory-Graphics' ) ];
				package: 'SoccerTheory-Model-Tests'
				with: [ spec requires: #( 'SoccerTheory-Model' ) ];
				package: 'SoccerTheory-Graphics-Tests'
				with: [ spec requires: #( 'SoccerTheory-Graphics' ) ];
				package: 'SoccerTheory-SoccerML' with: [
						spec
							requires: #( 'SoccerTheory-Model' 'XMLParser' 'NeoJSON' );
							preLoadDoIt: #saveDtdForSoccerML ];
				package: 'SoccerTheory-SoccerML-Tests'
				with: [ spec requires: #( 'SoccerTheory-SoccerML' ) ] ]
]

{ #category : 'baselines' }
BaselineOfSoccerTheory >> blocOn: spec [

	spec
		baseline: 'Bloc'
		with: [ spec repository: 'github://pharo-graphics/Bloc:master/src' ]
]

{ #category : 'loading' }
BaselineOfSoccerTheory >> dtdForSoccerML [
	"Answer the DTD for SoccerML."

	^ '<!ELEMENT DRIOLAR (soc:Header, soc:Sequence+)>
<!ATTLIST DRIOLAR xmlns:soc CDATA #REQUIRED >
<!ELEMENT soc:Header (soc:Source, soc:Rules, soc:Pitch, soc:FramesPerSecond?)>
<!ELEMENT soc:Sequence (soc:PlayIncidence?, (soc:Team, soc:Team)?, soc:Frame+)>
<!ELEMENT soc:Source (#PCDATA)>
<!ELEMENT soc:Rules (soc:Offside)>
<!ELEMENT soc:FramesPerSecond (#PCDATA)>
<!ELEMENT soc:Offside (#PCDATA)> <!-- Valid values: 1863, 1866, 1925, none -->
<!ELEMENT soc:Pitch (soc:Length, soc:Width, soc:GoalWidth)>
<!ATTLIST soc:Pitch unit (meter) "meter">
<!ELEMENT soc:Length (#PCDATA)>
<!ELEMENT soc:Width (#PCDATA)>
<!ELEMENT soc:GoalWidth (#PCDATA)>
<!ELEMENT soc:PlayIncidence (soc:RobocupPlayMode?, soc:PossessingTeam?)>
<!ELEMENT soc:RobocupPlayMode (#PCDATA)>
<!ELEMENT soc:Team (soc:TeamName, soc:Score?)>
<!ATTLIST soc:Team side (l | r) #REQUIRED>
<!ELEMENT soc:TeamName (#PCDATA)>
<!ELEMENT soc:Score (#PCDATA)>
<!ELEMENT soc:Frame (soc:Ball, soc:Player+)>
<!ATTLIST soc:Frame time CDATA #REQUIRED>
<!ELEMENT soc:Ball (soc:X, soc:Y, soc:PossessingTeam)>
<!ELEMENT soc:Player (soc:X, soc:Y)>
<!ATTLIST soc:Player
team (l | r) #REQUIRED
number CDATA #REQUIRED
isKicking (true | false) "false"
isGoalie (true | false) "false"
isCatching (true | false) "false">
<!ELEMENT soc:X (#PCDATA)>
<!ELEMENT soc:Y (#PCDATA)>
<!ELEMENT soc:PossessingTeam (#PCDATA)> <!-- Valid values: l, r -->'
]

{ #category : 'baselines' }
BaselineOfSoccerTheory >> graphAlgorithmsOn: spec [

	spec
		baseline: 'AIGraphAlgorithms'
		with: [ spec repository: 'github://pharo-ai/graph-algorithms' ]
]

{ #category : 'baselines' }
BaselineOfSoccerTheory >> neoJsonOn: spec [

	spec
		baseline: 'NeoJSON'
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ]
]

{ #category : 'loading' }
BaselineOfSoccerTheory >> saveDtdForSoccerML [
	"Save soccerML.dtd for being resolved as external entity by XML parser."

	FileSystem disk workingDirectory / 'soccerML.dtd' writeStreamDo: [
		:stream | stream nextPutAll: self dtdForSoccerML ]
]

{ #category : 'baselines' }
BaselineOfSoccerTheory >> xmlParserOn: spec [

	spec
		baseline: 'XMLParser'
		with: [
		spec repository: 'github://pharo-contributions/XML-XMLParser/src' ]
]
