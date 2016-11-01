-- MySQL Script generated by MySQL Workbench
-- Tue 01 Nov 2016 05:17:46 PM CDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `vitae` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `vitae_UNIQUE` (`vitae` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`clans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`clans` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paths`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paths` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`players` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `age_id` INT NOT NULL,
  `clan_id` INT NOT NULL,
  `path_id` INT NOT NULL,
  PRIMARY KEY (`id`, `age_id`, `clan_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Players_Ages_idx` (`age_id` ASC),
  INDEX `fk_Players_Clans1_idx` (`clan_id` ASC),
  INDEX `fk_Players_Paths1_idx` (`path_id` ASC),
  CONSTRAINT `fk_Players_Ages`
    FOREIGN KEY (`age_id`)
    REFERENCES `mydb`.`ages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Players_Clans1`
    FOREIGN KEY (`clan_id`)
    REFERENCES `mydb`.`clans` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Players_Paths1`
    FOREIGN KEY (`path_id`)
    REFERENCES `mydb`.`paths` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`points`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`points` (
  `id` INT NOT NULL,
  `point` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `point_UNIQUE` (`point` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`skills` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `point_id` INT NOT NULL,
  PRIMARY KEY (`id`, `point_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Skills_Points1_idx` (`point_id` ASC),
  CONSTRAINT `fk_Skills_Points1`
    FOREIGN KEY (`point_id`)
    REFERENCES `mydb`.`points` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`assets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`assets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`asset_levels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`asset_levels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `level` INT NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `asset_id` INT NOT NULL,
  PRIMARY KEY (`id`, `asset_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Levels_Assets1_idx` (`asset_id` ASC),
  CONSTRAINT `fk_Levels_Assets1`
    FOREIGN KEY (`asset_id`)
    REFERENCES `mydb`.`assets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`disciplines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplines` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`discipline_levels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`discipline_levels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `level` INT NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `discipline_id` INT NOT NULL,
  PRIMARY KEY (`id`, `discipline_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_discipline_dots_disciplines1_idx` (`discipline_id` ASC),
  CONSTRAINT `fk_discipline_dots_disciplines1`
    FOREIGN KEY (`discipline_id`)
    REFERENCES `mydb`.`disciplines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`player_disciplines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`player_disciplines` (
  `player_id` INT NOT NULL,
  `discipline_level_id` INT NOT NULL,
  `discipline_id` INT NOT NULL,
  INDEX `fk_player_assets_players1_idx` (`player_id` ASC),
  PRIMARY KEY (`discipline_level_id`, `discipline_id`),
  CONSTRAINT `fk_player_assets_players1`
    FOREIGN KEY (`player_id`)
    REFERENCES `mydb`.`players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_assets_discipline_levels1`
    FOREIGN KEY (`discipline_level_id` , `discipline_id`)
    REFERENCES `mydb`.`discipline_levels` (`id` , `discipline_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`influences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`influences` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`player_assests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`player_assests` (
  `players_id` INT NOT NULL,
  `asset_level_id` INT NOT NULL,
  `asset_id` INT NOT NULL,
  `influences_id` INT NOT NULL,
  INDEX `fk_player_assets_players1_idx` (`players_id` ASC),
  PRIMARY KEY (`asset_level_id`, `asset_id`, `influences_id`),
  INDEX `fk_player_assests_influences1_idx` (`influences_id` ASC),
  CONSTRAINT `fk_player_assets_players10`
    FOREIGN KEY (`players_id`)
    REFERENCES `mydb`.`players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_disciplines_copy1_asset_levels1`
    FOREIGN KEY (`asset_level_id` , `asset_id`)
    REFERENCES `mydb`.`asset_levels` (`id` , `asset_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_assests_influences1`
    FOREIGN KEY (`influences_id`)
    REFERENCES `mydb`.`influences` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`influences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`influences` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`player_influences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`player_influences` (
  `players_id` INT NOT NULL,
  `influence_id` INT NOT NULL,
  INDEX `fk_player_influences_players1_idx` (`players_id` ASC),
  PRIMARY KEY (`influence_id`, `players_id`),
  CONSTRAINT `fk_player_influences_players1`
    FOREIGN KEY (`players_id`)
    REFERENCES `mydb`.`players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_player_influences_influences1`
    FOREIGN KEY (`influence_id`)
    REFERENCES `mydb`.`influences` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
