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
				with: [
				spec repository: 'github://pharo-graphics/Bloc:master/src' ].
			
			spec
				baseline: 'XMLParser'
				with: [
  				spec repository: 'github://pharo-contributions/XML-XMLParser/src' ].
				
			spec
				package: 'SoccerTheory-Model';
				package: 'SoccerTheory-Rendering'
				with: [ spec requires: #( 'SoccerTheory-Model'
						   'Bloc' ) ];
				package: 'SoccerTheory-Application' with: [
					spec requires:
							#( 'SoccerTheory-Rendering' 'SoccerTheory-SoccerML' ) ];
				package: 'SoccerTheory-Samples'
				with: [ spec requires: #( 'SoccerTheory-Rendering' ) ];
				package: 'SoccerTheory-Model-Tests'
				with: [ spec requires: #( 'SoccerTheory-Model' ) ];
				package: 'SoccerTheory-Rendering-Tests'
				with: [ spec requires: #( 'SoccerTheory-Rendering' ) ];
				package: 'SoccerTheory-SoccerML' with: [
						spec
							requires: #( 'SoccerTheory-Model' );
							preLoadDoIt: #saveDtdForSoccerML ];
				package: 'SoccerTheory-SoccerML-Tests'
				with: [ spec requires: #( 'SoccerTheory-SoccerML' ) ] ]
]

{ #category : 'loading' }
BaselineOfSoccerTheory >> dtdForSoccerML [
	"Answer the DTD for SoccerML."

	^ '<!ELEMENT DRIOLAR (soc:Header, soc:Sequence)>
<!ATTLIST DRIOLAR xmlns:soc CDATA #REQUIRED >
<!ELEMENT soc:Header (soc:Source, soc:Rules, soc:Pitch), soc:FramesPerSecond?>
<!ELEMENT soc:Sequence (soc:PlayIncidence?, (soc:Team, soc:Team)?, soc:Frame+)+>
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

{ #category : 'loading' }
BaselineOfSoccerTheory >> saveDtdForSoccerML [
	"Save soccerML.dtd for being resolved as external entity by XML parser."

	FileSystem disk workingDirectory / 'soccerML.dtd' writeStreamDo: [
		:stream | stream nextPutAll: self dtdForSoccerML ]
]
