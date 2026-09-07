# Bocchi Rhythm — Development Log

## Day 3 — Game Flow and UI/UX

### Objective

Transform the working rhythm engine into a complete playable game loop
with song selection, difficulty selection, gameplay lifecycle,
pause handling, song completion, and results.

### UI/UX Design

Created low-fidelity wireframes in Figma for:

- Main Menu
- Song Select
- Difficulty Select
- Gameplay
- Pause Menu
- Results Screen

The wireframes were created at the current game resolution:

1152 × 648

Visual theming remains intentionally minimal while core functionality
is still being developed.

### Completed Systems

- Added GameSession global state using Godot Autoload.
- Added external song metadata JSON.
- Implemented Song Select scene.
- Implemented Difficulty Select scene.
- Added difficulty availability handling.
- Added navigation from Song Select to Difficulty Select.
- Added navigation from Difficulty Select to Gameplay.
- Removed hardcoded gameplay audio selection.
- Removed hardcoded gameplay chart selection.
- Connected selected song metadata to AudioManager.
- Connected selected difficulty chart to ChartManager.
- Added GameplayManager.
- Implemented song completion detection.
- Transferred gameplay results into GameSession.
- Implemented Results scene.
- Added result judgement counts.
- Added final score display.
- Added maximum combo display.
- Added grade calculation.
- Implemented Retry.
- Implemented return to Song Select.
- Added PauseManager.
- Added ESC pause input.
- Implemented Resume.
- Implemented Restart.
- Implemented return to Song Select from Pause.
- Paused music and gameplay processing correctly.
- Centered and cleaned the pause menu layout.
- Resolved stale resource UID warnings.

### Current Game Flow

Song Select
→ Difficulty Select
→ Gameplay
→ Results
→ Retry or Song Select

Gameplay also supports:

Gameplay
→ Pause
→ Resume / Restart / Song Select

### GameSession Data

The global GameSession currently stores:

- Selected song ID
- Selected song title
- Selected artist
- Selected audio path
- Available difficulties
- Selected difficulty
- Selected chart path
- Final score
- Maximum combo
- PERFECT count
- GREAT count
- GOOD count
- MISS count

### Song Data Architecture

Song metadata:

data/songs/test_song.json

Chart data:

data/charts/test_song.json

Song metadata references the audio file and available difficulty charts.

This separates song configuration from gameplay code.

### Results System

Results currently display:

- PERFECT count
- GREAT count
- GOOD count
- MISS count
- Maximum combo
- Final score
- Grade

Current grade thresholds:

- S: 95%+
- A: 85%+
- B: 70%+
- C: 55%+
- D: below 55%

### Issues Encountered

- Song metadata path initially contained an incorrect filename.
- Chart JSON was accidentally deleted and recreated.
- Chart folder was initially nested inside the songs folder.
- NoteSpawner received an empty chart due to missing chart data.
- Results scene initially contained invalid .tscn content.
- Song completion initially failed to transition to Results.
- Added GameplayManager and AudioStreamPlayer finished handling.
- Gameplay scenes run directly without GameSession data produced
  missing audio/chart errors.
- PauseManager initially contained a stale script UID.
- Reattached and cleaned the pause script reference.

### Day 3 Result

Status: COMPLETE

The project now contains a complete playable game-session loop.

The player can:

1. Select a song.
2. Select a difficulty.
3. Start gameplay.
4. Pause, resume, or restart.
5. Complete the song.
6. View results.
7. Retry or return to song selection.

### Next — Day 4

- Main Menu implementation
- Multiple song support
- Song list architecture
- Difficulty-specific chart files
- Better gameplay session reset handling
- Song information in gameplay
- UI refinement
- Begin visual identity / Bocchi-themed styling