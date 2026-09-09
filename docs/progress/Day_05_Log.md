# Bocchi Rhythm — Development Log

## Day 5 — Reusable Theme, Feedback and UI Systems

### Objective

Refactor Bocchi Rhythm's UI into a reusable theme system and improve
player feedback through animations, scene transitions, and UI audio.

### Reusable Theme System

Created:

`res://themes/bocchi_theme.tres`

The project now uses a shared Godot Theme instead of configuring every
button independently.

Default Button style is used for secondary actions such as:

- SETTINGS
- EXIT
- BACK
- PREVIOUS
- NEXT
- RESTART
- SONG SELECT

### Primary Button Variation

Created the custom Theme Type Variation:

`PrimaryButton`

Used by:

- PLAY
- SELECT
- RETRY
- RESUME

Primary buttons use the Bocchi pink accent.

States include:

- Normal
- Hover
- Pressed
- Disabled

This removes duplicated local Theme Overrides from primary buttons.

### Difficulty Button Variations

Created:

- `EasyDifficultyButton`
- `NormalDifficultyButton`
- `HardDifficultyButton`

Selected colors:

- EASY — Cyan
- NORMAL — Yellow
- HARD — Pink

Difficulty buttons use Toggle Mode and a shared ButtonGroup.

Only one difficulty can remain selected at a time.

Hover-Pressed styling was also configured so selected difficulty text
remains readable while hovered.

### Gameplay Feedback

Improved judgement feedback.

Judgement colors:

- PERFECT — Yellow
- GREAT — Cyan
- GOOD — Pink
- MISS — Red

Judgement text now uses a short pop animation instead of fading.

Fade animation was intentionally avoided because previous testing caused
visual ghosting artifacts.

### Note Feedback

Successful note hits now:

- Stop note movement.
- Change to pink.
- Expand briefly.
- Disappear.

Missed notes now:

- Change to red.
- Shrink briefly.
- Disappear.

These animations are visual only and do not modify judgement timing.

### Combo Feedback

Added a small scale animation when combo increases.

MISS continues to reset the combo normally.

### Scene Transition System

Created:

`res://scripts/core/scene_transition.gd`

Added as Autoload:

`SceneTransition`

Major scene changes now use reusable fade transitions.

Current transition flow includes:

- Main Menu → Song Select
- Song Select → Difficulty Select
- Difficulty Select → Gameplay
- Gameplay → Results
- Results → Retry
- Results → Song Select
- Difficulty Select → Song Select

Transition input is blocked while a transition is active to prevent
duplicate scene changes.

### Difficulty Back Navigation

Fixed the Difficulty Select BACK button.

The button now:

- Connects correctly in `difficulty_select.gd`.
- Clears selected difficulty/chart state.
- Returns to Song Select.
- Uses SceneTransition.

### Global UI Audio Manager

Created:

`res://scripts/core/ui_audio_manager.gd`

Added as Autoload:

`UIAudioManager`

The manager automatically detects Button nodes and connects:

- Hover sound
- Click sound

UI audio files:

`res://assets/audio/ui/ui_hover.wav`

`res://assets/audio/ui/ui_click.wav`

Disabled buttons do not play hover sounds.

UI audio volumes are reduced relative to gameplay audio to avoid
overpowering the interface.

### UI Audio Architecture

Buttons no longer need individual audio scripts.

UIAudioManager automatically detects buttons when scenes and nodes are
created.

This applies to:

- Main Menu
- Song Select
- Difficulty Select
- Pause Menu
- Results

### Current Core Architecture

The project now contains reusable global systems for:

- GameSession
- SongLibrary
- SceneTransition
- UIAudioManager
- Global UI Theme
- Rhythm Engine
- Judgement System
- Score System

### Smoke Test

Full game flow tested successfully:

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

- Primary and secondary theme inheritance
- Difficulty theme variations
- Hover-Pressed states
- UI hover audio
- UI click audio
- Disabled button handling
- Scene transitions
- Multi-song switching
- Multi-difficulty charts
- Gameplay timing
- Score
- Combo
- Judgements
- Judgement animation
- Note hit animation
- Miss animation
- Pause and Resume
- Restart
- Results
- Retry
- Session lifecycle

### Day 5 Result

Status: COMPLETE

Bocchi Rhythm now has a reusable UI architecture, global theme system,
visual gameplay feedback, scene transitions, and automatic UI audio
feedback.

The project is increasingly structured around reusable systems rather
than per-scene duplicated configuration.

### Next — Day 6

Potential Day 6 work:

- Character theme architecture
  - Bocchi — Pink
  - Nijika — Yellow
  - Ryo — Blue
  - Kita — Red
- Theme selection UI
- Save selected theme
- Improved Song Select presentation
- Album artwork support
- Song metadata such as BPM and difficulty level
- Gameplay visual refinement
- Additional menu animations