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
  ### Adding players
  ### Removing players
  Removing players is not implemented yet.
  ### Changing ball possession
## Strategic aspects
  ### The play field
  The play field is intentionally unadorned.
  Neither the center circle nor the penalty boxes are relevant for the Soccer Theory.
  The field boundaries, the middle line and the goals are required.
  Each goal is painted with the color of the team defending it.
  The goal width is proportional to the goal size from the world model.
  ### Strategic zones
  ### Player tags
  Each player may be tagged with one of the following graphical tags:
  * the offside tag, a yellow (linesman) flag indicating that the player is in offside position.
  * the uncovered tag, an eye (watch out!) indicating that the player is uncovered.

Both tags cannot apply at the same time for a player, since a player in offside is automatically covered.
