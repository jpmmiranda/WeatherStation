-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Leituras
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Leituras
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Leituras` DEFAULT CHARACTER SET utf8 ;
USE `Leituras` ;

-- -----------------------------------------------------
-- Table `Leituras`.`Local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Leituras`.`Local` (
  `Longitude` DECIMAL(11,8) NOT NULL,
  `Latitude` DECIMAL(10,8) NOT NULL,
  PRIMARY KEY (`Longitude`, `Latitude`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Leituras`.`Registos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Leituras`.`Registos` (
  `Temperatura` INT NULL,
  `Ruido` INT NULL,
  `Data` VARCHAR(45) NOT NULL,
  `Local_Longitude` DECIMAL(11,8) NOT NULL,
  `Local_Latitude` DECIMAL(10,8) NOT NULL,
  INDEX `fk_Registos_Local_idx` (`Local_Longitude` ASC, `Local_Latitude` ASC),
  CONSTRAINT `fk_Registos_Local`
    FOREIGN KEY (`Local_Longitude` , `Local_Latitude`)
    REFERENCES `Leituras`.`Local` (`Longitude` , `Latitude`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
