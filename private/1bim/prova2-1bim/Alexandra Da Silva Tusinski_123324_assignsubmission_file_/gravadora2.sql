drop database if exists gravadora2;
drop table cd;
drop table musica_gravadora;
drop table gravadora;
drop table autor_musica;
drop table musica;
drop table autor;


create database gravadora2;


create table autor(
  id serial primary key,
  nome text not null
);

insert into autor(nome) VALUES
  ('Roberto Carlo'),
  ('Marcia Lima'),
  ('Renata Abreu'),
  ('Silvio Santos');

create table musica(
  id serial primary key,
  nome text not null,
  duracao timestamp
);

insert into musica(nome, duracao) VALUES
  ('linda', null),
  ('viva hoje', null),
  ('vida ou morte', null),
  ('cara ou coroa', null),
  ('voa coracao', null);


create table autor_musica(
  autor_id integer references autor(id),
  musica_id integer references musica(id)
);

insert into autor_musica(autor_id, musica_id) VALUES
  (1,1),
  (2,1),
  (1,2),
  (3,2),
  (null, 3),
  (null, 5),
  (1,4),
  (4,4);


create table gravadora(
  id serial primary key,
  nome text not null,
  endereco text,
  telefone text,
  contato text,
  site text
);

insert into gravadora(nome, endereco, telefone, contato, site) VALUES
  ('som livre', 'alameda das esperancas sn, cidade Rio Grande, RS', '53984454545', 'sl@gmail.com', 'sl.com.br' ),
  ('rpg', 'rua Nobre 123, POA, RS', '51 985464646', 'rpg@terra.com.br', 'rpg.com.br' ),
  ('sony', 'rua Tiaraju, POA, RS', '51 985121212', 'sony@hotmail.com', 'sony.com.br'),
  ('rbs', 'rua duque de caxias, Rio grande, RS', '53 32335657', 'rbs@gmail.com', 'rbs.com.br');

create table musica_gravadora(
  musica_id integer references musica(id),
  gravadora_id integer references gravadora(id),
  n_faixa integer,
  primary key (musica_id, gravadora_id)
);

create table cd(
  id serial primary key,
  nome text not null,
  preco real not null check (preco >0),
  data_lancamento date,
  gravadora_id integer references gravadora(id)
);

insert into cd(nome, preco, data_lancamento, gravadora_id) VALUES
  ('vida ou morte', 19.00, '1995/02/02', 1),
  ('sertao veredas', 20.00, '1998/04/28', 2),
  ('linda', 15.00, '2000/05/10', 3),
  ('vida', 25.00, '2015/03/10', 4);

  --------------------------------------------------------

5)  select autor.nome from autor where autor_nome like 'R%' and '%o';

6) select musica.nome from musica inner join autor_musica where autor.id = null;

7) select cd.nome, cd.data_lancamento from cd where cd.data_lancamento(select cast('1995-01-01' as date) between cast('2000-12-31' as date) as resultado group by cd.nome, cd.data_lancamento;

8)

9)select musica.nome, count(autor.id) from autor_musica where autor.id>=2 and musica.nome=musica.id group by musica.nome;
