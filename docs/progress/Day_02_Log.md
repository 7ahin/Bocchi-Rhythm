# Bocchi Rhythm — Development Log

## Day 2 — Core Rhythm Engine

### Objective

Develop the core rhythm-game engine and transition the prototype
from manually placed notes into an audio-synchronized,
chart-driven gameplay system.

### Completed

- Implemented automatic NoteSpawner.
- Validated random note spawning across four lanes.
- Replaced random spawning with deterministic chart-driven spawning.
- Added AudioManager and AudioStreamPlayer.
- Implemented music playback.
- Implemented song clock based on audio playback position.
- Synchronized note movement with the audio clock.
- Converted chart timestamps into target hit times.
- Implemented timing judgement windows:
  - PERFECT
  - GREAT
  - GOOD
  - MISS
- Implemented automatic miss detection.
- Implemented ScoreManager.
- Implemented combo and maximum combo tracking.
- Added live score and combo HUD.
- Added on-screen judgement feedback.
- Reworked gameplay layout into a centered responsive playfield.
- Grouped rhythm lanes and judgement line inside Playfield.
- Corrected judgement-line alignment and sizing.
- Implemented external JSON chart loading.
- Added ChartManager.
- Removed hardcoded note chart data from NoteSpawner.
- Completed regression testing of the core gameplay loop.

### Current Timing Windows

- PERFECT: ±50 ms
- GREAT: ±100 ms
- GOOD: ±150 ms
- MISS: outside ±150 ms

### Current Scoring

- PERFECT: 1000 points
- GREAT: 700 points
- GOOD: 400 points
- MISS: 0 points

Successful judgements increase combo.
MISS resets the current combo.

### Current Architecture

Chart JSON
→ ChartManager
→ NoteSpawner
→ Note
→ AudioManager
→ JudgementManager
→ ScoreManager
→ Gameplay HUD

### Technical Decisions

- Audio playback position is the source of truth for rhythm timing.
- Note position is derived from song time rather than accumulated
  frame delta.
- Chart timestamps represent the expected hit time at the
  judgement line.
- Song charts are stored externally as JSON data.
- Lane indexes use:
  - 0 = A
  - 1 = S
  - 2 = D
  - 3 = F
- Visual design remains placeholder/debug quality until the
  core game systems are stable.

### Issues Encountered

- Godot resource UID reference became stale after modifying
  the main scene.
- Fixed the stale main-scene UID reference.
- Audio initially failed to play because the stream was not assigned.
- Fixed AudioStreamPlayer configuration.
- Note movement initially relied on delta-based movement.
- Reworked movement to follow the audio song clock.
- JudgementManager was initially missing its attached script.
- Fixed script attachment and judgement calls.
- Gameplay playfield was positioned against the left side.
- Reworked Control hierarchy and centered the playfield.
- Judgement line became misaligned after layout restructuring.
- Moved it into the Playfield and synchronized its width.
- Judgement text initially left visual ghost artifacts.
- Replaced fade-out behaviour with deterministic show/hide logic.

### Day 2 Result

Status: COMPLETE

The game now has a functional core rhythm engine capable of
loading note-chart data, synchronizing notes to music,
accepting four-lane input, evaluating timing accuracy,
tracking score and combo, and displaying gameplay feedback.

### Next

Day 3:
- Song metadata structure
- Song selection workflow
- Difficulty handling
- Gameplay session lifecycle
- Song completion detection
- Results screen
- Retry / return flow