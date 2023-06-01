CREATE TABLE pessoa (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  data_nascimento DATE,
  cpf VARCHAR(11),
  genero VARCHAR(10)
);

INSERT INTO pessoa (nome, data_nascimento, cpf, genero) VALUES
  ('João', '1990-05-10', '12345678901', 'Masculino'),
  ('Maria', '1985-08-15', '98765432109', 'Feminino'),
  ('Pedro', '1993-02-22', '45678912304', 'Masculino'),
  ('Ana', '1998-11-05', '78901234506', 'Feminino'),
  ('Carlos', '1982-07-12', '23456789003', 'Masculino'),
  ('Laura', '1995-09-30', '56789012307', 'Feminino'),
  ('Lucas', '1987-04-18', '90123456708', 'Masculino'),
  ('Isabela', '1991-12-25', '34567890102', 'Feminino'),
  ('Gabriel', '1997-03-08', '67890123405', 'Masculino'),
  ('Lara', '1989-06-28', '01234567809', 'Feminino');
  #cpf válido
  INSERT INTO pessoa (nome, data_nascimento, cpf, genero) VALUES
  ('Renato', '1990-05-10', '22681429811', 'Masculino');
  select * from pessoa;
  
DELIMITER $$
CREATE FUNCTION validar_cpf(cpf VARCHAR(11))
RETURNS BOOLEAN
BEGIN
    DECLARE soma1 INT;
    DECLARE soma2 INT;
    DECLARE resto INT;
    DECLARE digito_verif1 INT;
    DECLARE digito_verif2 INT;
    DECLARE i INT;
    -- Remove caracteres não numéricos do CPF
    SET cpf = REPLACE(cpf, '.', '');
    SET cpf = REPLACE(cpf, '-', '');
    -- Verifica se o CPF possui 11 dígitos
    IF LENGTH(cpf) != 11 THEN
        RETURN FALSE;
    END IF;
    -- Verifica se todos os dígitos são iguais
    IF cpf REGEXP '^(.)\1+$' THEN
        RETURN FALSE;
    END IF;
    -- Calcula o primeiro dígito verificador
    SET soma1 = 0;
    SET digito_verif1 = SUBSTRING(cpf, 10, 1);
    set i = 1;
    WHILE i <= 9 DO
        SET soma1 = soma1 + SUBSTRING(cpf, i, 1) * (11 - i);
        SET i = i + 1;
    END WHILE;
    SET resto = (soma1 * 10) % 11;
    IF resto = 10 THEN
        SET resto = 0;
    END IF;
    IF resto != digito_verif1 THEN
        RETURN FALSE;
    END IF;
    -- Calcula o segundo dígito verificador
    SET soma2 = 0;
    SET digito_verif2 = SUBSTRING(cpf, 11, 1);
    SET i = 1;

    WHILE i <= 10 DO
        SET soma2 = soma2 + SUBSTRING(cpf, i, 1) * (12 - i);
        SET i = i + 1;
    END WHILE;
    SET resto = (soma2 * 10) % 11;
    IF resto = 10 THEN
        SET resto = 0;
    END IF;
    IF resto != digito_verif2 THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END$$
DELIMITER ;

SELECT cpf, validar_cpf(cpf) AS cpf_valido
FROM pessoa;