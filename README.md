# Memoria Assembly

## Como inicializar o jogo:
Para montarmos o jogo precisamos rodar o comando:
```
./montador memoria.asm memoria.mif
```

Para jogarmos o jogo precisamos rodar a simulação, para isso usamos o comando:
```
./sim memoria.mif charmap.mif
```

## Como jogar:
Ao inicializarmos a simulação teremos a tela:
![](https://i.imgur.com/els98rx.png)

Ao apertar entre o jogo começará. Fazemos isso para podermos ter "tabuleiros" de jogo diferentes. Isso é feito contando o tempo a partir do momento em que começamos a simulação e depois fazemos um mod entre o tempo guardado e quantos tabuleiros temos.

Aqui temos a tela do jogo:

![](https://i.imgur.com/S84rkWC.png)

O usuário digitará os valores das cartas que deseja "virar".

Foi tratado todos os casos de erro, assim o usuário só pode digitar cartas entre 0 e 19, cujas quais, são as cartas válidas no tabuleiro.

Os números acima, nas linhas, são os números das cartas.

![](https://i.imgur.com/E9SyFP4.png)

Aqui podemos ver um jogo finalizado. Podemos ver que cada player tem sua pontuação e também existe uma mensagem de qual o jogador vencedor. Existe também a possibilidade de empate.
