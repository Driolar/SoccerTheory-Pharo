# The Soccer Theory Suite
The **Soccer Theory Suite** is a software application suite to visualize the [Theory of Soccer](https://en.wikiversity.org/wiki/The_Theory_of_Soccer).
It is written in Pharo and is inspired by a [former master thesis implemented in Java](https://github.com/Driolar/SoccerTheory-Java).
There is some [user documentation](https://github.com/Driolar/SoccerTheory-Pharo/tree/master/doc) written for you.

The suite consists of two applications:
- With **SoTheBoard**, you can edit a single soccer scene (frame) on a two-dimensional play field.
- With **SoTheReplay**, you can replay a sequence of soccer scene frames on a two-dimensional play field.

## Load the Soccer Theory Suite
You can load the Soccer Theory Suite into a fresh Pharo image (version 11 or newer) with:
```smalltalk
Metacello new
        baseline: 'SoccerTheory';
        repository: 'github://Driolar/SoccerTheory-Pharo:master/src';
        load
```
You can replace master by v1.3 to load the latest released version.

## Start SoTheBoard
Do `STFrameEditor open` to launch the starting window:<img width="1177" height="883" alt="Bild_2025-08-17_111051885" src="https://github.com/user-attachments/assets/54eb6459-fa70-4528-95d3-016ba399a0fc" />
This is the [Bloc](https://github.com/pharo-graphics/Bloc) based version. In order to start the [Roassal](https://github.com/pharo-graphics/Roassal) based version, do `STFrameEditor openRoassal`.

## Start SoTheReplay
Do `STSequencePlayer open` to launch the starting window:<img width="1176" height="883" alt="Bild_2025-08-17_111233476" src="https://github.com/user-attachments/assets/17ef986f-ba32-4dd8-a458-4fbd23e61055" />






