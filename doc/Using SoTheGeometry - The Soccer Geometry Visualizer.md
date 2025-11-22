# Using SoTheGeometry - The Soccer Geometry Visualizer
**SoTheGeometry** is the same application as [SoTheBoard](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/doc/Using%20SoTheBoard%20-%20The%20Soccer%20Theory%20Board.md) but enhanced with some soccer geometry layers. 
Each layer can be displayed or hidden with one of the following toggle buttons:

<img width="113" height="24" alt="image" src="https://github.com/user-attachments/assets/713313d9-56f9-4a23-999c-66ec0ded0e79" />

The layers are (from left to right): 
- Individual coverage
- shooting angle
- goal path and
- team spanning tree.

Among the first three layers, at most one layer is rendered at once.

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

## Shooting Angle Layer
For the attacking player with the greatest shooting angle, the layer shows the shooting (tri)angle and the circumference where the shooting angle is equal.

The triangle's vertices are the two goalposts and the player's position.
The larger the angle, the better the chance of a score.
The triangle is labelled with the shooting angle in degrees.

The circumference passes through the two goalposts and the player's position.
Outside the rendered circle, the shooting angle is smaller. Inside the circle, the shooting angle is greater.

Each player's hover text contains her shooting angle value.

## Goal Path Layer
Not implemented yet.

## Team Spanning Layer
The players of a team are connected by a minimum spanning tree with dashed lines.
This gives an approach of connectivity, specially of pass opportunities.
The team spanning layer is rendered for the attacking team.
In case of neutral ball, both spanning trees are rendered.
