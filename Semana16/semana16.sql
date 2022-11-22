
CREATE TABLE foo (oldjson char(250));
# O JSON foi incluído num campo do tipo VARCHAR. 
# Fazendo isso o MySQL não vai entender que este campo é do tipo JSON
INSERT INTO foo VALUES ('{"name":"Bond","first":"James","ID":"007"}');
SELECT * FROM foo;

#Temos que criar a tabela de uma forma diferente, para que o MySQL entenda
# que a coluna é do tipo JSON. 
CREATE TABLE bar (our_data JSON);
#Inserindo o mesmo valor
INSERT INTO bar VALUES ('{"name":"Bond","first":"James","ID":"007"}');
#Se executamos a consulta abaixo o JSON é exibido, mas de forma desorganizada
SELECT * FROM bar;

#se executarmos usando a função apropriada o JSON será criado de forma correta
SELECT JSON_PRETTY(our_data) FROM bar;

INSERT INTO foo VALUES ('{"name":"Smart","first":"Maxwell","ID":"86"');
INSERT INTO bar VALUES ('{"name":"Smart","first":"Maxwell","ID":"86"');
INSERT INTO bar VALUES ('{"name":"Smart","first":"Maxwell","ID":"86"}');

SELECT * FROM bar;
#importar o banco de dados world_x_v2.sql em
#https://github.com/renatobdo/BD2/blob/main/Semana16/world_x_v2.sql


#Execute a consulta abaixo para entender o campo JSON que será usado nos próximos testes
SELECT DOC FROM countryinfo WHERE _id = 'USA';
#A função abaixo mostra o nome das propriedades existentes no campo JSON
SELECT JSON_KEYS(doc) FROM countryinfo WHERE _id = 'USA';
#Podemos extrair o valor de uma propriedade do campo JSON:
SELECT JSON_KEYS(doc, "$.geography") FROM countryinfo WHERE _id = 'USA';
#Ou então um valor de uma propriedade dentro de outra propriedade
SELECT JSON_EXTRACT(doc, "$.government.HeadOfState") FROM countryinfo WHERE _id = 'USA';
#Execute o SQL abaixo para ver todas as propriedades do JSON
SELECT JSON_EXTRACT(doc, "$.GNP") as GNP
  , JSON_EXTRACT(doc, "$.Code") as Code
  , JSON_EXTRACT(doc, "$.Name") as Name
  , JSON_EXTRACT(doc, "$.IndepYear") as IndepYear
  , JSON_EXTRACT(doc, "$.geography.Region") as Region
  , JSON_EXTRACT(doc, "$.geography.Continent") as Continent
  , JSON_EXTRACT(doc, "$.geography.SurfaceArea") as SurfaceArea
  , JSON_EXTRACT(doc, "$.government.HeadOfState") as HeadOfState
  , JSON_EXTRACT(doc, "$.government.GovernmentForm") as GovernmentForm
  , JSON_EXTRACT(doc, "$.demographics.Population") as Population
  , JSON_EXTRACT(doc, "$.demographics.LifeExpectancy") as LifeExpectancy
  FROM countryinfo;

#Os campos extraídos podem fazer parte de uma consulta grupando linhas de uma tabela
SELECT JSON_EXTRACT(doc, "$.geography.Continent") as Continent,
SUM(JSON_EXTRACT(doc, "$.demographics.Population")) as Population,
AVG(JSON_EXTRACT(doc, "$.demographics.LifeExpectancy")) FROM countryinfo
GROUP BY JSON_EXTRACT(doc, "$.geography.Continent")
ORDER BY 2;

#Também podemos usar os valores extraídos em filtros na tabela
SELECT JSON_EXTRACT(doc, "$.geography.Continent") as Continent,
SUM(JSON_EXTRACT(doc, "$.demographics.Population")) as Population,
AVG(JSON_EXTRACT(doc, "$.demographics.LifeExpectancy")) FROM countryinfo
WHERE JSON_EXTRACT(doc, "$.government.GovernmentForm") LIKE ('%Monarchy%')
AND JSON_EXTRACT(doc, "$.demographics.Population") >= 10000000
GROUP BY JSON_EXTRACT(doc, "$.geography.Continent")
ORDER BY 2;

#Crie uma nova tabela
CREATE TABLE X (Y JSON);
INSERT INTO X VALUES ('{"nome":"Joao", "telefone":"2293-3343"}');
# usuário sem telefone:
INSERT INTO X VALUES ('{"nome":"Jonas"}');

select Y from X;

#A função abaixo mostra se uma determinada propriedade existe no campo JSON
SELECT JSON_CONTAINS_PATH(Y, "ONE", "$.telefone") FROM X;

#Faça as seguintes inclusões de novos campos na tabela 
#criada mesclando com consultas usando a função que determina se a propriedade existe no JSON
INSERT INTO X VALUES ('{"nome":"Alberto","endereco":"Rua X numero Y"}');
SELECT JSON_CONTAINS_PATH(Y, "ONE", "$.telefone") FROM X;

SELECT Y FROM X;

SELECT JSON_CONTAINS_PATH(Y, "ONE", "$.telefone", "$.endereco") FROM X;
INSERT INTO X VALUES ('{"nome":"Maria","endereco":"Rua X numero Y", "telefone":"2293-3343"}');
SELECT Y FROM X;
# Funciona como um OR:
SELECT JSON_CONTAINS_PATH(Y, "ONE", "$.telefone", "$.endereco") FROM X;
# Funciona como um AND o ALL:
SELECT JSON_CONTAINS_PATH(Y, "ALL", "$.telefone", "$.endereco") FROM X;


#buscar um valor de uma propriedade usamos a função 
SELECT * FROM X;
# Busca o conteúdo do JSON que possui esse valor
SELECT JSON_CONTAINS(Y, '"2293-3343"', "$.telefone") FROM X;
SELECT *  FROM X WHERE JSON_CONTAINS(Y, '"2293-3343"', "$.telefone") = 1;
SELECT *  FROM X WHERE JSON_EXTRACT(Y, "$.telefone") = '2293-3343';

# usando a JSON_SEARCH, achamos o valor em qualquer propriedade
SELECT JSON_SEARCH(Y, "ONE", "2293-3343"), Y FROM X;
INSERT INTO X VALUES ('{"nome":"Katia","endereco":"Rua X numero Y", "telefone":"2293-3343", "telefone2":"2293-3343"}');
SELECT * FROM X;

SELECT JSON_SEARCH(Y, "ONE", "2293-3343"), Y FROM X;
SELECT JSON_SEARCH(Y, "ALL", "2293-3343"), Y FROM X;


#Veja o seguinte JSON que representa a entidade “Trabalha_em” na nossa empresa que implementa projetos:
/*
{
  "Cpf_Funcionario": "111222333",
  "Numero_Projeto": "5",
  "Horas": 30
}
Construa a consulta SQL para obter a média de horas trabalhadas 
por projeto (Nome da tabela tb_object_trabalha_em e nome do campo JSONVALUE).

SELECT JSON_EXTRACT(JSONVALUE, "$.Numero_Projeto"), AVG(JSON_EXTRACT(JSONVALUE, "$.Horas")) FROM tb_object_trabalha_em
GROUP BY JSON_EXTRACT(JSONVALUE, "$.Numero_Projeto")
*/