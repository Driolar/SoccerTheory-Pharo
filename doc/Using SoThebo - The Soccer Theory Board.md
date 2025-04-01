# Using SoTheBo - The Soccer Theory Board
## Getting Started
SoTheBo, The Soccer Theory Board, is a Pharo application to visually experiment on the Soccer Theory.
After opening the SoTheBo application, we see the main window consisting of the following parts from top to bottom:
* the window title
* the controls
* the play field
* the legend
* the status bar

The window's size is 1180 x 884 pixel. It is not resizable but maximizable (not recommended).
The play field has a fixed size of 1110 x 720 pixel without the border.
## Setting a soccer scene
A soccer scene consists of a play field with some players and the ball placed on it.

The *play field* is intentionally unadorned.
Neither the center circle nor the penalty boxes are relevant for the Soccer Theory.
The field boundaries, the halfway line and the goals are required.
Each goal is painted with the color of the team defending it.
The represented goal width is proportional to the goal with defined in the world model.

Each *player* is represented by a square colored with the corresponding team color. 
The *ball* is trivially represented by a ball icon.
When moving the mouse onto one of those shapes, the center position of the shape is indicated in world coordinates.
In the case of players, the jersey number is shown additionally.

We can change a soccer scene in many ways.
  ### Loading a scene
  ### Resetting the scene
  ### Choosing a soccer strategy
  ### Moving a player or the ball
  Any player and the ball may be separately moved either by drag and drop or through the arrow keys.

  When dropping a shape on the border outside the play field, it is automatically relocated next on the playfield's border line. 

  To move a shape with the arrow keys, first it must be selected by clicking once on it. 
  A selected player is distiguished by a shadow.
  A thin enclosing rectangle border indicates that the ball is selected.
  Each arrow key step moves by one pixel, what is useful for accurate moving. 
  ### Adding field players
  In order to add a field player to a team, click at the plus sign button having the background color of the concerned team. 
  This will place a new player on the crossing of the halfway line and the upper touchline.
  ### Removing field players
  Removing field players is not implemented yet.
  ### Changing ball possession
## Strategic aspects
Normally, a scene change affect the strategic attributes.
  ### Strategic zones
  ### Player tags
  Each field player may be tagged with one of the following graphical tags:
  * the offside tag, a yellow (linesman) flag indicating that the field player is in offside position.
  * the uncovered tag, an eye (watch out!) indicating that the field player is uncovered.

Both tags cannot apply at the same time for a player, since a player in offside is automatically covered. 
The uncovered tag never applies for the goalkeeper, since by definition defending the own goal covers (absorbs) the goalkeeper.
