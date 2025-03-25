"
I am the attack line (ball crossing line).

I run at ball's level in parallel to the goal lines.
I take the color of the attacking team.
If ball possession is neutral, my color is also neutral.

I am a boundary of the active zone, a rectangle where it is specially important to observe the covering relations.
The active zone boundaries are: both side lines, the defending team's goal line and me.
"
Class {
	#name : 'STAttackLineShape',
	#superclass : 'STStrategicLineShape',
	#category : 'SoccerTheory-Rendering-Basic',
	#package : 'SoccerTheory-Rendering',
	#tag : 'Basic'
}

{ #category : 'private' }
STAttackLineShape >> borderBuilder [
	"Answer my border builder."

	^ super borderBuilder dashed
]
