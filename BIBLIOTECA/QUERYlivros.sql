select * from livro

CREATE OR REPLACE FUNCTION inserir_livro(titulo varchar, id_autor integer, id_editora integer, ano_publicacao date)
RETURNS TEXT AS $$
BEGIN
	INSERT INTO livro(titulo, id_autor,id_editora, ano_publicacao) VALUES(titulo,id_autor, id_editora,ano_publicacao);
	RETURN 'INSERIDO COM SUCESSO';
COMMIT;
END;
$$ LANGUAGE plpgsql

SELECT inserir_livro('Rápido e Devagar', 2, 1, '2022-08-30');
SELECT inserir_livro('As 6 Lições', 1, 2, '2002-01-30');
SELECT inserir_livro('O Capital', 3, 3, '2008-09-04');
SELECT inserir_livro('Economia', 4, 4, '1998-05-09');

