select usu.nome, count(emp.*) as quantidade_emprestimo from emprestimo emp
inner join usuario usu on usu.id = emp.id_usuario
where data_entrega is null
group by usu.nome