# snake.gd • [![made with Godot 4.0][badge]][godot]

A port of this silly game, dating back the 1970's.

> **ℹ Note**: For the version of this project made with Godot 3, switch to the
  `godot-3.x` development branch.

> **ℹ Nota**: leia este texto em [português](README.pt_BR.md).


## Motivation

> Hi! This was my first stab at a full game project made with Godot, so bear
> with me. After reading many tutorials to get the hang of it, I needed
> something quick and easy to practice the stuff I've just learned. Because
> I'm a "very" creative person, [I ended making the same thing again][phaser].
> [...]

Here we are again, four years later, repeating the same mistake 😂

However, the original project had its share of issues, so I decided to take off
the dust and see what could be salvaged from it. It has been rewritten from
scratch for the most part, but the basic stuff is still the same. Most of the
code is annotated, so anyone just starting their gamedev journey with Godot
Engine can follow along and learn a thing or two.

> **ℹ Note**: The original project, written back in 2018, can still be found in
> the `master` branch.


## Playing the game

> **For those who need an introduction**: guide the snake, collecting the tiny
> pieces of food that appear scattered around the board. Every time the snake
> feeds, it grows a little. The game pace speeds up gradually. If it hits
> against its own body – or it accomplishes the impossible mission of conquering
> the whole board – it's "game over".

To play the game, just open the project in Godot Engine and hit <kbd>F5</kbd>.
The application resembles a mobile interface, though its also fully controllable
with the keyboard:

  - In the title screen: press <kbd>Enter</kbd> to start a new game,
    or <kbd>ESC</kbd> to end the application.

  - Inside the game: Move the snake using the left (<kbd>←</kbd>) and right
    (<kbd>→</kbd>) arrow keys. Hit <kbd>Enter</kbd> to pause or resume the game
    at any time.

The game saves your best score at the end on the session.


## License

All art and source code are shared under the terms of the [Creative Commons CC0
1.0 Universal](LICENSE.md) license.

[godot]: https://godotengine.org/
[badge]: https://flat.badgen.net/badge/made%20with/Godot%204.0/478cbf
[phaser]: https://github.com/rblopes/phaser-3-snake-game
