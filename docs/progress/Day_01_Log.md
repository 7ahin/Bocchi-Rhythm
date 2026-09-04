# Bocchi Rhythm — Development Log

## Day 1 — Project Foundation

### Objective
Establish the development environment, project structure,
version control and basic rhythm-game technical prototype.

### Completed

- Installed Godot 4
- Created Bocchi Rhythm Godot project
- Connected project folder with VS Code
- Established project folder structure
- Initialized Git repository
- Published repository to GitHub
- Created MainMenu.tscn
- Created Gameplay.tscn
- Configured ASDF rhythm inputs
- Implemented four rhythm lanes
- Implemented visual lane input feedback
- Added key indicators
- Added judgement line
- Created reusable Note.tscn
- Implemented basic falling-note behaviour
- Created initial SDLC documentation
- Tested prototype successfully
- Committed and pushed Day 1 progress

### Technical Validation

The following pipeline was successfully validated:

Player Keyboard Input
→ Godot Input Map
→ Gameplay Input Script
→ Lane Visual Feedback

and:

Note.tscn
→ note.gd
→ Falling Note
→ Judgement Line

### Issues Encountered

- Main menu Control layout initially failed to render correctly.
- Resolved by correcting Control anchors and offsets.
- GDScript parse error caused by missing syntax.
- Note script initially not attached to Note scene.
- Old Godot scene UID caused resource warnings.
- Main scene UID reference was corrected.

### Decisions

- Default rhythm controls: A, S, D, F.
- Godot 4 selected as game engine.
- Windows PC selected as MVP target.
- Visual theme postponed until core gameplay is validated.
- Debug colours and placeholder UI will be used during prototype development.

### Day 1 Result

Status: COMPLETE

The project now has a stable technical foundation for
development of the core rhythm engine.

### Next

Day 2:
- Automatic note spawning
- Chart data
- Audio timing
- Rhythm judgement system