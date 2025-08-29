Class {
	#name : 'STEptsConverterTest',
	#superclass : 'TestCase',
	#instVars : [
		'eptsConverter'
	],
	#category : 'SoccerTheory-SoccerML-Tests',
	#package : 'SoccerTheory-SoccerML-Tests'
}

{ #category : 'fixtures' }
STEptsConverterTest >> fifaExampleFormatSpecificationNode [
	"Answer the data format specification nodes collection."

	^ ((XMLDOMParser parse: self fifaExampleXml) allElementsNamed:
		   'DataFormatSpecification') first
]

{ #category : 'fixtures' }
STEptsConverterTest >> fifaExampleRawData [
		"Answer a ReadStream containing a minimal raw data example provided by FIFA and available [here](https://github.com/george-wood/epts/tree/master/inst/extdata).
		Georg Wood warns [here](https://github.com/george-wood/epts/tree/master) as follows: 'The example data provided by FIFA is misspecified: the raw data includes frames that are not defined in the data format specification.'
		We have must indeed change the frame counts to respect the bounds delimited in the data format."

	^ ReadStream on: '100:-769,-2013,-500,100,9.63,9.80,4,5,177,182;-461,-615,-120,99,900,9.10,4,5,170,179;-2638,3478,120,110,1.15,5.20,3,4,170,175;:-2656,367,100:
101:-218,1193,2000,100,1.23,3.10,3,3,170,170;1188,1930,1000,100,3.25,3.70,3,3,177,179;-235,-1522,-100,100,2.72,3.20,3,3,180,182;:-521,816,11:'
]

{ #category : 'fixtures' }
STEptsConverterTest >> fifaExampleXml [
	"Answer a format example provided by FIFA and available [here](https://github.com/george-wood/epts/tree/master/inst/extdata)."

	^'<?xml version="1.1" encoding="UTF-8"?>
<tns:FIFADataTransferFormatEPTS
	xmlns:tns="FIFADataTransferFormatEPTSNamespace/FIFADataTransferFormatEPTS"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="FIFADataTransferFormatEPTSNamespace/FIFADataTransferFormatEPTS FIFADataTransferFormatEPTS.xsd ">
	
	<Metadata>
		<GlobalConfig>
			<FileDate>2018-01-22T23:00:00</FileDate>
			<FileName>FIFADataTransferFormatEPTSExample</FileName>
			<TrackingType>GPS</TrackingType>
			<ProviderName>Example</ProviderName>
			<FrameRate>25</FrameRate>
		</GlobalConfig>
		
		<Sessions>
			<Session id="session1">
				<SessionType>Match</SessionType>
				<Start>2018-01-22T21:00:00</Start>
				<End>2018-01-22T22:30:00</End>
				<MatchParameters>
					<Score idLocalTeam="1" idVisitingTeam="2">
						<LocalTeamScore>3</LocalTeamScore>
						<VisitingTeamScore>2</VisitingTeamScore>
					</Score>
				</MatchParameters>
				<Location>Local Team Stadium</Location>
				<Competition>Champions League</Competition>
			</Session>
		</Sessions>
		
		<Teams>
			<Team id="1">
				<Name>Local Team</Name>
			</Team>
			<Team id="2">
				<Name>Visiting Team</Name>
			</Team>
		</Teams>
		
		<Players>
			<Player id="1" teamId="1">
				<Name>Lucas Soares</Name>
				<ShirtNumber>22</ShirtNumber>
				<ProviderPlayerParameters>
					<ProviderParameter>
						<Name>position</Name>
						<Value>Defender</Value>
					</ProviderParameter>
				</ProviderPlayerParameters>
			</Player>
			<Player id="2" teamId="1">
				<Name>Javier Freire</Name>
				<ShirtNumber>10</ShirtNumber>
				<ProviderPlayerParameters>
					<ProviderParameter>
						<Name>position</Name>
						<Value>Midfielder</Value>
					</ProviderParameter>
				</ProviderPlayerParameters>
			</Player>
			<Player id="3" teamId="1">
				<Name>Carlos Alba</Name>
				<ShirtNumber>7</ShirtNumber>
				<ProviderPlayerParameters>
					<ProviderParameter>
						<Name>position</Name>
						<Value>Forward</Value>
					</ProviderParameter>
				</ProviderPlayerParameters>
			</Player>
		</Players>
		
		<Devices>
			<Device id="dev1">
				<Name>Device 1</Name>
				<Sensors>
					<Sensor id="position">
						<Name>Position</Name>
						<Channels>
							<Channel id="x">
								<Name>Position X</Name>
								<Unit>cm</Unit>
							</Channel>
							<Channel id="y">
								<Name>Position Y</Name>
								<Unit>cm</Unit>
							</Channel>
							<Channel id="z">
								<Name>Position Z</Name>
								<Unit>cm</Unit>
							</Channel>
						</Channels>
					</Sensor>
					<Sensor id="distance">
						<Name>Distance</Name>
						<Channels>
							<Channel id="distance">
								<Name>Total distance</Name>
								<Unit>m</Unit>
							</Channel>
						</Channels>
					</Sensor>
					<Sensor id="speed">
						<Name>Speed</Name>
						<Channels>
							<Channel id="avg_speed">
								<Name>Average Speed</Name>
								<Unit>km/h</Unit>
							</Channel>
							<Channel id="max_speed">
								<Name>Maximum Speed</Name>
								<Unit>km/h</Unit>
							</Channel>
						</Channels>
					</Sensor>
					<Sensor id="acceleration">
						<Name>Acceleration</Name>
						<Channels>
							<Channel id="acceleration">
								<Name>Current acceleration</Name>
								<Unit>m/s2</Unit>
							</Channel>
							<Channel id="max_acceleration">
								<Name>Maximum acceleration</Name>
								<Unit>m/s2</Unit>
							</Channel>
						</Channels>
					</Sensor>
					<Sensor id="heartbeat">
						<Name>Heart beat</Name>
						<Channels>
							<Channel id="heartbeat">
								<Name>Current heart beat</Name>
								<Unit>bpm</Unit>
							</Channel>
							<Channel id="max_heartbeat">
								<Name>Maximum heart beat</Name>
								<Unit>bpm</Unit>
							</Channel>
						</Channels>
					</Sensor>
				</Sensors>
			</Device>
		</Devices>
		
		<PlayerChannels>
			<PlayerChannel id="player1_x" playerId="1" channelId="x"></PlayerChannel>
			<PlayerChannel id="player1_y" playerId="1" channelId="y"></PlayerChannel>
			<PlayerChannel id="player1_z" playerId="1" channelId="z"></PlayerChannel>
			<PlayerChannel id="player1_distance" playerId="1" channelId="distance"></PlayerChannel>
			<PlayerChannel id="player1_avg_speed" playerId="1" channelId="avg_speed"></PlayerChannel>
			<PlayerChannel id="player1_max_speed" playerId="1" channelId="max_speed"></PlayerChannel>
			<PlayerChannel id="player1_acceleration" playerId="1" channelId="acceleration"></PlayerChannel>
			<PlayerChannel id="player1_max_acceleration" playerId="1" channelId="max_acceleration"></PlayerChannel>
			<PlayerChannel id="player1_heartbeat" playerId="1" channelId="heartbeat"></PlayerChannel>
			<PlayerChannel id="player1_max_heartbeat" playerId="1" channelId="max_heartbeat"></PlayerChannel>
			<PlayerChannel id="player2_x" playerId="2" channelId="x"></PlayerChannel>
			<PlayerChannel id="player2_y" playerId="2" channelId="y"></PlayerChannel>
			<PlayerChannel id="player2_z" playerId="2" channelId="z"></PlayerChannel>
			<PlayerChannel id="player2_distance" playerId="2" channelId="distance"></PlayerChannel>
			<PlayerChannel id="player2_avg_speed" playerId="2" channelId="avg_speed"></PlayerChannel>
			<PlayerChannel id="player2_max_speed" playerId="2" channelId="max_speed"></PlayerChannel>
			<PlayerChannel id="player2_acceleration" playerId="2" channelId="acceleration"></PlayerChannel>
			<PlayerChannel id="player2_max_acceleration" playerId="2" channelId="max_acceleration"></PlayerChannel>
			<PlayerChannel id="player2_heartbeat" playerId="2" channelId="heartbeat"></PlayerChannel>
			<PlayerChannel id="player2_max_heartbeat" playerId="2" channelId="max_heartbeat"></PlayerChannel>
			<PlayerChannel id="player3_x" playerId="3" channelId="x"></PlayerChannel>
			<PlayerChannel id="player3_y" playerId="3" channelId="y"></PlayerChannel>
			<PlayerChannel id="player3_z" playerId="3" channelId="z"></PlayerChannel>
			<PlayerChannel id="player3_distance" playerId="3" channelId="distance"></PlayerChannel>
			<PlayerChannel id="player3_avg_speed" playerId="3" channelId="avg_speed"></PlayerChannel>
			<PlayerChannel id="player3_max_speed" playerId="3" channelId="max_speed"></PlayerChannel>
			<PlayerChannel id="player3_acceleration" playerId="3" channelId="acceleration"></PlayerChannel>
			<PlayerChannel id="player3_max_acceleration" playerId="3" channelId="max_acceleration"></PlayerChannel>
			<PlayerChannel id="player3_heartbeat" playerId="3" channelId="heartbeat"></PlayerChannel>
			<PlayerChannel id="player3_max_heartbeat" playerId="3" channelId="max_heartbeat"></PlayerChannel>
		</PlayerChannels>
	</Metadata>
	<DataFormatSpecifications>
		<DataFormatSpecification separator=":" startFrame="1" endFrame="15000">
			<StringRegister name="frameCount"/>
			<SplitRegister separator=";">
				<SplitRegister separator=",">
					<PlayerChannelRef playerChannelId="player1_x"/>
					<PlayerChannelRef playerChannelId="player1_y"/>
					<PlayerChannelRef playerChannelId="player1_z"/>
					<PlayerChannelRef playerChannelId="player1_distance"/>
					<PlayerChannelRef playerChannelId="player1_avg_speed"/>
					<PlayerChannelRef playerChannelId="player1_max_speed"/>
					<PlayerChannelRef playerChannelId="player1_acceleration"/>
					<PlayerChannelRef playerChannelId="player1_max_acceleration"/>
					<PlayerChannelRef playerChannelId="player1_heartbeat"/>
					<PlayerChannelRef playerChannelId="player1_max_heartbeat"/>
				</SplitRegister>
				<SplitRegister separator=",">
					<PlayerChannelRef playerChannelId="player2_x"/>
					<PlayerChannelRef playerChannelId="player2_y"/>
					<PlayerChannelRef playerChannelId="player2_z"/>
					<PlayerChannelRef playerChannelId="player2_distance"/>
					<PlayerChannelRef playerChannelId="player2_avg_speed"/>
					<PlayerChannelRef playerChannelId="player2_max_speed"/>
					<PlayerChannelRef playerChannelId="player2_acceleration"/>
					<PlayerChannelRef playerChannelId="player2_max_acceleration"/>
					<PlayerChannelRef playerChannelId="player2_heartbeat"/>
					<PlayerChannelRef playerChannelId="player2_max_heartbeat"/>
				</SplitRegister>
				<SplitRegister separator=",">
					<PlayerChannelRef playerChannelId="player3_x"/>
					<PlayerChannelRef playerChannelId="player3_y"/>
					<PlayerChannelRef playerChannelId="player3_z"/>
					<PlayerChannelRef playerChannelId="player3_distance"/>
					<PlayerChannelRef playerChannelId="player3_avg_speed"/>
					<PlayerChannelRef playerChannelId="player3_max_speed"/>
					<PlayerChannelRef playerChannelId="player3_acceleration"/>
					<PlayerChannelRef playerChannelId="player3_max_acceleration"/>
					<PlayerChannelRef playerChannelId="player3_heartbeat"/>
					<PlayerChannelRef playerChannelId="player3_max_heartbeat"/>
				</SplitRegister>
			</SplitRegister>
			<SplitRegister separator=",">
				<BallChannelRef channelId="x"/>
				<BallChannelRef channelId="y"/>
				<BallChannelRef channelId="z"/>
			</SplitRegister>
		</DataFormatSpecification>
	</DataFormatSpecifications>
</tns:FIFADataTransferFormatEPTS>'
]

{ #category : 'running' }
STEptsConverterTest >> setUp [

	super setUp.

	eptsConverter := STEptsConverter
		                 format: self fifaExampleXml
		                 rawData: self fifaExampleRawData
]

{ #category : 'tests' }
STEptsConverterTest >> testBallIndex [

	eptsConverter splitNextRawLine.
	self assert: eptsConverter ballIndex equals: 3
]

{ #category : 'tests' }
STEptsConverterTest >> testFormatSpecificationNodes [

	self assert: eptsConverter formatSpecificationNodes size equals: 1
]

{ #category : 'tests' }
STEptsConverterTest >> testFrameCountIndex [

	eptsConverter splitNextRawLine.
	self
		assert: (eptsConverter frameCountIndexOf:
				 self fifaExampleFormatSpecificationNode)
		equals: 1
]

{ #category : 'tests' }
STEptsConverterTest >> testPlayerNodes [

	self assert: eptsConverter playerNodes size equals: 3
]

{ #category : 'tests' }
STEptsConverterTest >> testPlayersIndex [

	eptsConverter splitNextRawLine.
	self assert: eptsConverter playersIndex equals: 2
]

{ #category : 'tests' }
STEptsConverterTest >> testSplitting [

	| sublines |
	
	sublines := self fifaExampleRawData nextLine substrings: ':'.
	self assert: sublines size equals: 3.
	self assert: sublines first equals: '100' 
]

{ #category : 'tests' }
STEptsConverterTest >> testTeamNodes [

	self assert: eptsConverter teamNodes size equals: 2
]
