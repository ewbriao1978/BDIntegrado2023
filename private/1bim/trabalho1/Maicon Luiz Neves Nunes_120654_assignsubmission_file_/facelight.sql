DROP DATABASE IF EXISTS facelight;

CREATE DATABASE facelight;

\c facelight

create table facelight(
    url text not null primary key,
    descricao text
);

create table usuario (
    id serial primary key,
    email text unique not null,
    nome text,
    senha text ,
    publicacao_usuario text
);

create table grupo (
    id serial primary key,
    nome text,
    data_criacao date,
    hora time,
    publicacao_grupo text
    
);

create table usuario_grupo (
    usa_id integer references usuario (id),
    usuario_grupo_id integer references grupo (id),
    dono_id_grupo integer references usuario(id),
    primary key (usa_id, usuario_grupo_id)
);


create table album_foto (
    id serial primary key,
    titulo text ,
    descricao text,
    usuario_id integer references usuario (id)
);

create table foto (
    id serial primary key,
    legenda text,
    nome_arquivo text,
    album_foto_id integer references album_foto (id)
);


create table publicacao (
    id serial primary key,
    data date default current_date,
    --data date,
    hora time,
    usuario_id integer references usuario(id),
    grupo_id integer references grupo(id)
);

create table arquivo_midia (
    id serial primary key,
    nome text,
    legenda text,
    publicacao_id integer references publicacao (id)
);

create table amizade (
    id_amizade integer primary key,
    nome text,
    email text,
    senha text,
    acompanha_feed boolean,
    usuario_amizade_id integer references usuario (id)
);

insert into facelight (url, descricao) values
('www.facelight@bancodedados.com.br', 'Rede de usuarios para interaçao entre pessoas !!!');

insert into usuario(email, nome, senha, publicacao_usuario) values
('java@java.gmail.com', 'Jose Ribeiro Soares', 'ppk@5','Meus feeds contemporaneos...'),
('bnd@java.gmail.com', 'Joao  Soares Netto', '4490i', 'Meus devaneios...'),
('bbbb@educar.hotmail.com', 'Rita de Cassia', 'vel03', 'Meus sonhos contemporaneos..'),
('papai@gmail.com', 'Flavio da Cunha', '22zza', 'Meus arquivos...'),
('fabiana_tr@gmail.com', 'Fabiana tresti valber', 'chou1', 'Sonhei com Tartaruga...'),
('bonita@hotmail.com', 'Joselita Rinode Soares', 'bbkkl', 'Minhas Lembrancas...'),
('pretoarunda@java.gmail.com', 'Dionisio Caboclo', 'pa330',' excelente publicacao..'),
('marcelo@yahoo.com.br', 'Marcelo Gasparetto', '25210', 'Se melhorar estraga...'),
('phiton@java.gmail.com', 'Marcio Mamute', 'f4545', 'Meus feeds ...'),
('css@java.yahoo.com', 'Tony Tornado', '7560a', 'Meus Acertos com a vida...'),
('timeline@gmail.com', 'Fredy Kruger', '78675', 'Recompensa...'),
('japao.rh@gmail.com', 'JNakamura Tanaka', 'shion', 'Me bilisca...'),
('dono@hotmail.com', 'Ze Pequeno', 'tiro8', 'Aproveitando ao maximo...'),
('vaila@hotmail.com', 'Luizito Soares', 'cate3', 'Quero bis...'),
('operator@hotmail.com', 'Maicon Luiz Nunes', '90897', 'Certo...'),
('Puputz@yahoo.com.br', 'Jussa de la mana', '25242', 'Vamos de novo...'),
('javier@gmail.com', 'Xavier de la bolivia', 'jkjkl', 'Com certeza...'),
('queobserva@hotmail.com', 'Firmino cruz de sonza', 'lm990', 'Meus feeds exemplares.'),
('betito@gmail.com', 'Betitonis Aurelios', 'sxza1', 'Meus feeds antigos...'),
('time11@hotmail.com', 'Navarro viera Montes', 'ujnuj', 'Sera !!!...'),
('aps02@yahoo.com.br', 'Telecken Magroni', '23241', 'Melhor não ha...'),
('api@dis.gmail.com', 'Igor de tales', 'bdbdb', 'Se tem melhor nao conheci...'),
('nana@gmail.com', 'Fadila Cordoba Baes', 'okmpl', 'Recompensa merecida...'),
('mast@gmail.com', 'Joao Bonfada Nunes', '00541', 'Gostei muito...'),
('jacare@hotmail.com', 'Fabiano Dominique Soares', '8788s', 'Aprovado !!!...');

