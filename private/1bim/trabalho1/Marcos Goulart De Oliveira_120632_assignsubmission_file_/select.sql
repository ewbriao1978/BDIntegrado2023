select distinct p.email_usuario, p.texto, p.data_hora_criacao as Data_Publicacao, g.nome as Nome_do_Grupo 
from publicacao as p 
left join Amizade as a on p.email_usuario = a.email_amigo
left join Membro as m on p.id_grupo = m.id_grupo
left join Arquivo_Midia as am on p.id = am.id_publicacao
left join Grupo as g on p.id_grupo = g.id
where p.email_usuario = 'usuarioTeste@gmail.com' 
       or (a.email_usuario = 'usuarioTeste@gmail.com' and a.mutado = false and p.id_grupo is null) 
	   or (m.email_usuario = 'usuarioTeste@gmail.com' and (a.mutado = false or a.mutado is null))
order by p.data_hora_criacao desc;