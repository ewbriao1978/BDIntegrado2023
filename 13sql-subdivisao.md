# O que são as siglas DDL, DML, DQL, DTL e DCL?

A linguagem SQL é uma só. Todavia, ela é subdividida em tipos de acordo com as funcionalidades de seus comandos. As principais divisões são:

* DDL (Linguagem de Definição de Dados): São comandos que CRIAM (definem) ESTRUTURAS no banco de dados. 
    * Comandos: CREATE, ALTER, DROP, TRUNCATE, COMMENT, RENAME
O comando TRUNCATE, apesar de apagar apenas o conteúdo de uma tabela, ele não é uma DML, mas sim DDL. Isso ocorre por que ele precisa alterar (ALTER) permissões para agir, o que não acontece com o comando DELETE, que é DML.

* DML (Linguagem de Manipulação de Dados): Comandos que manipulam dados no banco, seja inserindo, apagando ou atualizando dados. 
    * São comandos: INSERT, DELETE, UPDATE, CALL, EXPLAIN PLAN, LOCK TABLE

* DQL (Linguagem de Consulta de Dados): É a consulta de dados. 
O seu comando é o SELECT. 
Obs.: Alguns autores consideram o SELECT como sendo um comando DML e outros como DQL.

* DTL (Linguagem de Transação de Dados): Comandos para controlar a transação de dados. 
    * São comandos: BEGIN TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT.

* DCL (Linguagem de Controle de Dados): Comandos relacionados ao controle de segurança do banco de dados. 
    * Comandos: GRANT, REVOKE e DENY