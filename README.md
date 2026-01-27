# snake.gd • [![made with Godot 4.6][badge]][godot]

A port of this silly game, dating back the _1970s_.

> [!IMPORTANT]
> For a version of this same project made with Godot Engine 3.5, switch to the
> `godot-3.x` branch. However, that version of the project is deprecated and
> will not get more updates.

> [!TIP]
> Se preferir, uma tradução deste mesmo texto está disponível em [português
> brasileiro](README.pt_BR.md).


## Motivation

> Hi! This was my first stab at a full game project made with Godot, so bear
> with me. After reading many tutorials to get the hang of it, I needed
> something quick and easy to practice the stuff I've just learned. Because
> I'm a "very" creative person, [I ended making the same thing again][phaser].
> [...]

Here we are again, several years later, repeating the same mistake 😂

However, the original project had its share of issues, so I decided to take off
the dust and see what could be salvaged from it. It has been rewritten from
scratch for the most part, but the basic stuff is still there. Most of the code
is annotated, so anyone just starting their _gamedev_ journey with Godot Engine
can follow along and learn a thing or two.

> [!TIP]
> The original project, written back in 2018, is available in the `master`
> branch of this repository.


## Playing the game

> **For those who need an introduction**: guide the snake, collecting the tiny
> pieces of food that appear scattered around the board. Every time the snake
> feeds, it grows a little. The game pace speeds up gradually. If it hits
> against its own body – or it accomplishes the impossible mission of conquering
> the whole board – it's game over.

To play the game, just open the project in Godot Engine and hit <kbd>F5</kbd>.
The application resembles a mobile interface, though its also fully controllable
with the keyboard:

  - In the title screen: press <kbd>Enter</kbd> to start a new game,
    or <kbd>ESC</kbd> to end the application.

  - Inside the game: Move the snake using the left (<kbd>←</kbd>) and right
    (<kbd>→</kbd>) arrow keys. Hit <kbd>Enter</kbd> to pause or resume the game
    at any time.

The game saves your best score at the end of the session.


## License

All art and source code are shared under the terms of the [Creative Commons CC0
1.0 Universal](LICENSE.md) license.

[godot]: https://godotengine.org/
[badge]: https://flat.badgen.net/badge/made%20with/Godot%204.6/478cbf
[phaser]: https://github.com/rblopes/phaser-3-snake-game
