"
I am the defence line (offside line).

My position depends on the concrete offside rule.
I don't exist if the game is played without offside rule.
I take the color of the defending team.
If ball possession is neutral, my color is also neutral.

I am a boundary of the defence zone, a rectangle that can be entered by the attacker taking the ball but not by the rest of attackers.
The defence zone boundaries are: both pitch side lines, the defending team's goal line and me (the offside line).
"
Class {
	#name : 'STBlocOffsideLineShape',
	#superclass : 'STBlocStrategicLineShape',
	#category : 'SoccerTheory-Graphics-Bloc',
	#package : 'SoccerTheory-Graphics',
	#tag : 'Bloc'
}

{ #category : 'private' }
STBlocOffsideLineShape >> newBottomEndPoint [
	"Answer the BlElement that decorates the top segment end."

	^self newEndPointCirclePrototype 
]

{ #category : 'private' }
STBlocOffsideLineShape >> newTopEndPoint [
	"Answer the BlElement that decorates the top segment end."

	^self newEndPointCirclePrototype 
]
