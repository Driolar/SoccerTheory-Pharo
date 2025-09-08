# SoccerML - A XML Markup Language for Soccer Theory
SoccerML is a XML markup language to provide tracking and event soccer data for investigating the [Soccer Theory](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/doc/A%20bit%20of%20Soccer%20Theory.md). 
By convention, a SoccerML file should have the extension *.socxml*. 
Basically, the data consists of header information and one or more frame sequences. 
The format is defined by the document type definition file [soccerML.dtd](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/socxml/soccerML.dtd).

The applications [SoTheBoard](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/doc/Using%20SoTheBoard%20-%20The%20Soccer%20Theory%20Board.md) and [SoTheReplay](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/doc/Using%20SoTheReplay%20-%20The%20Soccer%20Theory%20Player.md) can read and write SoccerML.
## Converting from other formats
### RoboCup
There is a [RoboCup Tool](https://github.com/rcsoccersim/rcsslogplayer/tree/master/tool) that converts RoboCup log files from the 2D Simulation League to XML files defined by this [XSD file](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/rcg2xml/rcg-0.1.xsd).
In order to further transform such XML files into SoccerML, we pipeline two transformation sheets [rcg2soc_1of2.xsl](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/rcg2xml/rcg2soc_1of2.xsl) and [rcg2soc_2of2.xsl](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/rcg2xml/rcg2soc_2of2.xsl).
This procedure was succesfully employed in a [master thesis](https://github.com/Driolar/SoccerTheory-Java) about the Soccer Theory.

However, the indicated RoboCup Tool is in the meantime deprecated.
Most recent efforts are dedicated to [convert RoboCup logs into CSV](https://github.com/hidehisaakiyama/RoboCup2D-data). 
### FIFA's EPTS
The *Fédération Internationale de Football Association* (FIFA) develops a global standard for tracking and event soccer data named [EPTS](https://inside.fifa.com/innovation/standards/epts/research-development-epts-standard-data-format) (Electronic Performance and Tracking Systems). A EPTS data set for a match consists of three files: 
- the rawdata file in text format
- the metadata file in xml format
- the events file in json format. 

The Soccer Theory Suite provides the class `STEptsConverter` for converting EPTS into SoccerML. 
Currently, the events file from where ball possession information might be inferred is not considered by `STEptsConverter`.

`STEptsConverter` takes care of field switching at half time. For each half time, a separate sequence of frames is created.

Note that the raw data might contain frames with missing ball position (NaN). Such frames are skipped by `STEptsConverter`.
#### Example using `STEptsConverter`
There is an example of a real soccer match provided by Metrica Sports as [Sample Game 3](https://github.com/metrica-sports/sample-data/tree/master/data/Sample_Game_3).
To use `STEptsConverter` with this match example, download the files [Sample_Game_3_metadata.xml](https://github.com/metrica-sports/sample-data/blob/master/data/Sample_Game_3/Sample_Game_3_metadata.xml) and [Sample_Game_3_tracking.txt](https://github.com/metrica-sports/sample-data/blob/master/data/Sample_Game_3/Sample_Game_3_tracking.txt).

You might want to partition the big raw data file. For example, to save 100 frames beginning at frame count 700, do this:
```
| converter |
converter := STEptsConverter
	             metadataFileNamed:
	             'C:\temp\Sample_Game_3_metadata.xml'
	             rawDataFileNamed:
	             'C:\temp\Sample_Game_3_tracking.txt'.
converter copyRawDataStartingAtFrameCount: 700 numberOfFrames: 100 asFileNamed: 'c:\temp\100startingAt700.txt'
```

Subsequently, you can convert the copied EPTS raw data portion to SoccerML doing this:
```
| converter |
converter := STEptsConverter
	             metadataFileNamed:
	             'C:\temp\Sample_Game_3_metadata.xml'
	             rawDataFileNamed:
	             'C:\temp\100startingAt700.txt'.
converter writeWholeDocumentToFileNamed: 'c:\temp\100startingAt700.socxml'.
```
To obtain an example with both half times, copy for instance 650 frames starting at frame count 69542.  

### Skillcorner
A conversion from [Skillcorner](https://github.com/SkillCorner/opendata) to SoccerML is planned to be provided by the Soccer Theory Suite.
