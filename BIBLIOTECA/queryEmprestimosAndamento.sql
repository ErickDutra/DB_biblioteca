select 
	emp.data_prevista,
	emp.data_aluguel,
	usu.nome,
	usu.email,
	usu.data_registro,
	liv.titulo,
	liv.ano_publicacao,
	aut.nome as autor,
	edi.nome as editora
	from emprestimo as emp 
inner join usuario usu on usu.id = emp.id_usuario
inner join livro liv on liv.id = emp.id_livro
inner join autor aut on aut.id = liv.id_autor
inner join editora edi on edi.id = liv.id_editora
where data_entrega is null