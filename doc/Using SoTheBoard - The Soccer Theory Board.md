# Using SoTheBoard - The Soccer Theory Board
## Getting Started
**SoTheBoard**, The Soccer Theory Board, is a Pharo application to visually experiment with the Soccer Theory by editing single soccer scenes (frames) on a two-dimensional play field.
SoTheBoard belongs to the [Soccer Theory Suite](https://github.com/Driolar/SoccerTheory-Pharo?tab=readme-ov-file#readme).
After opening the SoTheBoard application, we see the main window consisting of the following parts from top to bottom:
* the window title
* the controls
* the play field
* the legend
* the status bar

The main window with size 1180 x 884 pixel is not resizable.
The play field has a fixed size of 1110 x 720 pixel without the border.
## Arranging a soccer scene
Basically, a soccer scene consists of a two-dimensional play field with some players and the ball placed on it.

The *play field* is intentionally unadorned.
Neither the center circle nor the penalty boxes are relevant for the Soccer Theory.
The field boundaries, the halfway line and the goals are required.
Each goal is painted with the color of the team defending it.
The represented goal width is proportional to the goal width defined in the world model.

Each *player* is represented by a square colored with the corresponding team color.
The goalkeeper is denoted with a person raising the arms.
The *ball* is trivially represented by a ball icon.
When moving the mouse onto one of these shapes, the center position of the shape is indicated in world coordinates.
In the case of players, the jersey number is shown additionally.

We can arrange a soccer scene in many ways.
  ### Loading a scene
  The button "Open..." opens a modal window to select a *SoccerML* file with extension .socxml for loading under validation.
  You previously may have downloaded some [SoccerML file examples](https://github.com/Driolar/SoccerTheory-Pharo/tree/master/socxml). 
  If the file contains more than one frame, only the first frame will be displayed.
  To view all the frames, please use the [SoThePlayer](https://github.com/Driolar/SoccerTheory-Pharo/blob/414a0d659215ae9f42aa6e7b92f2e8bebea182bd/doc/Using%20SoThePlayer%20-%20The%20Soccer%20Theory%20Player.md) application.
  
  Furthermore, the button "Examples" offers some trivial test scenes built-in for straightforward load.
  ### Resetting the scene
  Pushing the reset button erases the current scene and restablishes the initial scene: two goalkeepers in front of their respective goal and the neutral ball placed at the center spot.
  ### Choosing an offside rule
  You can choose the offside rule you might experiment with (ancient, classic, modern or no offside rule) from a drop down list.
  ### Moving a player or the ball
  Any player and the ball may be separately moved either by drag and drop or through the arrow keys.

  To move a shape with the *arrow keys*, first it must be selected by clicking once on it. 
  A selected player is distiguished by a shadow.
  A thin enclosing rectangle border indicates that the ball is selected.
  Each arrow key step moves by one pixel, what is useful for accurate moving. 

  The arrow steps are limited by the play field boundaries.
  When *dropping* a shape on the border outside the play field, it is automatically relocated nearest on the playfield's border line. 
  ### Adding field players
  In order to add a field player to a team, click at the plus sign button having the background color of the concerned team. 
  This will place a new player on the crossing of the halfway line and the upper touchline ready to be further moved.
  ### Removing field players
  Removing field players is not implemented yet.
  ### Changing ball possession
  The ball possession can be changed by clicking one of the buttons "Ball team left", "Ball team right" or "Ball neutral".
  If the ball is not neutral, it has the background color of the team possessing the ball.
## Strategic aspects
Normally, a change on the scene affects the following strategic attributes.
  ### Strategic lines
  There are two strategic lines shown on the scene: the offside line and the attack line.

  The *offside line* is represented by a line segment parallel to the goal lines with circles at its ends and coloured like the defending team. 
  It is a boundary of the offiside zone, a rectangle that can be entered by the attacker taking the ball but not by the rest of attackers. 
  The offside zone boundaries are: both side lines, the defending team's goal line and the offside line.
  The position of the offside line is determined by the position of the ball or of some specific defender, depending on the offside rule that applies.

  The *attack line* is represented by a dashed line segment coloured like the attacking team with triangles at its ends pointing into the attack direction. 
  It is at ball's level in parallel to the goal lines. 
  It is a boundary of the active zone, a rectangle where it is specially important to observe the covering relations.
  The active zone boundaries are: both side lines, the defending team's goal line and the attack line.

  Sometimes, the offside zone and the attack zone may completely coincide. 
  This is the case when the offside line is determined by the ball position.
  ### Player tags
  Each field player may be tagged with one of the following graphical tags:
  * the offside tag, a yellow (linesman) flag indicating that the player is in offside position.
  * the uncovered tag, an eye (watch out!) indicating that the field player is uncovered.

Both tags cannot apply at the same time for a player, since a player in offside is automatically covered. 
The uncovered tag never applies for the goalkeeper, since by definition defending the own goal covers (absorbs) the goalkeeper.
