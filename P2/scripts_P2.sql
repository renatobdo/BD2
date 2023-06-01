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

drop function generate_password;
DELIMITER $$
CREATE FUNCTION generate_password(length INT) 
RETURNS VARCHAR(52)
BEGIN
    DECLARE npassword VARCHAR(52) DEFAULT '';
    DECLARE i INT DEFAULT 0;
    DECLARE allowed_chars VARCHAR(52) DEFAULT 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    DECLARE allowed_len INT DEFAULT LENGTH(allowed_chars);
    WHILE i < length DO
        SET npassword = CONCAT(npassword, SUBSTRING(allowed_chars, FLOOR(RAND()*allowed_len)+1, 1));
        SET i = i + 1;
    END WHILE;
    RETURN npassword;
END$$
DELIMITER ;

SELECT department_id, generate_password(department_id) AS password
FROM employees;

select * from countries;

CREATE TABLE contas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_conta VARCHAR(10) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL
);

INSERT INTO contas (numero_conta, saldo) VALUES
    ('123456', 1000.00),
    ('654321', 500.00),
    ('987654', 2000.00),
    ('456789', 1500.00),
    ('321654', 800.00);

SELECT * FROM contas;
DELIMITER $$
CREATE PROCEDURE realizar_transferencia(
    IN conta_origem VARCHAR(10),
    IN conta_destino VARCHAR(10),
    IN valor_transferencia DECIMAL(10, 2),
    OUT mensagem VARCHAR(100)
)
BEGIN
    DECLARE saldo_origem DECIMAL(10, 2);
    DECLARE count_destino INT;

    START TRANSACTION;

    -- Verifica se a conta de origem tem saldo suficiente
    SELECT saldo INTO saldo_origem FROM contas WHERE numero_conta = conta_origem;

    IF saldo_origem >= valor_transferencia THEN
        -- Atualiza o saldo da conta de origem
        UPDATE contas SET saldo = saldo - valor_transferencia WHERE numero_conta = conta_origem;

        -- Verifica se a conta de destino existe
        SELECT COUNT(*) INTO count_destino FROM contas WHERE numero_conta = conta_destino;

        IF count_destino > 0 THEN
            -- Atualiza o saldo da conta de destino
            UPDATE contas SET saldo = saldo + valor_transferencia WHERE numero_conta = conta_destino;
            SET mensagem = 'Transferência realizada com sucesso';
            COMMIT;
        ELSE
            -- Rollback da transação em caso de erro (conta de destino não encontrada)
            ROLLBACK;
            SET mensagem = 'Erro: Conta de destino não encontrada';
        END IF;
    ELSE
        -- Rollback da transação em caso de erro (saldo insuficiente)
        ROLLBACK;
        SET mensagem = 'Erro: Saldo insuficiente na conta de origem';
    END IF;
END$$
DELIMITER ;
CALL realizar_transferencia('123456', '654321', 100.00, @mensagem);
SELECT @mensagem AS status_transferencia;
select * from contas;

DELIMITER $$
CREATE FUNCTION dias_entre_datas(data_inicial DATE, data_final DATE)
RETURNS INT
BEGIN
    DECLARE numero_dias INT;
    SET numero_dias = DATEDIFF(data_final, data_inicial);
    RETURN numero_dias;
END$$
DELIMITER ;


drop table pacientes_cancer;
CREATE TABLE pacientes_cancer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_diagnostico DATE NOT NULL,
    data_de_alta DATE,
    status VARCHAR(20),
    tipo_cancer ENUM('leucemia linfoblástica B', 'linfoma não Hodgkin de células B', 'mieloma múltiplo') NOT NULL
);

INSERT INTO pacientes_cancer (nome, data_diagnostico, data_de_alta, status, tipo_cancer)
VALUES
    ('Sérgio Ramos', '2018-01-01', '2023-05-28', '', 'leucemia linfoblástica B'),
    ('Paulo Peregrinho', '2018-06-15', '2023-05-28', '', 'linfoma não Hodgkin de células B'),
    ('Mario Alves', '2020-03-10', '2023-05-28', '', 'mieloma múltiplo');
insert into pacientes_cancer (nome, data_diagnostico, data_de_alta, status, tipo_cancer)
VALUES  ('Mariano de Souza', '2015-03-10', '2018-05-28', '', 'mieloma múltiplo');

DELIMITER $$
CREATE FUNCTION verificar_cura(data_de_alta DATE) RETURNS VARCHAR(20)
BEGIN
    DECLARE cura_status VARCHAR(20);
    DECLARE data_verificacao DATE;

    SET data_verificacao = DATE_ADD(data_de_alta, INTERVAL 5 YEAR);

    IF (data_verificacao <= CURDATE()) THEN
        SET cura_status = 'cura';
    ELSE
        SET cura_status = 'remissão';
    END IF;

    RETURN cura_status;
END$$
DELIMITER ;

SELECT nome, data_de_alta, "como eu chamo a função verificar_cura sem erros?" AS status_cura
FROM pacientes_cancer;

