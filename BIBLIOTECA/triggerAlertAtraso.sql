create or replace function alertAtraso() 
returns trigger AS $$

begin
 if new.data_entrega > new.data_prevista then
	raise notice 'Livro entrege com atraso.';
end if;
return new;
end;
$$ language plpgsql;


create trigger trigger_alerta_atraso
before update on emprestimo
for each row
when (NEW.data_entrega is not null)
execute function alertAtraso();
