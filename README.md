# Luau Enhanced Movement

A modular system to enhance Roblox character physics with advanced movement mechanics.

### Features
* **Double Jump:** Adds an extra mid-air jump with customizable power.
* **Dash System:** Smooth, velocity-based dash using VectorForce.
* **Easy Integration:** Simple ModuleScript setup for any character.

### How to Use
1. Place the `MovementModule` in `ReplicatedStorage`.
2. Connect it via a LocalScript:
```lua
local Movement = require(game.ReplicatedStorage.MovementModule)
Movement:EnableDoubleJump()
Movement:EnableDash()
