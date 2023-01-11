# Relacionamento - ER

Um relacionamento é uma associação entre as **entidades**.
Os dados devem estar armazenados e estarem relacionados na base de dados para que possamos utilizá-los eficientemente.

Ex: Esse relacionamento entre dados é que nos permite descobrir, dada duas entidades como **Aluno** e **Turma**, a qual turma um aluno pertence.

![relacionamento](relacionamento.png)

Um relacionamento é representado por um losango com o nome do relacionamento no centro. O nome do 
relacionamento representa a relação que existe entre os objetos das entidades. O nome do relacionamento pode ser um **verbo** como, por exemplo, **pertence**, **leciona**, **estuda**, **possui**, etc; ou também pode ser uma composição dos nomes das entidades como por exemplo **Aluno_Turma** em vez de **pertence**.


Um relacionamento pode ter atributos. Esses atributos são denominados **atributos descritivos**.

Ex: Imagine que seja necessário armazenar a **data** que um **professor** lecionou determinada disciplina. O **atributo** **data** **não pertence nem à entidade Professor e nem à entidade Disciplina**. Esse atributo pertence ao relacionamento **leciona**, ou seja, é um atributo do relacionamento. E ele só deve ser preenchido com um valor, quando for feita a relação entre **professor** e **disciplina**.

![atributo-descritivo](atributo-descritivo.png)


## Cardinalidade


As restrições de mapeamento ou cardinalidade expressam o número de objetos de uma entidade ao qual outra entidade pode ser associada, via um relacionamento.

Para descobrir a cardinalidade de um relacionamento, a pergunta que deve ser feita é:**"Se eu pegar um único objeto da minha entidade X, a quantos objetos da entidade Y ele pode se associar?"**


Isto é, se eu pegar o objeto *Elaini* da entidade **Professor**, esse objeto *Elaini* poderá lecionar quantas disciplinas da entidade **Disciplina**? E se eu pegar o objeto *Banco de dados* da entidade **Disciplina**, a quantos professores ele poderá estar relacionado?

Esse número de associações entre objetos pode ser 0,1 ou vários (representado por N). No caso do exemplo de Professor e Disciplina a cardinalidade do modelo é N para N, permitindo que um professor lecione várias disciplinas e que uma disciplina seja ministrada por mais de um professor. Por exemplo, a disciplina de Banco de dados poderia ser ministrada pela profª. Elaini e pelo prof. João. Além de Banco de dados,a profª. Elaini poderia lecionar também, a disciplina de Análise de Projetos.


A cardinalidade de relacionamentos podem ser de 3 tipos: **Um para Um**, **Um para Muitos** e **Muitos para Muitos**.

## Cardinalidade Um para Um (1:1)

A cardinalidade (1:1) ocorre quando um objeto de uma entidade pode se relacionar a apenas um objeto de outra entidade e vice-e-versa. Imagine que você esteja desenvolvendo um sistema para uma rede de escolas. Cada escola terá um diretor (que é um professor da escola), e este diretor só poderá dirigir uma escola. Sendo assim, o relacionamento **dirige** entre as entidades **Escola** e **Professor** será 1:1.

O relacionamento pode ser lido da seguinte forma: um professor dirige uma escola e uma escola é dirigida por um professor.

## Cardinalidade Um para Muitos (1:N)


A cardinalidade Um para Muitos ocorre quando um objeto de uma entidade pode se relacionar a vários objetos da outra entidade, mas o contrário não é verdadeiro. Imagine um professor possa trabalhar em apenas uma escola da rede municipal e que uma escola possa ter vários professores. Nesta situação, teremos um relacionamento 1:N.


## Cardinalidade Muitos para Muitos 

A cardinalidade Muitos para Muitos (N:N) ocorre quando um objeto de uma entidade pode se relacionar a vários objetos da outra entidade e vice-e-versa. Imagine que um professor possa ministrar aulas em várias disciplinas e que uma disciplina possa ser ministrada por vários professores. Nesse caso, temos um relacionamento N:N.


## Resumo - Cardinalidade

![relaciomentos-er](relaciomentos-er.png)



## Relacionamento Ternário ou Maiores


Até agora, todos os exemplos apresentados são de relacionamentos binários, ou seja, entre duas entidades. No entanto, um relacionamento pode ocorrer também entre três ou mais entidades.