insert into grupo (nome, data_criacao, hora, publicacao_grupo) values
('Rio Grande Atento', '2000-12-14', '12:03:09', 'Violencia em Rio Grande .....'),
('Rio Grande Online', '2011-02-09', '18:05:55', '10º Festa do Mar acontece Sabado.....'),
('Rio Grande Pescara', '1998-08-14', '22:03:00', 'Anchovas assadas comercializadas....'),
('Rio Grande Balistico', '2015-05-06', '22:05:59','Clube de tiro ganha nova area ....'),
('Rio Grande Cassino', '2017-10-25', '11:21:01', 'Cassino  50.000 no Show da Anitta...'),
('Rio Grande Barra', '2000-06-13', '23:23:00', 'Barra ganha mais com capacidade.....'),
('Rio Grande Convida', '2009-12-25', '12:09:00', 'Convidamos 06/12/2022 Luzes de Natal...'),
('Rio Grande Praticagem', '2003-03-22', '20:04:08','Praticos entram em greve segunda....'),
('Rio Grande Abencoada', '2015-12-01', '21:08:09', 'Missa acontece  no largo dr Pio...'),
('Rio Grande Capilha', '2007-07-07', '22:25:11', 'Capilha impropia para banho diz FEPAM..');

insert into usuario_grupo (usa_id, usuario_grupo_id, dono_id_grupo) values
(1, 2, 3),
(2, 3, 1),
(3, 2, 2),
(4, 1, 4),
(5, 4, 5),
(6, 2, 6),
(7, 3, 7),
(8, 2, 9),
(9, 2, 10),
(10, 3, 11),
(11, 1, 13),
(12, 3, 15),
(13, 2, 14),
(14, 2, 17),
(15, 2, 18),
(16, 4, 20);

insert into album_foto ( titulo, descricao, usuario_id) values
('Ferias no Caribe', 'Praia Cheia , muito sol e cerveja', 2),
('Passeio de Barco', 'Lagoa Nova, a 550 km de Baurilio do sul', 1),
('Pipa - Natal', 'Festa noturna em Pipa Natal RG', 3),
('Sao Lourenco do Sul', 'Praia Lotada, muito sol e musica', 2),
('Ferias no Mato', 'Acampamento coletivo, Agradabilissimo', 5),
('Ferias com direito a cinema', 'filme muito bom , Coringa', 10),
('Passeio na Basilica', 'Momentos de devocao', 11),
('Cruzeiro pelo Mediterraneo', 'Mar azul, sonho realizado', 6),
('Mexico-Acalpuco', 'Linda cidade para visitacao', 18),
('Portugal', 'Praia de Nazare  , ondas gigantes para surfar', 19),
('Taekondo-Arte Marcial', 'Minhas lembrancas de 2000', 22),
('Ferias no Guaruja', 'Praia Maravilhosa , Lotada de gente !!!', 3),
('Passeio ciclistico', 'Passeio de 20 km de bicicleta', 5),
('Pescaria de Barco', 'Peixe , muito sol e cerveja', 7),
('Bar Dancante', 'Musicas para casais aproveitarem ', 5),
('Viajem a Gramado', 'Festival de chocolate, uma delicia !!!!', 7),
('Clube de tiro', 'Treinando a pontaria', 13),
('Futebol com os amigos ', 'Futebol e depois churras !!!', 11),
('Vendendo Acai', 'Praia Cheia , vendendo acai na praia', 17),
('Festival da musica ', 'Lotado, com musicas ineditas !!!', 2),
('Casa no Campo', 'Lugar otimo para carregar as energias !!!', 18),
('Ferias no Pantanal', 'Lugar maravilhoso para pescar !!!', 16);

