# Technical Design

## Engine
Godot 4

## Input
lane_1 = A
lane_2 = S
lane_3 = D
lane_4 = F

## Current Scenes
MainMenu.tscn
Gameplay.tscn
Note.tscn

## Current Scripts
input_test.gd
note.gd

## Planned Rhythm Architecture
AudioManager
ChartManager
NoteSpawner
Note
JudgementManager
ScoreManager
UIManager

## Chart Concept
Each note will contain:
- timestamp
- lane

Example:
time = 2.500
lane = 3