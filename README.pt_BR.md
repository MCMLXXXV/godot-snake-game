# snake.gd • [![made with Godot 4.6][badge]][godot]

Um _port_ desse jogo bobo que remonta à década de 1970.

> [!IMPORTANT]
> Para ver a versão deste mesmo projeto desenvolvido em Godot Engine 3.5, mude
> para o ramo `godot-3.x`. No entanto, essa versão do projeto está obsoleta e
> não receberá mais atualizações.


## Motivação

> Oi! Essa foi minha primeira tentativa em um projeto completo feito com Godot,
> então tenha paciência. Depois de ler vários tutoriais para "pegar o jeito", eu
> precisava de algo rápido e fácil para praticar o que acabei de aprender. Mas
> como sou um sujeito muito "criativo", [acabei fazendo a mesma coisa de
> novo][phaser]. [...]

Cá estamos de novo, vários anos depois, repetindo o mesmo erro 😂

Mas o projeto original tinha vários problemas, então resolvi sacodir a poeira e
ver o que poderia ser reaproveitado. A maior parte foi refeita do zero, mas a
ideia continua a mesma. A maioria dos códigos-fonte estão anotados, portanto
qualquer um que esteja começando sua jornada _gamedev_ com Godot Engine pode
acompanhar e aprender uma coisa ou outra.

> [!TIP]
> O projeto original, escrito em 2018 está disponível no ramo de desenvolvimento
> `master` deste repositório.


## Como jogar?

> **Para os que precisam de uma introdução**: guie a serpente, coletando os
> pedaços de comida que aparecem espalhados pelo quadro. Toda vez que a serpente
> se alimenta, ela cresce. O jogo aumenta o ritmo gradualmente. Se a serpente
> colidir contra si mesma – ou concluir a impossível missão de tomar o quadro
> inteiro – é fim de jogo.

Para jogar, basta abrir o projeto no editor do Godot Engine e apertar
<kbd>F5</kbd>. O aplicativo se assemelha à uma interface _mobile_, mas é
possível controlar tudo pelo teclado:

  - Na tela de título: pressione <kbd>Enter</kbd> para iniciar o jogo,
    ou <kbd>ESC</kbd> para encerrá-lo.

  - No jogo: mova a serpente usando as setas para a esquerda (<kbd>←</kbd>) ou
    direita (<kbd>→</kbd>). Aperte <kbd>Enter</kbd> para pausar ou continuar o
    jogo a qualquer momento.

O jogo salva sua melhor pontuação ao final de cada sessão.


## Licença

Toda arte e códigos-fonte deste projeto estão compartilhados sob os termos da
licença [Creative Commons CC0 1.0 Universal](LICENSE.md).

[godot]: https://godotengine.org/
[badge]: https://flat.badgen.net/badge/made%20with/Godot%204.6/478cbf
[phaser]: https://github.com/rblopes/phaser-3-snake-game
