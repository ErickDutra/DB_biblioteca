select * from livro


create or replace procedure atualizar_ano(idLivro integer, novaData date)
language plpgsql
as $$
	begin
	begin
		update livro
		set ano_publicacao = novaData
		where id = idLivro;
 EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao atualizar ano publicação' ;
    END;
commit;
END;
$$;

create or replace procedure atualizar_titulo(idLivro integer, novoTitulo varchar)
language plpgsql
as $$
	begin
	begin
		update livro
		set titulo = novoTitulo
		where id = idLivro;
 EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao atualizar titulo' ;
    END;
commit;
END;
$$;

	
create or replace procedure atualizar_autor(idLivro integer, idAutor integer)
language plpgsql
as $$
	begin
	begin 
		update livro
		set id_autor = idAutor
		where id = idLivro;
 EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao atualizar autor' ;
    END;
commit;
END;
$$;

drop procedure atualizar_ano(integer, varchar)
	
create or replace procedure atualizar_editora(idLivro integer, idEditora integer)
language plpgsql
as $$
	begin
	begin
		update livro
		set id_editora = idEditora
		where id = idLivro;

 EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao atualizar a editora' ;
    END;
commit;
END;
$$;

call atualizar_titulo(3,'Pinoquio')

