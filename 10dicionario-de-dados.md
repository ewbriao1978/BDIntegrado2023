# Dicionário de Dados da Base de Dados

Após o modelo relacional ter sido descrito e diagramado, é necessário criar o **Dicionário de Dados** para a base de dados.

O Dicionário de Dados da Base de Dados tem por objetivo descrever as propriedades de uma tabela, sua estrutura física e as restrições que cada atributo possui. Assim, o desenvolvedor que irá implementar o banco de dados (**Modelo Físico**) saberá exatamente como a base deve ser criada.

No Dicionário de Dados da Base de Dados, cada tabela do modelo relacional deverá ser descrita e deverá conter os seguintes campos: **Nome do Atributo**, **Descrição do Atributo**, **Tamanho**, **Tipo** e **Restrições** (Valor Nulo, Regra de Domínio, Valor *Default* e *Unique*).


|**Nome**                     |**Descrição**                              |**Tipo** |**Tamanho**|**Nulo**               |**Regra (*check*)**          | **Chave**                                       |  **Default**       |     **Unique**|
|-----------------------------|-------------------------------------------|---------|------|----------------------------|-----------------------------|-------------------------------------------------|--------------------|-----------|
|matricula_aluno          |Armazena a matrícula do aluno                |Numérico | 5    |       Não                   |--                           | PK                                               | --                 |      Não|
|RG_aluno                     |Armazena o RG do aluno                     |Caracter |  11  |      Não                   |--                           |                           --                    | --                 |Sim        |
|nome_aluno                   |Armazena o nome do aluno                   |Caracter |   100|         Não                |--                           |                               --                |    --              |  Não      |
|data_nascimento_alunos       |Armazena a data de nascimento do aluno     |Data     |    --|            Não             |--                           |                                   --            |       --           |    Não    |
|cidade_aluno                 |Armazena a cidade em que o aluno mora      |Caracter |    20|                         Não|--                           |                                       --        |  Curitiba          |  Não      |  
|matricula_aluno_representante|Armazena a matrícula do aluno representante|Numérico |    5 |              Sim           |--                           |                                           --    |          --        |    Não    |
|codigo_turma                 |Armazena o código da turma do aluno        |Inteiro  |    --|                  Não       |--                           |   FK que referencia tbTurma                     |             --     |      Não  |
|sexo_aluno                   |Armazena o sexo a que o aluno pertence     |Caracter |     1|                     Não    |M - Masculino ou F - Feminino|     --                                          |                --  |        Não|




Para alguns tipos de dados, não é possível definirmos o tamanho, como por exemplo o tipo **Data**, porque esses tipos já têm tamanho pré-definido pelo SGBD. As restrições aplicadas a um atributo definem as propriedades desse atributo.

A restrição de **Nulo** define se um **atributo permite ou não o valor nulo**, ou seja, define se **o atributo será obrigatório ou não**.

Uma restrição de **Domínio ou Regra de Domínio** define quais valores serão permitidos cadastrar para um atributo. No exemplo, temos uma regra de domínio que diz que os valores permitidos para sexo são apenas "M" ou "F". As restrições de chave permitem identificar a chave primária (PK) e as chaves estrangeiras (FK). É interessante que na definição da chave estrangeira também seja identificado a que tabela ela referencia. 

A restrição de *default* permite que seja inserido um valor padrão caso o usuário não digite nada para o campo. No nosso exemplo, definiu-se que se o usuário não digitar nada para o campo **cidade_aluno**, o próprio SGBD armazena o valor "Curitiba" para esse campo.

A última restrição é a de **unicidade**. Essa restrição **é aplicada apenas para atributos que não são chave primária e que não podem se repetir**. No exemplo, o **atributo RG_aluno** não é chave primária e não pode se repetir. Sendo assim, pode-se definir o atributo como unique
(único). **É redundante dizer que uma chave primária é unique, já que ela não se repete.**
