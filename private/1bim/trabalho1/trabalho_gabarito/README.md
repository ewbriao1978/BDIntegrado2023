# Trabalho 1

## Descrição

Construa a **Modelagem Conceitual (Modelo ER)**, a **Modelagem Lógica (Modelo Relacional)** e a **Modelagem Física (SQL)** para uma Rede Social semelhante ao Facebook onde: 

* Cada Usuário tem: nome, e-mail e senha;
* Email deve ser único;
* A senha deve ser armazenada em _md5_
* Cada Usuário pode criar álbuns de fotos e publicações;
* Cada Álbum tem: título, descrição e fotos;
* Cada Foto tem: legenda e nome do arquivo;
* Cada Foto pertence, exclusivamente, a um Álbum;
* Fotos não podem ser compartilhadas por publicações ou por outros álbuns;
* Uma Publicação pode ter diversos Arquivos de Mídia;
* Cada Publicação tem: data e hora de criação, texto e arquivos de mídia;
* Arquivos de Mídia de uma Publicação não podem ser compartilhados por outras Publicações, ou seja, são exclusivos de uma única Publicação;
* Um Arquivo de Mídia tem nome e legenda;
* Um Usuário pode seguir (estabelecer amizade) com outros Usuários;
* Um Usuário não precisa, necessariamente, seguir de volta os seus seguidores;
* Cada Usuário pode, em sua _timeline_, visualizar as publicações dos seus amigos (Usuários que segue/acompanha);
* É possível também deixar de acompanhar as publicações de um determinado seguidor (sem a necessidade desfazer a amizade);
* Usuários podem criar Grupos;
* Cada Grupo tem nome, data de criação, um dono (que deve ser também um Usuário) e usuários participantes;
* **Importante:** O dono do grupo também deve ser um participante do grupo;
* Dentro de um Grupo é possível criar Publicações (pertinentes somente ao grupo);
* Todo o Usuário que participa do Grupo pode publicar neste Grupo;
* É importante armazenar a data e hora do instante em um determinado usuário entrou em um determinado Grupo;
* Um Grupo pode ter vários usuários e um usuário pode participar de vários Grupos;
* Publicações de um Grupo são exclusivas do Grupo;
* Publicações são sempre criadas por Usuários;
* Publicações de um Grupo devem ser criadas por membros deste Grupo;
* O Usuário pode ver em sua _timeline_ - além das publicações dos Usuários que segue - as publicações dos Grupos que participa;

## Requisitos 
    
1. (0.5) Construir a Modelagem Conceitual (ER);
2. (0.5) Construir a Modelagem Lógica (Modelo Relacional);
3. (0.5) Construção a Modelagem Física (SQL - instruções DDL para a criação do B.D);
4. (0.5) Consulta SQL que mostre a _timeline_ de um Usuário que:

    * Liste as publicações recentes dos amigos e as publicações dos grupos em que o usuário participa;
    
      * Excluindo publicações de amigos em que o usuário definiu para não acompanhar novas publicações em sua _timeline_;
     
      * As publicações devem ser listadas por completo, ou seja, caso exista arquivos de mídia pertecentes a alguma publicação - eles também devem aparecer na consulta;

## Data de Entrega

* 25/04 pelo AVA

## Recomendações

* Colocar todas as cardinalidades do ER;

* Respeitar regras de mapeamento ER - Modelo Relacional;

* Colocar tanto no Modelo Relacional quanto no SQL os tipos de cada coluna e suas respectivas restrições de domínio e de integridade: 

    * Ex: primary key, foreign key, NULL, NOT NULL, DEFAULT, CHECK e etc, serial, integer, text, character, boolean e etc.