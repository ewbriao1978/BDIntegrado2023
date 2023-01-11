# Modelo Lógico em Banco de Dados Relacionais

<!--O **modelo relacional** é um modelo lógico, utilizado em banco de dados relacionais.-->

Um **modelo lógico** é uma descrição de um banco de dados no nível de abstração visto pelo usuário de um SGBD (Sistema Gerenciador de Banco de Dados). Assim, o modelo lógico é dependente do tipo particular de SGBD que será usado.

Nesse modelo, começamos a nos preocupar **como** os dados devem ser armazenados e em **como** criaremos os relacionamentoos definidos no modelo conceitual (Diagrama ER). É também nessa etapa que definimos o SGBD que será utilizado, bem como os tipos de dados de cada atributo.

Nas próximas seções apresentaremos conceitos referentes a modelos lógicos usados em SGBD's relacionais, ou seja, modelos lógicos relacionais ou somente **modelos relacionais**.  Em um SGBD relacional, os dados devem ser organizados em **tabelas** e, para cada tabela, há **colunas** relacionadas. 

<!--O modelo tem por finalidade representar os dados como uma coleção de tabelas e cada linha de uma tabela representa uma coleção de dados relacionados. -->

## Chave estrangeira e Integridade Relacional

Um conceito muito importante quando se fala de modelo relacional é o conceito de **chave estrangeira** (ou *Foreign Key* ou **FK**).

Uma chave estrangeira é um atributo da tabela que faz referência a uma chave primária de outra tabela ou da própria tabela. 

Por exemplo, suponha que tenhamos as tabelas **Aluno** e **Turma** com uma cardinalidade 1:n, ou seja, um aluno é de um turma e uma turma pode ter vários alunos. Neste caso, na tabela **Aluno** é preciso acrescentar um novo atributo, denominado **codigo_turma**, para representar a chave primária de **Turma** dentro da tabela **Aluno**. Esse atributo é chave primária da tabela **Turma** e, portanto, é uma chave estrangeira da tabela **Aluno**. O atributo que é chave estrangeira deve ser do mesmo tipo e do mesmo tamanho que a sua primária correspondente.

Obs: uma chave estrangeira **sempre** faz referência a uma chave primária. A chave estrangeira **nunca** fará referência a um atributo que não seja chave primária.

No modelo relacional é a chave estrangeira que especifica o relacionamento entre as tabelas. É através da chave estrangeira que conseguimos descobrir, por exemplo, que a aluna *Anna* pertence À turma do 1º ano do Curso Técnico em Informática (1T1), como mostram as tabelas abaixo.


Tabela **Aluno**

|  **matricula_aluno**| **nome_aluno**             | **data_nascimento_aluno**| **codigo_turma** |
|---------------------|----------------------------|--------------------------|------------------|
|      100            | Anna                       | 12/05/1997               |             1    |
|         101         |     Gustavo                |    15/04/1996            |              2   |
|            102      |            Elaini          |       22/09/1995         |               3  |
|               103   |                  Maria     |        27/06/1997        |                2 |
|                  104|                       Pedro|                03/12/199 |                 1|


Tabela **Turma**

|  codigo_turma| nome_turma|
|--------------|-----------|
|      1       |     1TI   |
|       2      |     2TI   |
|        3     |      3TI  |
|        4     |       1TP |



O valor para uma chave estrangeira deve ser um valor que já tenha sido cadastrado na chave primária correspondente ou um valor nulo. No exemplo, não poderíamos cadastrar que a aluno *Maria* pertence à turma de código 6, uma vez que não existe nenhum código 6 cadastrado na tabela **Aluno**.

Essa restrição é o que garante  a **integridade referencial** do modelo relacional. Ou seja, ela garante que não se faça referência a valores que não existam na base de dados.  Imagine a confusão que seria se fosse permitido cadastrar a aluna *Maria* na turma de código 6. Quando fôssemos procurar a que turma *Maria* pertence não teríamos esta informação. Isso tornaria a base de dados inconsistente. Sendo assim, a implementação de uma chave estrangeira garante a integridade referencial da base.

Uma chave estrangeira pode também fazer referência a chave primária dentro da mesma tabela. Isso ocorre quando temos relacionamentos recursivos.

Obs: O nome da chave estrangeira não precisa ser igual ao nome da chave primária correspondente.

## Leia+

[Conversão entre o DER e o Modelo Relacional](https://github.com/IgorAvilaPereira/bd2022_1sem/blob/main/8conversao-entre-modelos-er-e-relacional.md)
