# Day 06 Progress Log
**Project:** Bocchi Rhythm  
**Date:** 10 September 2026  
**Phase:** UI Polish, Settings & Personalisation

---

## Objectives

Day 6 focused on improving the game's visual identity, player settings, and audio customisation.

Main goals:

- Implement character-based themes
- Create functional Settings screen
- Save player preferences
- Extend character themes into Gameplay
- Separate Music and SFX audio
- Add Music and SFX volume controls

---

## 1. Character Theme System

Implemented four selectable character themes:

- Bocchi — Pink
- Nijika — Yellow
- Ryo — Blue
- Kita — Red

A global `ThemeManager` was created to manage the current character theme.

The selected accent colour dynamically updates:

- Accent labels
- Primary buttons
- Menu visual accents

### ThemeManager Features

Implemented:

- `apply_theme()`
- `update_primary_buttons()`
- `update_accent_labels()`
- `get_accent_color()`

Character accent colours:

```text
Bocchi  #F29BC2
Nijika  #F2D45C
Ryo     #67A9D8
Kita    #E85D6A