## Na tabela de log de exercícios temos várias colunas com os tipos de exercícios, duração em minutos, calorias queimadas, batimentos cardíacos. 
Sabe-se que a taxa de batimentos cardíacos máxima é calculada com a seguinte fórmula: (220 - sua_idade)
Por exemplo, para uma pessoa de 40 anos a taxa de batimentos cardíacos máxima será de 220 - 40 = 180 bpm

Faça uma consulta que retorne TODAS as colunas mais uma coluna chamada hr_zone com a seguinte condição:
heart_rate > (220 - sua_idade), retornará "Acima do máximo"
heart_rate > 90% da taxa de batimentos cardíacos máxima retornará "Acima do objetivo"
heart_rate > 50% deverá retornar "Dentro do objetivo"
caso contrário retornará "Abaixo do objetivo" 
Para esse desafio utilize o comando CASE.


CREATE TABLE exercise_logs
    (id INTEGER PRIMARY KEY AUTO_INCREMENT,
    type TEXT,
    minutes INTEGER, 
    calories INTEGER,
    heart_rate INTEGER);

INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("bike ergométrica", 30, 100, 110);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("bike ergométrica", 10, 30, 105);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("dança", 15, 200, 120);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("dança", 15, 165, 120);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("natação", 30, 70, 90);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("natação", 25, 72, 80);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("escalada", 30, 70, 90);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("caminhada", 60, 80, 85);
