-- MySQL Script generated by MySQL Workbench
-- Fri Mar 31 19:42:57 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mercado
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mercado
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mercado` DEFAULT CHARACTER SET utf8 ;
USE `mercado` ;

-- -----------------------------------------------------
-- Table `mercado`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercado`.`Produtos` (
  `id` VARCHAR(3) NOT NULL,
  `descricao` VARCHAR(50) NULL,
  `estoque` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercado`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercado`.`Pedidos` (
  `id` INT NOT NULL,
  `quantidade` INT NULL,
  `Produtos_id` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id`),
  #INDEX `fk_Pedidos_Produtos_idx` (`Produtos_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Produtos`
    FOREIGN KEY (`Produtos_id`)
    REFERENCES `mercado`.`Produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;