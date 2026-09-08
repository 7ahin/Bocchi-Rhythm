# Bocchi Rhythm — Development Log

## Day 4 — Multi-Song Architecture and Visual Foundation

### Objective

Expand Bocchi Rhythm from a single-song prototype into a scalable
multi-song rhythm game structure while establishing the first consistent
visual identity for the project.

### Completed Systems

- Implemented Main Menu navigation.
- Added dynamic SongLibrary Autoload.
- Added automatic song metadata discovery from `data/songs/`.
- Implemented multiple-song support.
- Added Previous and Next navigation in Song Select.
- Added return navigation from Song Select to Main Menu.
- Implemented independent chart files for multiple songs.
- Added Easy, Normal, and Hard difficulty support.
- Added separate chart files per difficulty.
- Updated Difficulty Select to enable available difficulties dynamically.
- Added GameSession lifecycle reset functions.
- Prevented stale song, chart, difficulty, and result data between sessions.
- Added gameplay song title display.
- Added gameplay difficulty display.

### GameSession Lifecycle

Added:

- `reset_results()`
- `reset_difficulty()`
- `reset_session()`

Session state is now reset appropriately when:

- Starting a new song.
- Selecting a new song.
- Starting gameplay.
- Retrying a song.
- Restarting from Pause.
- Returning to Song Select.
- Returning from Results.

Retry and Restart preserve the currently selected song and difficulty.

### Multi-Song Architecture

Song metadata is stored under:

`res://data/songs/`

Chart files are stored under:

`res://data/charts/`

SongLibrary automatically scans song metadata JSON files.

Current structure supports:

Song
→ Available Difficulties
→ Difficulty-specific Chart
→ Gameplay

Adding new songs no longer requires hardcoding a metadata path inside
Song Select.

### Difficulty System

Current difficulty colors:

- EASY — Cyan
- NORMAL — Yellow
- HARD — Pink

Each difficulty may reference an independent chart.

The selected difficulty is stored in GameSession and displayed during
gameplay.

### Base UI Refinement

Updated layouts for:

- Main Menu
- Song Select
- Difficulty Select
- Gameplay HUD
- Pause Menu
- Results Screen

Created consistent:

- Content widths
- Button dimensions
- Spacing
- Typography hierarchy
- Primary and secondary actions

### Visual Identity Foundation

Established the first Bocchi Rhythm base palette.

Background:
`#17171F`

Surface:
`#24242F`

Surface Hover:
`#30303D`

Primary Pink:
`#F29BC2`

Pink Hover:
`#F6B2CF`

Pink Pressed:
`#D982AC`

Primary Text:
`#F7F7FA`

Secondary Text:
`#B8B8C4`

Easy:
`#71D5E4`

Normal:
`#F2D45C`

Hard:
`#F29BC2`

The current default visual identity uses Bocchi-inspired pink as the
primary accent.

Future character themes may reuse the same design system with different
accent colors.

### Button Design System

Primary actions include:

- PLAY
- SELECT
- RETRY
- RESUME

Primary buttons use the pink accent.

Secondary actions include:

- SETTINGS
- EXIT
- BACK
- PREVIOUS
- NEXT
- RESTART
- SONG SELECT

Secondary buttons use the dark surface style.

Button states now include:

- Normal
- Hover
- Pressed
- Disabled

### Gameplay Visual Update

Gameplay now uses:

- Dark background.
- Dark lane surfaces.
- Pink judgement line.
- Pink song-title accent.
- Difficulty information in HUD.
- White gameplay notes.

Gameplay styling remains intentionally simple while the rhythm engine
continues to mature.

### Pause Menu

Added and refined:

- Full-screen dim background.
- Centered pause menu.
- RESUME primary action.
- RESTART secondary action.
- SONG SELECT secondary action.

### Results Screen

Results screen now follows the same visual language.

Displays:

- Grade
- PERFECT
- GREAT
- GOOD
- MISS
- Maximum Combo
- Score
- Retry
- Song Select

### Character Theme Planning

Future accent themes are planned around:

- Bocchi — Pink
- Nijika — Yellow
- Ryo — Blue
- Kita — Red

Only the Bocchi default accent is implemented during Day 4.

Character theme switching is intentionally postponed until the base UI
system is stable.

### Smoke Test

Full game flow tested:

Main Menu
→ Song Select
→ Song Navigation
→ Difficulty Select
→ Easy / Normal / Hard
→ Gameplay
→ Pause
→ Resume
→ Restart
→ Song Completion
→ Results
→ Retry
→ Song Select

Verified:

- Song selection
- Difficulty selection
- Chart switching
- Audio playback
- Scoring
- Combo
- Judgements
- Pause and Resume
- Restart
- Results transfer
- Retry
- Session reset
- Navigation
- UI styling

### Day 4 Result

Status: COMPLETE

Bocchi Rhythm now has a scalable multi-song and multi-difficulty
architecture, a stable session lifecycle, and its first consistent visual
design system.

### Next — Day 5

Potential Day 5 work:

- Create reusable Godot Theme resources.
- Reduce duplicated per-button styling.
- Character theme architecture.
- Improved Song Select presentation.
- Album artwork support.
- Difficulty metadata such as level numbers.
- Gameplay feedback polish.
- Note-hit effects.
- Menu transitions.
- Audio feedback for UI interactions.