insert into foto (legenda, nome_arquivo, album_foto_id) values
('Praia Mole', 'arquiv1', 2),
('Praia Lisa', 'arquiv2', 3),
('Praia do Amor', 'arquiv3', 2),
('Local Maravilhoso', 'arquiv10', 5),
('Lugar Lindo', 'arquiv12', 7),
('Arrepiei !!!', 'arquiv4', 2),
('Sonho ', 'arquiv15', 4),
('Quem nao viu nunca vera', 'arquiv5', 3),
('Sonhando acordado', 'arquiv6', 6),
('Lindo !!!', 'arquiv14', 6),
('Simplesmente fantastico', 'arquiv16', 8),
('Realizando sonhos !!!', 'arquiv22', 12),
('Amanha tem mais ', 'arquiv21', 15),
('Ansioso para mais !!!', 'arquiv11', 18),
('Praia Mole', 'arquiv9', 13),
('Especialmente maravilhoso', 'arquiv8', 2),
('Super Barato', 'arquiv18', 11),
('Meus olhos Viram', 'arquiv33', 11),
('Praia Mole', 'arquiv54', 9),
('Uaiiii !!!!', 'arquiv66', 1);

insert into publicacao ( hora, usuario_id, grupo_id) values
('12:00:00', 2, 5),
('13:42:04',  1, 3),
('11:31:05', 3, 4),
( '22:20:30', 4, 7),
( '12:45:20', 5, 6),
( '09:12:00', 6, 9),
( '19:33:00', 7, 8),
( '18:00:00', 8, 2),
( '17:06:22', 9, 10),
( '16:02:00', 12, 1),
( '15:00:23', 16, 10),
( '14:04:45', 11, 10),
( '12:00:00', 10, 9),
( '09:00:00', 13, 2),
( '02:56:14', 14, 1),
( '03:55:12', 17, 7),
( '05:00:00', 15, 3),
( '12:43:11', 18, 4),
( '08:44:09', 19, 5),
( '08:27:09', 22, 1),
( '04:00:03', 21, 4),
( '03:25:01', 24, 5),
( '17:34:02', 25, 9),
( '14:54:05',23, 8),
( '16:22:00', 20, 8);

insert into arquivo_midia (nome, legenda, publicacao_id) values
('vid01', 'Video Bonito', 2),
('vid02', 'Video Long0', 10),
('vid03', 'Passeio Gravado', 7),
('vid04', 'Video Esquisito', 2),
('vid05', 'Video Subjetivo', 1),
('vid06', 'Video Aterrorizador', 14),
('vid07', 'Meu Video Bonito', 8),
('vid01', 'Curtam meu video', 7),
('vid09', 'Video Afriodisiaco', 3),
('vid010', 'Video Amanha tem mais', 14),
('vid011', 'Lembrancas', 13),
('vid012', 'Sonhos Vividos', 11),
('vid05', 'Ah se nao fosse filmado', 2),
('vid06', 'Gravando !!!', 3),
('vid05', 'Sera foi filmado !!!', 9),
('vid06', 'Filmei Bonito', 5),
('vid08', 'Aconteceu mesmo', 9),
('vid09', 'Pois nao e que estava gravando', 4),
('vid0015', 'Video importante', 5);

