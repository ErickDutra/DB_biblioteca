select * from usuario

create or replace procedure atualizar_email(idUsuario integer, novoEmail varchar)
language plpgsql
as $$
	begin
	begin
		update usuario
		set email = novoEmail
		where id = idUsuario;
 EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao atualizar email de usuario' ;
end;
commit;
end; $$;

call atualizar_email(4, 'bigZ@gmail.com')

create or replace procedure atualizar_nome(idUsuario integer, novoNome varchar)
language plpgsql
as $$
	begin
	begin
		update usuario
		set nome = novoNome
		where id = idUsuario;
 EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao atualizar nome de usuario' ;
end;
commit;
end; $$;

drop procedure atualizar_email(integer, varchar)


