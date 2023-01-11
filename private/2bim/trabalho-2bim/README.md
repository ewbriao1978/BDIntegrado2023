# Trabalho 2º Bim.


## Descrição

Construa um B.D de gerenciamento de faxinas para diaristas:

O B.D deve controlar o histórico de faxinas realizados por cada diarista em cada residência.

<!-- Além disso, controlar a presença das diaristas em cada residência pois é dessa forma que .-->

* Cada **Diarista** possui um identificador (**id**), **cpf** e **nome**;
* Cada **Residência** possui um **responsável**. Para o responsável é importante armazenar seu **nome** e seu **cpf**;
	* Além do responsável, cada Residência possui um **identificador** (id), **cidade**, **bairro**, **rua**, **complemento** e **número** e **Tamanho** (pequena, média ou grande);
* Um **Responsável** pode ser responsável por mais de uma **Residência** mas uma **Residência** tem somente um **Responsável**;
* Dependendo do **Tamanho** da **Residência**, a **Faxina** tem um **preço**;
* Uma **Diarista** realiza uma **Faxina** por dia, ou seja, atende uma Residência por dia;
* Uma **Diarista** pode atender várias residências, e uma residência pode ser atendida por várias **Diaristas**;
* **Faxinas** podem ser agendadas (por data);
* É importante saber se a **Diarista** não foi (faltou) a uma **Faxina**, previamente, agendada;
* **Faxinas** agendadas e não-realizadas (por qualquer motivo) não devem ser pagas;
* É importante armazenar feedbacks de avaliação por cada **Faxina** realizada. Estes comentários devem ser realizados pelo **Responsável** da **Residência** no momento da conclusão da **Faxina**;
* O valor final pago pela **Faxina** deve ser também armazenado pois o valor por ser: **maior** (devido à gorjetas), **menor** (devido à algum dano/prejuízo causado pela diarista) ou **igual** ao valor definido para residências de mesmo **Tamanho**. Lembrando que, ao longo do tempo, o valor da **Faxina** atribuído pelo **Tamanho** da **Residência** pode também mudar. Logo, é importante armazenar também este valor que foi realmente pago por cada **Faxina** a fim de saber, especificamente, o que cada **Diarista** recebeu pelas **Faxinas** que fez ao longo do tempo.

<!--
* Há Planos **semanais** e **quinzenais** de limpeza que variam de preço dependendo do tamanho da residência;
	* Ex: 
		* Plano Quinzenal para uma Residência Pequena - R$ 200
		* Plano Quinzenal para uma Residência Média - R$ 300
		* Plano Quinzenal para uma Residência Grande - R$ 400
		* Plano Mensal para uma Residência Pequena - R$ 400
		* Plano Mensal para uma Residência Média - R$ 600
		* Plano Mensal para uma Residência Grande - R$ 800
* Há um calendário
-->

## Exigências:

* Crie o Modelo Relacional
* Implemente no PostgreSQL o B.D projetado no Modelo Relacional (construa um _script.sql_)
* Crie um STORE PROCEDURE que permita agendar quinzenalmente ou mensalmente faxinas em uma determinada residência:
	
* A diarista e a residência devem ser considerados parâmetros de entrada. Por outro lado, pode-se realizar o stored procedure de 2 formas:
  Opções:
        1) Utilizar uma data limite (ex: até 31/12 do ano atual)
        2) Utilizar uma quantidade máxima de agendamentos (ex: marcar 30 faxinas mensalmente)  
* Crie um STORE PROCEDURE que calcule a porcentagem de presenças que uma diarista obteve em suas faxinas ao longo do ano:
	* Ex: 75% de presença
* Crie uma TRIGGER que exclua a diarista caso suas presenças fiquem menores que 75% (quando a diarista já tem no mínimo 5 faxinas cadastradas) 	


## Valor:

* 2.0
	
## Data de Entrega:

* 27/06 pelo AVA

***