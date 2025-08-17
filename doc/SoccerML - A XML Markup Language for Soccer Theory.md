# SoccerML - A XML Markup Language for Soccer Theory.
SoccerML is a XML markup language to provide tracking and event soccer data for investigating the [Soccer Theory](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/doc/A%20bit%20of%20Soccer%20Theory.md). 
By convention, a SoccerML file should have the extension *.socxml*. 
Basically, the data consists of header information and a sequence of frames. 
The format is defined by the document type definition file [soccerML.dtd](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/socxml/soccerML.dtd).
## Converting from other formats
### RoboCup
There is a [RoboCup Tool](https://github.com/rcsoccersim/rcsslogplayer/tree/master/tool) that converts RoboCup log files from the 2D Simulation League to XML files defined by a [XSD file](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/rcg2xml/rcg-0.1.xsd).
In order to further transform such XML files into SoccerML, we pipeline two transformation sheets [rcg2soc_1of2.xsl](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/rcg2xml/rcg2soc_1of2.xsl) and [rcg2soc_2of2.xsl](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/rcg2xml/rcg2soc_2of2.xsl).
This procedure was succesfully employed in a [master thesis](https://github.com/Driolar/SoccerTheory-Java) about the Soccer Theory.

However, the indicated RoboCup Tool is in the meantime deprecated.
Most recent efforts are dedicated to [convert RoboCup logs into CSV](https://github.com/hidehisaakiyama/RoboCup2D-data). 
### Metrica Sports
A conversion from [Metrica Sports](https://github.com/metrica-sports/sample-data) to SoccerML is planned to be written in Pharo.
### Skillcorner
A conversion from [Skillcorner](https://github.com/SkillCorner/opendata) to SoccerML is planned to be written in Pharo.
