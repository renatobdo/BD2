#MySQL view and WITH CHECK OPTION example
#https://www.mysqltutorial.org/mysql-view-with-check-option/ 
CREATE OR REPLACE VIEW vps AS
    SELECT 
        employeeNumber,
        lastname,
        firstname,
        jobtitle,
        extension,
        email,
        officeCode,
        reportsTo
    FROM
        employees
    WHERE
        jobTitle LIKE '%VP%';

#consultando a view
#Como a view vps é uma view simples ela é atualizável
SELECT * FROM vps;

#  Inserindo na tabela employees através da view vps
INSERT INTO vps(
    employeeNumber,
    firstName,
    lastName,
    jobTitle,
    extension,
    email,
    officeCode,
    reportsTo
) 
VALUES(
    1703,
    'Lily',
    'Bush',
    'IT Manager',
    'x9111',
    'lilybush@classicmodelcars.com',
    1,
    1002
);

# Ao realizarmos a consulta abaixo podemos ver o valor inserido na tabela employees pela view vps
SELECT 
   * 
FROM 
   employees
ORDER BY 
   employeeNumber DESC;

# Para não permitir isso utilizamos a cláusula WITH CHECK OPTION
CREATE OR REPLACE VIEW vps AS
    SELECT 
        employeeNumber,
        lastName,
        firstName,
        jobTitle,
        extension,
        email,
        officeCode,
        reportsTo
    FROM
        employees
    WHERE
        jobTitle LIKE '%VP%' 
WITH CHECK OPTION;

# Iremos inserir novamente na tabela employees pela view vps
INSERT INTO vps(employeeNumber,firstname,lastname,jobtitle,extension,email,officeCode,reportsTo)
VALUES(1704,'John','Smith','IT Staff','x9112','johnsmith@classicmodelcars.com',1,1703);

# O seguinte erro irá ser mostrado
#Error Code: 1369. CHECK OPTION failed 'classicmodels.vps'

# Caso tentarmos inserir um registro que contenha VP no cargo iremos conseguir inserir na tabela employee pela view vps
INSERT INTO vps(employeeNumber,firstname,lastname,jobtitle,extension,email,officeCode,reportsTo)
VALUES(1704,'John','Smith','SVP Marketing','x9112','johnsmith@classicmodelcars.com',1,1076);

# Ao consultarmos na view verificamos que o registro foi inserido pois contém VP no cargo
SELECT * FROM vps;
