# Using SoThePlayer - The Soccer Theory Player
## Getting Started
SoThePlayer, The Soccer Theory Player, is a Pharo application to visually experiment with the Soccer Theory.
It belongs to the [Soccer Theory Suite](https://github.com/Driolar/SoccerTheory-Pharo#).
After opening the SoThePlayer application, we see the main window consisting of the following parts from top to bottom:
* the window title
* the controls
* the play field
* the legend
* the status bar

The main window with size 1180 x 884 pixel is not resizable.
The play field has a fixed size of 1110 x 720 pixel without the border.

### Loading a frame sequence
  The button "Open..." opens a modal window to select a *SoccerML* file with extension .socxml for loading without validation.
  You can download some [SoccerML frame sequence examples](https://github.com/Driolar/SoccerTheory-Pharo/tree/master/socxml/frame_sequence). 
  After loading, the file name and number of frames is indicated on the status bar.
