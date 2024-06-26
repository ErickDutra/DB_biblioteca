CREATE TABLE telefone(
	id SERIAL PRIMARY KEY,
	sufixo INTEGER NOT NULL,
	ddd INTEGER NOT NULL,
	numero INTEGER NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES usuario(id);
);


CREATE OR REPLACE FUNCTION inserir_telefone(sufixo integer, ddd integer, numero integer, id_usuario integer)
RETURNS TEXT AS $$
BEGIN
	INSERT INTO telefone(sufixo, ddd, numero, id_usuario) VALUES(sufixo, ddd, numero, id_usuario);
	RETURN 'INSERIDO COM SUCESSO';
COMMIT;
END;
$$ LANGUAGE plpgsql

SELECT inserir_telefone(55, 27, 33595921, 4);
SELECT inserir_telefone(55, 21, 999998585, 5);
SELECT inserir_telefone(55, 31, 34593362, 6);
SELECT inserir_telefone(55, 61, 988876263, 7);

select * from telefone