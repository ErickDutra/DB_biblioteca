
create or replace procedure renovar_emprestimo(idLivro integer, usuario integer)
language plpgsql
as $$
	declare
	data_atual date := CURRENT_DATE;
begin
	update emprestimo
	set data_aluguel = data_atual,
	data_entrega = null,
	data_prevista = data_atual + INTERVAL '3 days'
	where id_livro = idLivro and id_usuario = usuario;
COMMIT;
end $$

select * from emprestimo

DROP PROCEDURE renovar_emprestimo(integer,integer)
	
-- passar (idlivro, idusuario)	
CALL renovar_emprestimo(2,5);