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
You can replace master by v1.1 to load the latest released version.

## Start SoTheBoard
Do *STFrameEditor open* to launch the starting window:<img width="1172" height="880" alt="Bild_2025-07-21_142319669" src="https://github.com/user-attachments/assets/87bf847c-3f98-46d1-adab-47703e85e119" />

## Start SoTheReplay
Do *STSequencePlayer open* to launch the starting window:<img width="1171" height="882" alt="Bild_2025-07-30_144839748" src="https://github.com/user-attachments/assets/0fda3668-28b0-4fd0-acac-7e7307e771ba" />




