select * from emprestimo

call atualizar_data_prevista(5, '2024-06-15')

select 
	usu.nome,
	format('+%s (%s) %s', tel.sufixo, tel.ddd, tel.numero) as telefone,
	data_aluguel,
	data_prevista,
	(current_date - data_prevista) as dias_atraso,
	liv.titulo
	from emprestimo emp
inner join usuario usu on usu.id = emp.id_usuario
left join telefone tel on usu.id = tel.id_usuario
inner join livro liv on liv.id = emp.id_livro
where data_prevista < current_date and data_entrega is null
