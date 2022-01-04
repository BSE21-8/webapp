-- For storing the important db queries 

-- admin table
CREATE TABLE `idealcrop`.`administrator` ( `id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(128) NOT NULL , 
`email` VARCHAR(64) NOT NULL , `password` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , 
`updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , PRIMARY KEY (`id`)) ENGINE = InnoDB;

-- password reset table
CREATE TABLE `idealcrop`.`password_reset` ( `id` INT NOT NULL AUTO_INCREMENT , `email` VARCHAR(64) NOT NULL , `token` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , PRIMARY KEY (`id`)) ENGINE = InnoDB;

-- crop table
CREATE TABLE `idealcrop`.`crop` ( `id` INT NOT NULL AUTO_INCREMENT , `crop_name` VARCHAR(64) NOT NULL , `image` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `crop` ADD CONSTRAINT `admin_create_crop` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop` ADD CONSTRAINT `admin_update_crop` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- species table
CREATE TABLE `idealcrop`.`species` ( `id` INT NOT NULL AUTO_INCREMENT , `speicies_name` VARCHAR(64) NOT NULL , `crop` INT NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL, PRIMARY KEY (`id`))  ENGINE = InnoDB;
ALTER TABLE `species` ADD CONSTRAINT `admin_create_species` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `species` ADD CONSTRAINT `admin_update_species` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;ALTER TABLE `species` ADD CONSTRAINT `crop_name` FOREIGN KEY (`crop`) REFERENCES `crop`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- variety table
CREATE TABLE `idealcrop`.`variety` ( `id` INT(20) NOT NULL AUTO_INCREMENT , `species` INT NOT NULL , `variety_name` VARCHAR(64) NOT NULL , `year` YEAR NOT NULL , `owner` VARCHAR(64) NOT NULL , `maintainer` VARCHAR(64) NOT NULL , `optimal_production_altitude` VARCHAR(64) NOT NULL , `maturity_duration` VARCHAR(64) NOT NULL , `yield` VARCHAR(64) NOT NULL , `special_attributes` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `variety` ADD CONSTRAINT `species_name` FOREIGN KEY (`species`) REFERENCES `species`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `variety` ADD CONSTRAINT `admin_create_variety` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `variety` ADD CONSTRAINT `admin_update_variety` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- stage table
CREATE TABLE `idealcrop`.`stage` ( `id` INT NOT NULL AUTO_INCREMENT ,  `stage_name` VARCHAR(64) NOT NULL ,  `stage_description` VARCHAR(255) NOT NULL ,  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,  `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,  `created_by` INT NOT NULL ,  `last_updated_by` INT NOT NULL , PRIMARY KEY  (`id`)) ENGINE = InnoDB;
ALTER TABLE `stage` ADD CONSTRAINT `admin_create_stage` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `stage` ADD CONSTRAINT `admin_update_stage` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- practice table
CREATE TABLE `idealcrop`.`practice` ( `id` INT NOT NULL AUTO_INCREMENT , `practice_name` VARCHAR(255) NOT NULL , `practice_description` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL, PRIMARY KEY  (`id`)) ENGINE = InnoDB;
ALTER TABLE `practice` ADD CONSTRAINT `admin_create_practice` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `practice` ADD CONSTRAINT `admin_update_practice` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- crop_practice table
CREATE TABLE `idealcrop`.`crop_practice` ( `id` INT NOT NULL AUTO_INCREMENT , `crop` INT NOT NULL , `stage` INT NOT NULL , `practice` INT NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `crop_practice` ADD CONSTRAINT `crop__name` FOREIGN KEY (`crop`) REFERENCES `crop`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop_practice` ADD CONSTRAINT `stage_name` FOREIGN KEY (`stage`) REFERENCES `stage`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop_practice` ADD CONSTRAINT `practice_name` FOREIGN KEY (`practice`) REFERENCES `practice`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop_practice` ADD CONSTRAINT `admin_create_crop_practice` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop_practice` ADD CONSTRAINT `admin_update_crop_practice` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
