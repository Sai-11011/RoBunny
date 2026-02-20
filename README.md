# GoBunny 🐇⚡

My second complete game. A fast-paced, Neon Pixel-Art Endless Runner built completely from scratch using **Godot 4.x**. 

This project was created to learn "Procedural Thinking" and game loop architecture. It focuses heavily on **dynamic object instancing**, **memory management** (`queue_free`), and **data persistence**. 

## ✨ Features
* **Procedural Generation:** Endless obstacle spawning with randomized patterns and controlled difficulty pacing.
* **Destructible Mechanics:** Breakable glass obstacles with satisfying particle effects and visual feedback.
* **Dynamic Environment:** A smooth Day/Night cycle that transitions in real-time to enhance immersion.
* **Advanced Systems Architecture:**
    * **Encrypted Global Save System:** Uses encrypted dictionaries to securely store high scores and player preferences.
    * **Global Audio Manager:** Built with Godot's audio buses to handle seamless background music and overlapping SFX (polyphony) across scene reloads.
    * **Clean State Management:** Decoupled UI logic handling Start, Pause, Game Over, and Instant Restart states without breaking the physics tree.
* **Optimized Performance:** Strict memory cleanup for off-screen nodes to ensure smooth, fast-paced gameplay.

## 🎮 Controls
| Action | Keyboard |
| :--- | :---: |
| **Jump** | `Up Arrow` |
| **Shoot (Break Glass)** | `Space` |
| **Pause Game** | `ESC` |

## 🛠️ Built With
* **Engine:** [Godot 4.x](https://godotengine.org/)
* **Language:** GDScript
* **Graphics:** Custom Pixel Art drawn in [Piskel](https://www.piskelapp.com/)
* **Audio:** SFX via [sfxr.me](https://sfxr.me/) | Music via [BeepBox](https://www.beepbox.co/)

## 🚀 How to Run
1.  **Clone this repository:**
    ```bash
    git clone https://github.com/Sai-11011/GoBunny.git
    ```
2.  **Import into Godot:**
    * Open Godot Engine.
    * Click **Import**.
    * Navigate to the folder and select `project.godot`.
3.  **Play:**
    * Press `F5` to run the game.

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.