Considere o exemplo em que um professor pode ministrar disciplinas para diferentes turmas. Nesta situação, um professor poderia dar aula de uma ou mais disciplinas, e poderiam existir um ou mais professores que dessem a mesma disciplina em diferentes turmas. Com a mudança de ano, o professor que dava aula da disciplina de banco de dados na turma A poderia pegar a mesma disciplina para a turma B, e deixar a turma A para outro professor.

Para que as informações possam ser armazenadas e recuperadas de forma completa, teremos que criar um relacionamento ternário entre as entidades, conforme figura abaixo:


![relacionamento-ternario](relacionamento-ternario.png)

Poderíamos tentar criar três relacionamentos binários para o problema descrito acima, no entanto, se fizermos isso, não teremos as informações de forma completa como a temos no relacionamento ternário.

O relacionamento **ministra** possui ainda o atributo descritivo **ano** que permite distinguir qual foi o professor que ministrou determinada disciplina para uma turma em um determinado ano.

Obs: relacionamentos maiores que ternários devem ser evitados (se possível) porque são difíceis de serem compreendidos e de serem implementados, tornando a relação bastante complexa.

## Relacionamento Recursivo

Este tipo especial de relacionamento é aquele que relaciona objetos de uma mesma entidade. Esse tipo de relacionamento é denominado de **relacionamento recursivo** ou **autorrelacionamento**.

Imagine que existam alguns poucos alunos que representam grupos de outros alunos em reuniões e assuntos estudantis. Nesse caso, um objeto aluno representa vários objetos dentro da mesma entidade.  A figura abaixo apresenta o relacionamento **representante** como um relacionamento recursivo.

![relacionamento-recursivo](relacionamento-recursivo.png)

## Herança ou Especialização

Especialização consiste na subdivisão de uma entidade mais genérica (ou entidade pai) em um conjunto de entidades especializadas (ou entidades filhas).

Isso ocorre quando um conjunto de entidades pode conter subgrupos de entidades com atributos específicos a cada subgrupo. Esse processo tem por finalidade refinar o esquema da base de dados, tornando-o mais específico.

A figura abaixo apresenta um exemplo de especialização entre as entidades **Pessoa**, **Professor** e **Aluno**.

![especializacao](especializacao.png)

Observe que a especialização é indicada no diagrama por um triângulo, e as entidades filhas estão relacionadas com a entidade pai por meio do triângulo.

As entidades *herdam* todos os atributos da entidade pai e, portanto, não se devem repetir atributos da entidade pai nas entidades filhas. Isso significa que os atributos que aparecem na entidade pai são os atributos que existem em comum entre as entidades filhas. 

Também não é necessário indicar uma chave primária para as entidades filhas. A chave primária para as entidades filhas será definida no modelo relacional.

Uma especialização pode ter quantas entidades filhas forem necessárias, inclusive uma, se for o caso. Além disso, uma entidade filha pode também ser entidade pai para outra especialização.

No exemplo, a especialização é um caso de herança total pois uma **Pessoa** cadastrada deverá ser sempre um **Aluno** ou um **Professor**. Neste tipo de especialização, recomenda-se inserir um "t" minúsculo ao lado do símbolo que representa a herança/especialização. Em situações onde é possível que haja **Pessoas** que não sejam nem **Aluno** nem **Professor** cadastradas, a especilização/herança é considerada **parcial**. Assim, neste caso, deve-se colocar um "p" minúsculo ao lado do símbolo que representa tal relacionamento.

## Agregação OU Entidade Associativa

A **agregação** ou **entidade associativa** ocorre quando precisamos relacionar dois relacionamentos entre si.

Imagine que tenhamos duas entidades **Cliente** e **Produto** ligadas pelo relacionamento **Compra**. Agora, suponha que tenhamos que modificar esse modelo de modo que seja necessário saber quantas prestações serão pagas em uma compra. Relacionar a entidade **Prestação** com **Cliente** ou com **Produto** não faz sentido, uma vez que as prestações serão referentes à compra efetuada. Sendo assim, a entidade **Prestação** deve se relacionar à **Compra**, como mostra a figura abaixo. O retângulo desenhado em volta do relacionamento indica a **agregação**.

![agregacao](agregacao.png)


É possível também reescrever o diagrama ER anterior sem utilizar agregação (ou entidade associativa). Neste caso, o relaciomento **Compra** seria transformado em uma **entidade** que poderia ser relacionada à **Prestação**, conforme figura abaixo.


![agregacao-sem](agregacao-sem.png)

É importante ressaltar que um mesmo problema pode ter diferentes interpretações, e assim gerar diagramas diferenciados. Isso não significa que apenas um dos diagramas está certo.
