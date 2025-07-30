# Using SoThePlayer - The Soccer Theory Player
## Getting Started
SoThePlayer, The Soccer Theory Player, is a Pharo application to visually experiment with the Soccer Theory by replaying sequences of soccer scene frames on a two-dimensional play field.
It belongs to the [Soccer Theory Suite](https://github.com/Driolar/SoccerTheory-Pharo?tab=readme-ov-file#readme).
After opening the SoThePlayer application, we see the main window consisting of the following parts from top to bottom:
* the window title
* the controls
* the play field
* the legend
* the status bar

The main window with size 1180 x 884 pixel is not resizable.
The play field has a fixed size of 1110 x 720 pixel without the border.

## Loading a frame sequence
The button "Open..." opens a modal window to select a *SoccerML* file with extension .socxml for loading without validation.
You previously may have downloaded some [SoccerML frame sequence examples](https://github.com/Driolar/SoccerTheory-Pharo/tree/master/socxml/frame_sequence). 
After loading, the first frame is rendered and the file name and the total number of frames is indicated on the status bar.

## Replaying a sequence of frames
You can *start* replaying the sequence by clicking at the play button <img width="19" height="18" alt="Bild_2025-07-30_152441958" src="https://github.com/user-attachments/assets/907120db-cec2-485b-ba42-9db17b81041c" />.
You can *stop* replaying the sequence by clicking at the stop button <img width="23" height="21" alt="Bild_2025-07-30_152604398" src="https://github.com/user-attachments/assets/fd8ea49c-510f-448c-bbae-a019432c7407" />.

## The current frame
The frames are always numbered from 1 to the total number of loaded frames.
You can set the current starting frame index in the number input field labeled *frame#*.
This field is automatically updated/incremented while a sequence is being replayed.

You can *(re)load* the frame with the current frame index by clicking at the refresh button <img width="27" height="23" alt="Bild_2025-07-30_154456374" src="https://github.com/user-attachments/assets/bfafe850-bf61-4763-80e9-66ae3152009f" />.
With the back button <img width="26" height="20" alt="Bild_2025-07-30_154705846" src="https://github.com/user-attachments/assets/9dbbbe7b-f920-43ac-8d88-c7918cb37699" />, you can set the current starting frame to the last replaying's starting frame.

On the current static frame, you can move every player and the ball like you can do in [SoTheBoard](https://github.com/Driolar/SoccerTheory-Pharo/blob/master/doc/Using%20SoTheBoard%20-%20The%20Soccer%20Theory%20Board.md). 
