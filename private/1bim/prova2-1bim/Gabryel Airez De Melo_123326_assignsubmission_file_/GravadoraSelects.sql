-- 5)
select autor.nome as autor
from autor
where lower(autor.nome) like 'R%O';

-- 6)
select musica.nome as musicas
from musica
left join autor on autor.id = musica.autor
where musica.autor is null;

-- 7)
select cd.nome, cd.data_lancamento
from cd
where (extract(year from data_lancamento)) >= 1995 and
(extract(year from data_lancamento)) <= 2000;

-- 8)
select cd.nome, max(cd.preco), min(cd.preco), count(*)
from cd
inner join gravadora on cd.gravadora = gravadora.id
group by 1;