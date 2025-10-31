# Using SoTheGeometry - The Soccer Geometry Visualizer
**SoTheGeometry** is the same application as [SoTheBoard](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/doc/Using%20SoTheBoard%20-%20The%20Soccer%20Theory%20Board.md) but enhanced with some soccer geometry layers. 
Each layer can be displayed or hidden with one of the following toggle buttons:

<img width="92" height="30" alt="image" src="https://github.com/user-attachments/assets/faf61556-aa74-4a9d-a52f-a22045bfb7cf" />
 
At most one layer is rendered at once.

## Individual Coverage Layer
In the soccer game, the defending team must be sure that no opponent is ever free. 
If an opponent is free and gets the ball, he can advance without hindrance: The defence is unstable. 
The Individual Coverage solution is to assign an opponent to each player of the defending team. 
Each covering player orients his position towards his opponent in order to guarantee that, if his opponent gets the ball, he can hinder him before he can either score or destabilise the defence.

The individual coverage layer shows independent line segments each connecting one player to an opponent player in a preferable way.
The line color is the team color of the defending team or a mixed color if no team is possessing the ball.
Each defending player is oriented directly towards his opponent in coincidence with the pairing line.
For each line segment, the opponents distance in meters is shown by a hover text.

A goalkeeper is never connected since he must "cover" by definition his own goal.
Neither a player in offside is ever connected, since he is covered by the offside rule.
The line segment is dashed in case that the defending player is more advanced than his assigned opponent, denoting that he is misplaced for an effective defence. 

In a first rudimentary approach, the pair connections are calculated by minimizing the sum of the distances.
This could certainly be refined, e.g. by weighting how dangerous is the position of each attacker.
The algorithm currently used to calculate the minimum distance sum does not always find the optimal solution but deviates at most to the double.


## Shot Angle Layer
Not implemented yet.

## Goal Path Layer
Not implemented yet.

