create table gravadora (
    id integer not null,
    nome varchar(35) not null,
    endereco text,
    telefone integer,
    contato varchar(35),
    site varchar(45),
    primary key (id)
);

create table cd (
    id integer not null,
    nome varchar(35),
    preco real not null check (preco > 0),
    data_lancamento date,
    gravadora integer not null,
    foreign key (gravadora) references gravadora(id),
    primary key (id)
);

create table autor (
    id integer not null,
    nome varchar(35),
    primary key (id)
);

create table musica (
    id integer not null,
    duracao time,
    autor integer,
    cd integer not null,
    nome varchar(35),
    foreign key (autor) references autor(id),
    foreign key (cd) references cd(id),
    primary key (id)
);

create table cdMusica (
    id_musica integer not null,
    id_cd integer not null,
    numero_faixa integer,
    foreign key (id_musica) references musica(id),
    foreign key (id_cd) references cd(id),
    primary key (id_musica, id_cd)
);

create table musicaAutor (
    id_musica integer not null,
    id_autor integer not null,
    foreign key (id_musica) references musica(id),
    foreign key (id_autor) references autor(id),
    primary key (id_musica, id_autor)
);

insert into gravadora (id, nome, endereco, telefone, contato, site) values 
(1, 'kondzilla', 'São Paulo, Capital', 32323553, 'kondzillarecords@gmail.com', 'www.kondzillarecords.com.br'),
(2, 'GR6', 'São Paulo, Capital', 32343536, 'gr6studios@hotmail.com', 'www.gr6.com.br'),
(3, 'Amazon Music Studio', 'Cabo Frio, RJ', 32389090, 'musicstudio@amazon.com', 'www.amazon.com'),
(4, 'Warner Music', 'Angra dos Reis, RJ', 38314050, 'warnermusic@studio.com', 'www.warnerbrosmusic.com');

insert into autor (id, nome) values 
(1, 'Renato Russo'),
(2, 'Rony Rogerio'),
(3, 'Roberto Carlos'),
(4, 'Péricles');

insert into cd (id, nome, preco, data_lancamento, gravadora) values
(1, 'Péricles solo vol. 1', 30, '2015-10-05', 3),
(2, 'Péricles solo vol. 2', 35, '2017-01-20', 2),
(3, 'Péricles solo vol. 3', 50, '2019-12-29', 2),
(4, 'Especial de natal Roberto Carlos', 65, '1998-02-28', 3),
(5, 'AC/DC Live', 150, '2010-04-25', 4);

insert into musica (id, duracao, nome, autor, cd) values
(1, '00:03:36', 'Melhor eu ir', 4, 1),
(2, '00:02:59', 'Até que durou', 4, 2),
(3, '00:03:18', 'Melhor assim', 4, 3),
(4, '00:04:47', 'Esse cara sou eu', 3, 4),
(5, '00:03:13', 'Thunderstruck', null, 5);
