select * from emprestimo

SELECT 
    usu.nome,
    (SELECT count(*) FROM emprestimo WHERE id_usuario = emp.id_usuario) AS "LivrosjaEmprestados",
    (SELECT count(*) FROM emprestimo WHERE id_usuario = emp.id_usuario AND data_entrega IS NOT NULL) AS "LivrosEntreges",
    (SELECT count(*) FROM emprestimo WHERE id_usuario = emp.id_usuario AND data_entrega IS NULL) AS "LivrosNaoEntreges"
FROM emprestimo emp
inner JOIN usuario usu ON usu.id = emp.id_usuario
WHERE emp.id_usuario = '4'
limit 1;
call devolucao_livro(1,4)