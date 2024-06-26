create or replace function incrementEmpretimo() 
returns trigger AS $$
begin
new.data_prevista := CURRENT_DATE + INTERVAL '3 days';

return new;
end;
$$ language plpgsql;

create trigger trg_increment_Emprestimo
before insert
on emprestimo
for each row
execute procedure incrementEmpretimo()

