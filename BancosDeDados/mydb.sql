-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.36
create database mydb;
use mydb;
--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria` (
  `codigo` int NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





INSERT INTO `categoria` VALUES (1,'bebidas'),(2,'frutas'),(3,'carnes'),(4,'frios'),(5,'limpeza'),(6,'higiene'),(7,'roupas');




CREATE TABLE `fornecedor` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `bairro` varchar(60) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `telefone` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `fornecedor` VALUES (1,'AMBEV','Av. Amâncio Gaioli, 1493','Água Chata','SP',NULL),(2,'Natural da terra','Av. Kennedy, 782','Centro','SP',NULL),(3,'Swift','Av. Francisco Prestes Maia, 136','Centro','SP',NULL),(4,'Hering','Av. Senador Vergueiro, 4190','Rudge Ramos','SP','(11) 2988-2969'),(5,'Limpeza Net Descartáveis E Utilidades','Av. Senador Vergueiro, 4147','Rudge Ramos','SP','(11) 4368-9715');

CREATE TABLE `produto` (
  `codigo` int NOT NULL,
  `nomeprod` varchar(100) DEFAULT NULL,
  `estoque` int DEFAULT NULL,
  `codcategoria` int NOT NULL,
  `codfornecedor` int NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_produto_categoria_idx` (`codcategoria`),
  KEY `fk_produto_fornecedor1_idx` (`codfornecedor`),
  CONSTRAINT `fk_produto_categoria` FOREIGN KEY (`codcategoria`) REFERENCES `categoria` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_fornecedor1` FOREIGN KEY (`codfornecedor`) REFERENCES `fornecedor` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Dumping data for table `produto`
--

INSERT INTO `produto` VALUES (1,'skol',1000,1,1),(2,'Brahma',2000,1,1),(3,'Sukita',200,1,1),(4,'Guaraná Antártica',500,1,1),(5,'Banana',50,2,2),(6,'Maçã',70,2,2),(7,'uva',30,2,2),(8,'alcatra',20,3,3),(9,'maminha',15,3,3),(10,'carne moída',30,3,3),(11,'camiseta',5,7,4),(12,'bermuda',7,7,4),(13,'boné',3,7,4),(14,'sabonete',100,6,5),(15,'detergente',200,5,5);

