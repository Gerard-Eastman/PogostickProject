# Pogostick Project

A custom physics-driven 2D platformer built in Godot, centered around momentum-based pogo-stick movement and precise control.

## Gameplay
The game is a single, highly difficult level.
Climb to the waving red flag to complete the game!

<p align="center">
  <img src="screenshots/finish.png" width="400">
  <img src="screenshots/jump.png" width="400">
</p>

## Technical Highlights
- Built with **Godot 4**
- Custom physics-based movement using compressing, rotation, bouncing, gravity, etc.
- Controls are rotation only, unless the auto jump mode is disabled (makes the game easier)
- Scene-based architecture with tilemap
- Explicit handling of game states (active, reset, completion)

## Engineering Focus
This project was an exercise in:
- Designing and tuning physics-driven mechanics for responsiveness
- Structuring gameplay logic using Godot’s node and signal system
- Iterating on control feel through custom physics

The emphasis was on custom physics and challenging yet fun gameplay feel rather than content volume.

## How to Run
1. Install **Godot 4**
2. Open the project file in Godot
3. Run the main scene
