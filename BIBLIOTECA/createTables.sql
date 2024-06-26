create table usuario(
    id SERIAL primary key,
    nome VARCHAR(100)not null,
    email varchar(100) unique,
    data_registro DATE,
);

create table telefone(
    id SERIAL primary key,
    sufixo INTEGER,
    ddd INTEGER,
    numero INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

create table autor(
    id SERIAL primary key,
    nome VARCHAR(100) not null
);

create table editora(
    id SERIAL primary key,
    nome VARCHAR(100) not null
);

create table livro(
    id SERIAL primary key,
   	titulo VARCHAR(100)not null
	ano_publicacao DATE not null,
    FOREIGN KEY (id_autor) REFERENCES autor(id)
	FOREIGN KEY (id_editora) REFERENCES editora(id)
);

create table emprestimo(
    id SERIAL primary key,
   	data_entrega DATE,
	data_prevista DATE not null,
	data_aluguel DATE not null,
    FOREIGN KEY (id_livro) REFERENCES livro(id)
	FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);


