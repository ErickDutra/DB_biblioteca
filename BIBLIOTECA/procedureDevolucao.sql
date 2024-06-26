
create or replace procedure devolucao_livro(idLivro integer, usuario integer)
language plpgsql
as $$
	declare
	entrega date := CURRENT_DATE;
begin
	begin
	update emprestimo
	set data_entrega = entrega
	where id_livro = idLivro and id_usuario = usuario;EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao atualizar a data prevista do devolução' ;

end;
COMMIT;
end;
$$;

select * from emprestimo

DROP PROCEDURE devolucao_livro(integer,integer)
	
-- passar (idlivro, idusuario)	
CALL devolucao_livro(1,6);
