# Visões 

Uma visão é qualquer relação que não faz parte do modelo lógico do banco
de dados, mas que é visível ao usuário, como uma relação virtual.
O conjunto de tuplas de uma relação visão é resultado de uma expressão de
consulta que foi definido no momento de sua execução. Logo, se uma
relação visão é computada e armazenada, esta pode tornar-se desatualizada
se as relações usadas em sua geração sofrerem modificações.

Quando uma visão é definida, o sistema de banco de dados armazena sua
definição ao invés do resultado da expressão SQL que a definiu. Sempre que
a relação visão é usada, ela é sobreposta pela expressão da consulta
armazenada, de maneira que, sempre que a consulta for solicitada, a
relação visão será recomputada.

Alguns sistemas de banco de dados permitem que as relações de visões
sejam materializadas, garantindo que se ocorrerem modificações nas
relações reais usadas na definição da visão, também a visão será
modificada. Contudo, esta abordagem pode incorrer em custos de
armazenamento e atualizações de sistema.

As visões em SQL são geradas a partir do comando create view. A cláusula
padrão é:

```sql
CREATE VIEW <nome da visão> AS <expressão de consulta>;
```
Caso não necessitemos mais de uma dada visão, podemos eliminá-la por
meio do comando:


```sql
DROP VIEW <nome da visão>;
```




