select * from emprestimo

create or replace procedure emprestimo_livro(id_livro integer, usuario integer)
language plpgsql
as $$
	declare 
	data_prevista date:= CURRENT_DATE;
	data_aluguel date := CURRENT_DATE;
	quantidade_livros_sem_devolucao INTEGER;
begin
	begin
	select count(*) into quantidade_livros_sem_devolucao 
	from emprestimo
	where id_usuario = usuario and data_entrega is null;

	if quantidade_livros_sem_devolucao >= 3 THEN
	raise exception 'você atingiu a quantidade maxima';
	end if;

	insert into emprestimo(data_prevista,data_aluguel,id_livro,id_usuario)
	values(data_prevista, data_aluguel, id_livro, usuario);
EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao pedir adiquirir um emprestimo' ;
end;
COMMIT;
end; 
$$;

DROP PROCEDURE emprestimo_livro(integer,integer)
	
-- passar (idlivro, idusuario)	
CALL emprestimo_livro(2,5);