insert into amizade (id_amizade, nome, email, senha, acompanha_feed, usuario_amizade_id) values
(1, 'Joaquim Barbosa', 'joquer@12gmail.com', 'joq99','false', 3),
(2,'Jonas Barbiere', 'skl@yahoo.com.br', 'wsxdc', 'true', 2),
(3,'Angelica Costa Vieira', ' ujnaa@gmail.com', 'cvcd2', 'false', 4),
(4, 'Alberto Roberto Castro', 'tgbbb@hotmail.com', 'ws777','true', 6),
(5, 'Maicon Luiz Bonfada', 'qazml@yahoo.com.br', 'uhn11','true', 7),
(6, 'Marisa Monte', 'wsix@gmail.com', '22001','true', 18),
(7, 'Igor Peçanha', 'auls12@hotmail.com', '110gg','false', 22),
(8, 'Francisco do Sertão', 'sachs@gmail.com', '1q1q1','false', 1),
(9, 'Madelaine Modestiane', 'dci@gmail.com', '8978s','true', 9),
(10, 'Babuino de Carvalho', 'babu@hotmail.com', 'wbabu','true', 8),
(11, 'Santinha de Tor', 'sant123@hotmil.com', 'sat54','true', 12),
(12, 'Joao Fernando Basilio', 'jojo22@hotmail.com', '11990','true', 17),
(13, 'Fabio das Condonga', 'ffafa@gmail.com', 'f4502','true', 10),
(14, 'Claudiane da Silva', 'clauclau@gmail.com', '1100b','false', 4),
(15, 'Isaura da Ruas', 'iisaaa23@gmail.com', 'gbxxz','true', 5),
(16, 'Marcilio Dias', 'mar098@hotmail.com', 'uitti','false', 20),
(17, 'Jussara das Costas Largas', 'ju@gmail.com', 'ju090','true', 11),
(18, 'Alexandre Cao Pastor', 'pastorrr@yahoo.com.br', 'uhn00','false', 12),
(19, 'Juliana Nao Quer Sambar', 'sambajuliana@gmail.com', 'ju443','false', 15),
(20, 'Ambrosio de Souza Soares', 'amb@gmail.com', '1100t','true', 16),
(21, 'Suplici das Caldeiras', 'scu@yahoo.com.br',' wszzz','true', 14),
(22, 'Marta Rocha', 'mamari@gmail.com', 'mama0','true', 21),
(23, 'Mondeo Sinops Souza', 'mon22@gmail.com', 'momo2','true', 13),
(24, 'Sabrina de Sapo', 'sasapo@yahoo.com.br', 'sapo3','false', 6),
(25, 'Alica no Pais das Maravilhas','qa@gmail.com','alic5','true', 16);

/*--Liste as publicações recentes dos amigos e as publicações dos grupos em que o usuário participa;
*Excluindo publicações de amigos em que o usuário definiu para não acompanhar novas publicações em sua timeline;

*As publicações devem ser listadas por completo, ou seja, caso exista arquivos de mídia pertecentes a alguma 
publicação - eles também devem aparecer na consulta;

Resposta)SELECT usuario.nome, usuario.publicacao_usuario, grupo.publicacao_grupo, publicacao.data, amizade.acompanha_feed , 
arquivo_midia.nome,  arquivo_midia.legenda FROM usuario 
FULL OUTER JOIN usuario_grupo ON usuario.id = usuario_grupo.dono_id_grupo 
FULL OUTER JOIN publicacao ON usuario.id = publicacao.usuario_id 
FULL OUTER JOIN amizade ON usuario_amizade_id = publicacao.id 
FULL OUTER JOIN grupo ON publicacao.id = grupo.id 
FULL OUTER JOIN arquivo_midia ON publicacao.id = arquivo_midia.publicacao_id 
GROUP BY usuario.nome, usuario.publicacao_usuario, grupo.publicacao_grupo, publicacao.data 
,amizade.acompanha_feed, arquivo_midia.nome,  arquivo_midia.legenda  HAVING amizade.acompanha_feed = 'true'  
ORDER BY usuario.publicacao_usuario, grupo.publicacao_grupo DESC;*/

