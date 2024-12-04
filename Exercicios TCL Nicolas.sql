-- **Exercício 1: Desativar o Autocommit, Inserir Professores e Efetuar o COMMIT**

SET autocommit = 0;
INSERT INTO professor (nro_registro_professor, nome, codigo_disciplina) VALUES
('P011', 'Clara Almeida', 'D001'),  
('P012', 'João Gomes', 'D002'),     
('P013', 'Fernando da Silva', 'D003'), 
('P014', 'Bento Ramos', 'D002');    
COMMIT;


-- **Exercício 2: Alterar Dados de Professor e Excluir um Registro**


UPDATE professor
SET nome = 'Clara de Almeida'
WHERE nome = 'Clara Almeida' AND codigo_disciplina = 'D001';
DELETE FROM professor
WHERE nome = 'Fernando da Silva' AND codigo_disciplina = 'D003'; 
COMMIT;


-- **Exercício 3: Criar um SAVEPOINT, Inserir Disciplinas, Atualizar e Excluir Registros**


SAVEPOINT savepoint_insert_disc;
INSERT INTO disciplina (codigo_disciplina, nome_disciplina, carga_horaria, descricao) VALUES
('D011', 'Matemática II', 60, 'Continuação de Matemática I'),
('D012', 'Física II', 60, 'Avanços em Física Moderna'),
('D013', 'Química II', 60, 'Continuação da Química Geral'),
('D014', 'Programação II', 80, 'Lógica de Programação Avançada'),
('D015', 'Estruturas de Dados', 40, 'Estruturas de Dados e Algoritmos Avançados');
UPDATE disciplina
SET nome_disciplina = CONCAT(SUBSTRING(nome_disciplina, 1, LENGTH(nome_disciplina) - 1),
                             IF(UPPER(RIGHT(nome_disciplina, 1)) = RIGHT(nome_disciplina, 1),
                                LOWER(RIGHT(nome_disciplina, 1)),
                                UPPER(RIGHT(nome_disciplina, 1))))
WHERE codigo_disciplina = 'D012';
DELETE FROM disciplina
WHERE codigo_disciplina = 'D015';
ROLLBACK TO SAVEPOINT savepoint_insert_disc;
COMMIT;

