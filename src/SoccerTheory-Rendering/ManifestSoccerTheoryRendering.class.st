"
I am the rendering layer between application and model.

The application visualizes the soccer game model through my class STSoccerScene.
The elementar model classes (player, ball) are represented by my corresponding proxy classes with visual attributes. 
The concrete representations can vary by means of my possible graphic factories.

Furthermore, I also handle the coordinate transformations between world and device.
"
Class {
	#name : 'ManifestSoccerTheoryRendering',
	#superclass : 'PackageManifest',
	#category : 'SoccerTheory-Rendering-Manifest',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Manifest'
}
