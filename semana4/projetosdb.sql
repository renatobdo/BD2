# Database utilizado para os exemplos com subqueries
create database projetos;
use projetos;
#
create table projetos (id int,
titulo varchar(45),
datap date,
url varchar(100));
#
create table usuario (id int,
nome varchar(45),
email varchar(45),
senha varchar(45));
#
create table comentario(id int,
comentario text,
datac date,
id_usuario int,
id_projeto int);
#
create table likes_por_projeto(id_projeto int,
id_usuario int);
#
create table likes_por_comentario(id_usuario int,
id_comentario int);
#
alter table projetos add primary key (id);
alter table comentario add primary key (id);
alter table comentario add foreign key (id_projeto) references projetos(id);
alter table usuario add primary key(id);
alter table comentario add foreign key (id_usuario) references usuario(id);

alter table likes_por_projeto add primary key(id_projeto,id_usuario);
alter table likes_por_projeto add foreign key (id_projeto) references projetos(id);
alter table likes_por_projeto add foreign key (id_usuario) references usuario(id);

alter table likes_por_comentario add primary key(id_usuario,id_comentario);
alter table likes_por_comentario add foreign key (id_usuario) references usuario(id);
alter table likes_por_comentario add foreign key (id_comentario) references comentario(id);

insert into projetos (id, titulo, datap) values (1, 'Aplicação C#', '2018-04-01'),
(2, 'Aplicação Ionic', '2018-05-07'),
(3, 'Aplicação Python', '2018-08-05');

insert into usuario (id, nome, email, senha) values
	(1, 'Bruna Luiza', 'bruninha@gmail.com', 'abc123.'),
    (2, 'Thiago Braga', 'thiagobraga_1@hotmail.com', 'pena093'),
    (3, 'Osvaldo Justino', 'osvaltino@yahoo.com.br', 'osvaldit1_s'),
    (4, 'Gabriel Fernando', 'gabriel_fnd@gmail.com', 'gabss34');
insert into usuario (id, nome, email, senha) values
	(7, 'Renato Bueno', 'renatobdo@gmail.com','1234');

insert into comentario (id, comentario, id_projeto, id_usuario) 
	values (1, 'A Microsoft acertou com essa linguagem', 1, 1),
(2, 'Parabéns pelo projeto!bem legal!',1, 3),
(3, 'Super interessante! Fácil e rápido!',2, 4),
(4, 'Cara, que simples fazer um app assim!',2, 1),
(5, 'Linguagem muito diferente.',3, 3),
(6, 'Adorei aprender Python! Parabéns!',3, 2),
(7, 'Muito maneiro esse framework!',2, 2);


    
insert into likes_por_projeto(id_projeto, id_usuario) values
	(1,1),
    (1,3),
    (2,1),
    (2,2),
    (2,3),
    (2,4),
    (3,2);
#    
insert into likes_por_comentario(id_usuario, id_comentario) values
	(7,1),
    (7,2),
    (7,4);