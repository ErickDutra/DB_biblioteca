
DROP PROCEDURE atualizar_data_prevista(integer, date)

CREATE OR REPLACE PROCEDURE atualizar_data_prevista(idEmprestimo INTEGER, novaData DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    BEGIN
        UPDATE emprestimo
        SET data_prevista = novaData
        WHERE id = idEmprestimo;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Ocorreu um erro ao atualizar a data prevista do empréstimo', ;
    END;
commit;
END;
$$;

select * from emprestimo

call atualizar_data_prevista(9,'2024-06-30')
