-- For storing the important db queries --

-- CREATION QUERIES
-- admin table
CREATE TABLE `idealcrop`.`administrator` ( `id` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(128) NOT NULL , 
`email` VARCHAR(64) NOT NULL , `password` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , 
`updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`)) ENGINE = InnoDB;

-- password reset table
CREATE TABLE `idealcrop`.`password_reset` ( `id` INT NOT NULL AUTO_INCREMENT , `email` VARCHAR(64) NOT NULL , `token` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`)) ENGINE = InnoDB;

-- crop table
CREATE TABLE `idealcrop`.`crop` ( `id` INT NOT NULL AUTO_INCREMENT , `crop_name` VARCHAR(64) NOT NULL , `image` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `crop` ADD CONSTRAINT `admin_create_crop` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop` ADD CONSTRAINT `admin_update_crop` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- species table
CREATE TABLE `idealcrop`.`species` ( `id` INT NOT NULL AUTO_INCREMENT , `speicies_name` VARCHAR(64) NOT NULL , `crop` INT NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`))  ENGINE = InnoDB;
ALTER TABLE `species` ADD CONSTRAINT `admin_create_species` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `species` ADD CONSTRAINT `admin_update_species` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;ALTER TABLE `species` ADD CONSTRAINT `crop_name` FOREIGN KEY (`crop`) REFERENCES `crop`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- variety table
CREATE TABLE `idealcrop`.`variety` ( `id` INT(20) NOT NULL AUTO_INCREMENT , `species` INT NOT NULL , `variety_name` VARCHAR(64) NOT NULL , `year` YEAR NOT NULL , `owner` VARCHAR(64) NOT NULL , `maintainer` VARCHAR(64) NOT NULL , `optimal_production_altitude` VARCHAR(64) NOT NULL , `maturity_duration` VARCHAR(64) NOT NULL , `yield` VARCHAR(64) NOT NULL , `special_attributes` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `variety` ADD CONSTRAINT `species_name` FOREIGN KEY (`species`) REFERENCES `species`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `variety` ADD CONSTRAINT `admin_create_variety` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `variety` ADD CONSTRAINT `admin_update_variety` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- stage table
CREATE TABLE `idealcrop`.`stage` ( `id` INT NOT NULL AUTO_INCREMENT ,  `stage_name` VARCHAR(64) NOT NULL ,  `stage_description` VARCHAR(255) NOT NULL ,  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,  `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,  `created_by` INT NOT NULL ,  `last_updated_by` INT NOT NULL ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY  (`id`)) ENGINE = InnoDB;
ALTER TABLE `stage` ADD CONSTRAINT `admin_create_stage` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `stage` ADD CONSTRAINT `admin_update_stage` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- practice table
CREATE TABLE `idealcrop`.`practice` ( `id` INT NOT NULL AUTO_INCREMENT , `practice_name` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY  (`id`)) ENGINE = InnoDB;
ALTER TABLE `practice` ADD CONSTRAINT `admin_create_practice` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `practice` ADD CONSTRAINT `admin_update_practice` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- crop_practice table
CREATE TABLE `idealcrop`.`crop_practice` ( `id` INT NOT NULL AUTO_INCREMENT , `crop` INT NOT NULL , `stage` INT NOT NULL , `practice` INT NOT NULL , `practice_description` VARCHAR(255) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `crop_practice` ADD CONSTRAINT `crop__name` FOREIGN KEY (`crop`) REFERENCES `crop`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop_practice` ADD CONSTRAINT `stage_name` FOREIGN KEY (`stage`) REFERENCES `stage`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop_practice` ADD CONSTRAINT `practice_name` FOREIGN KEY (`practice`) REFERENCES `practice`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop_practice` ADD CONSTRAINT `admin_create_crop_practice` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `crop_practice` ADD CONSTRAINT `admin_update_crop_practice` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- region table
CREATE TABLE `idealcrop`.`region` ( `id` INT NOT NULL AUTO_INCREMENT , `region_name` VARCHAR(64) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `region` ADD CONSTRAINT `admin_create_region` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `region` ADD CONSTRAINT `admin_update_region` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- district table
CREATE TABLE `idealcrop`.`district` ( `id` INT NOT NULL AUTO_INCREMENT , `district_name` VARCHAR(128) NOT NULL , `region` INT NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `district` ADD CONSTRAINT `admin_create_district` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `district` ADD CONSTRAINT `admin_update_district` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT; ALTER TABLE `district` ADD CONSTRAINT `district_region` FOREIGN KEY (`region`) REFERENCES `region`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- crop_zone
CREATE TABLE `idealcrop`.`crop_zone` ( `id` INT NOT NULL AUTO_INCREMENT , `region` INT NOT NULL , `crop` INT NOT NULL , `crop_extras` VARCHAR(64) NULL DEFAULT NULL , `yield` VARCHAR(8) NOT NULL , `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` TIMESTAMP on update CURRENT_TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP , `created_by` INT NOT NULL , `last_updated_by` INT NOT NULL ,  `is_valid` BOOLEAN NOT NULL DEFAULT TRUE , PRIMARY KEY (`id`)) ENGINE = InnoDB;
ALTER TABLE `crop_zone` ADD  CONSTRAINT `crop_name_zone` FOREIGN KEY (`crop`) REFERENCES `crop`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;ALTER TABLE `crop_zone` ADD  CONSTRAINT `region_name` FOREIGN KEY (`region`) REFERENCES `region`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;ALTER TABLE `crop_zone` ADD  CONSTRAINT `admin_create_zone` FOREIGN KEY (`created_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;ALTER TABLE `crop_zone` ADD  CONSTRAINT `admin_update_zone` FOREIGN KEY (`last_updated_by`) REFERENCES `administrator`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- INSERTION QUERIES
-- Insert admins
INSERT INTO `administrator` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Felix Wangota', 'wangottafelix@gmail.com', 'aaa', '2022-01-02 17:29:35', '2022-01-02 17:29:35'),
(2, 'Nicholas Kwizera', 'nicokwizera@gmail.com', 'asd', '2022-01-02 17:29:35', '2022-01-02 17:29:35'),
(3, 'Mujaidu Amutuhaire', 'amutuhaireguma10@gmail.com', 'asd', '2022-01-02 17:29:35', '2022-01-02 17:29:35'),
(4, 'Shariffa Nakasango', 'nakasherry13@gmail.com', 'asdasd', '2022-01-02 17:29:35', '2022-01-02 17:29:35');

-- Insert crops
INSERT INTO `crop` (`id`, `crop_name`, `image`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 'apple', '/apple.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(2, 'banana', '/banana.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(3, 'coconut', '/coconut.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(4, 'coffee', '/coffee.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(5, 'cotton', '/cotton.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(6, 'grapes', '/grapes.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(7, 'beans', '/beans.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(8, 'maize', '/maize.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(9, 'orange', '/orange.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(10, 'peas', '/peas.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(11, 'rice', '/rice.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1),
(12, 'watermelon', '/watermelon.jpg', '2022-01-09 08:54:17', '2022-01-09 08:54:17', 1, 1);

-- Dummy species
INSERT INTO `species` (`id`, `speicies_name`, `crop`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 'Zea Mays L', 8, '2022-01-04 01:48:54', '2022-01-04 01:48:54', 1, 1);

-- Dummy varieties
INSERT INTO `variety` (`id`, `species`, `variety_name`, `year`, `owner`, `maintainer`, `optimal_production_altitude`, `maturity_duration`, `yield`, `special_attributes`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 1, '1. White star ', 1960, 'NARO', 'NARO', '1000- 1600 ', '115', '2.5', 'Resistant to leaf rust, early maturity ', '2022-01-04 02:08:26', '2022-01-04 02:08:26', 1, 1),
(2, 1, '2. Western Queen ', 1960, 'NARO', 'NARO', '1000 - 1600 ', '100', '2.5', 'Resistant to leaf rust, early maturity ', '2022-01-04 02:08:26', '2022-01-04 02:08:26', 1, 1),
(3, 1, '3. Kawanda       Comp A. ', 1971, 'NARO', 'NARO', '1000 - 1600 ', '135 - 140 ', '3.4', 'Susceptible to MSV, tall and susceptible to  lodging ', '2022-01-04 02:08:26', '2022-01-04 02:08:26', 1, 1),
(4, 1, '4. Longe 1 ', 1991, 'NARO', 'NARO', '1000 - 1600 ', '115', '2.6', 'Resistant to MSV, drought tolerant, early maturity ', '2022-01-04 02:08:26', '2022-01-04 02:08:26', 1, 1),
(5, 1, '5. Longe 2 H      (Hybrid B) ', 1999, 'NARO', 'NARO', '1000 - 1600 ', '125', '3.4', 'Resistant to MSV, NLB, GLS and to storage pests, resistant to lodging, produces 2 cobs/ plant  ', '2022-01-04 02:08:26', '2022-01-04 02:08:26', 1, 1),
(6, 1, '6. Longe 3 H ', 1999, 'NARO', 'NARO', '1000 - 1600 ', '125', '0.9', 'Resistant to MSV, NLB, GLS and to storage pests, tendency to produce 2 cobs/plant ', '2022-01-04 02:08:26', '2022-01-04 02:08:26', 1, 1);

-- Dummy stages
INSERT INTO `stage` (`id`, `stage_name`, `stage_description`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 'Planting', 'Initial activities involving land preparation and preparation of seeds, cuttings, or tubers', '2022-01-07 09:37:36', '2022-01-07 09:37:36', 1, 1),
(2, 'Germination', 'Plants begin to develop while growing their first set of leaves', '2022-01-07 09:37:36', '2022-01-07 09:37:36', 1, 1),
(3, 'Vegetative', 'Plants undergo leafy growth for photosynethesis', '2022-01-07 09:37:36', '2022-01-07 09:37:36', 1, 1),
(4, 'Budding', 'Plants transition from growing leaves to forming buds', '2022-01-07 09:37:36', '2022-01-07 09:37:36', 1, 1),
(5, 'Flowering', 'Plants develop flowers for pollination purposes. For some, this is followed by development of fruits.', '2022-01-07 09:37:36', '2022-01-07 09:37:36', 1, 1);

-- Dummy practices
INSERT INTO `practice` (`id`, `practice_name`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 'Land Preparation', '2022-01-07 06:38:32', '2022-01-07 09:48:41', 1, 1),
(2, 'Sowing', '2022-01-07 06:39:29', '2022-01-07 09:48:47', 1, 1),
(3, 'Spacing', '2022-01-07 06:39:29', '2022-01-07 09:48:54', 1, 1),
(4, 'Mulching', '2022-01-07 06:39:29', '2022-01-07 09:48:58', 1, 1),
(6, 'Stalking', '2022-01-07 06:40:42', '2022-01-07 09:49:02', 1, 1),
(7, 'Prunning', '2022-01-07 06:44:15', '2022-01-07 09:49:08', 1, 1),
(8, 'Thinning', '2022-01-07 06:44:15', '2022-01-07 09:49:20', 1, 1);

-- Dummy crop_practices
INSERT INTO `crop_practice` (`id`, `crop`, `stage`, `practice`, `practice_description`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 8, 1, 1, '[Stage 1 Practice 1] Plough to loosen the top soil', '2022-01-07 09:52:59', '2022-01-07 15:00:10', 1, 1),
(2, 8, 1, 2, '[Stage 1 Practice 2] Plant 2-3 seeds together between  2-2.5 cm', '2022-01-07 09:52:59', '2022-01-07 15:00:49', 1, 1),
(3, 8, 1, 3, '[Stage 1 Practice 3] Space the holes for the seeds following 75 x 25 cm', '2022-01-07 09:52:59', '2022-01-07 15:01:25', 1, 1),
(4, 8, 2, 1, '[Stage 2 Practice 1] Plough to loosen the top soil', '2022-01-07 09:52:59', '2022-01-07 15:01:41', 1, 1),
(5, 8, 2, 2, '[Stage 2 Practice 2] Plant 2-3 seeds together between 2-2.5 cm', '2022-01-07 09:52:59', '2022-01-07 15:01:47', 1, 1),
(6, 8, 2, 3, '[Stage 2 Practice 3] Space the holes for the seeds following 75 x 25 cm', '2022-01-07 09:52:59', '2022-01-07 15:01:55', 1, 1),
(7, 8, 3, 1, '[Stage 3 Practice 1] Plough to loosen the top soil', '2022-01-07 09:52:59', '2022-01-07 15:02:08', 1, 1),
(8, 8, 3, 2, '[Stage 3 Practice 2] Plant 2-3 seeds together between 2-2.5 cm', '2022-01-07 09:52:59', '2022-01-07 15:02:26', 1, 1),
(9, 8, 3, 3, '[Stage 3 Practice 3] Space the holes for the seeds following 75 x 25 cm', '2022-01-07 09:52:59', '2022-01-07 15:02:32', 1, 1);

-- Insert regions
INSERT INTO `region` (`id`, `region_name`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 'S. Buganda', '2022-01-08 23:09:20', '2022-01-08 23:47:32', 1, 1),
(2, 'N. Buganda', '2022-01-08 23:09:20', '2022-01-08 23:46:17', 1, 1),
(3, 'Busoga', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(4, 'Bukedi', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(5, 'Elgon', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(6, 'Teso', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(7, 'Karamoja', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(8, 'Lango', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(9, 'Acholi', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(10, 'West Nile', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(11, 'Bunyoro', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(12, 'Tooro', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(13, 'Ankole', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1),
(14, 'Kigezi', '2022-01-08 23:09:20', '2022-01-08 23:09:20', 1, 1);

-- Insert districts
INSERT INTO `district` (`id`, `district_name`, `region`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 'Kalangala', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(2, 'Masaka', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(3, 'Mpigi', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(4, 'Rakai', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(5, 'Ssembabule', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(6, 'Wakiso', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(7, 'Lyantonde', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(8, 'Bukomansimbi', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(9, 'Butambala', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(10, 'Gomba', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(11, 'Kalungu', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(12, 'Lwengo', 1, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(13, 'Kiboga', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(14, 'Luwero', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(15, 'Mubende', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(16, 'Mukono', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(17, 'Nakasongola', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(18, 'Kayunga', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(19, 'Mityana', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(20, 'Nakaseke', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(21, 'Buikwe', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(22, 'Buvuma', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(23, 'Kyankwanzi', 2, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(24, 'Bugiri', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(25, 'Iganga', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(26, 'Jinja', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(27, 'Kamuli', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(28, 'Mayuge', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(29, 'Kaliro', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(30, 'Namutumba', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(31, 'Buyende', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(32, 'Luuka', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(33, 'Namayingo', 3, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(34, 'Busia', 4, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(35, 'Pallisa', 4, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(36, 'Tororo', 4, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(37, 'Budaka', 4, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(38, 'Butaleja', 4, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(39, 'Kibuku', 4, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(40, 'Kapchorwa', 5, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(41, 'Mbale', 5, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(42, 'Sironko', 5, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(43, 'Bududa', 5, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(44, 'Bukwo', 5, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(45, 'Manafwa', 5, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(46, 'Bulambuli', 5, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(47, 'Kween', 5, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(48, 'Katakwi', 6, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(49, 'Kumi', 6, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(50, 'Soroti', 6, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(51, 'Kaberamaido', 6, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(52, 'Amuria', 6, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(53, 'Bukedea', 6, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(54, 'Ngora', 6, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(55, 'Serere', 6, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(56, 'Kotido', 7, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(57, 'Moroto', 7, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(58, 'Nakapiripirit', 7, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(59, 'Abim', 7, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(60, 'Kaabong', 7, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(61, 'Amudat', 7, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(62, 'Napak', 7, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(63, 'Apac', 8, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(64, 'Lira', 8, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(65, 'Amolatar', 8, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(66, 'Dokolo', 8, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(67, 'Oyam', 8, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(68, 'Alebtong', 8, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(69, 'Kole', 8, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(70, 'Otuke', 8, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(71, 'Gulu', 9, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(72, 'Kitgum', 9, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(73, 'Pader', 9, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(74, 'Amuru', 9, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(75, 'Agago', 9, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(76, 'Lamwo', 9, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(77, 'Nwoya', 9, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(78, 'Omoro', 9, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(79, 'Adjumani', 10, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(80, 'Arua', 10, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(81, 'Moyo', 10, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(82, 'Nebbi', 10, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(83, 'Yumbe', 10, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(84, 'Koboko', 10, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(85, 'Maracha', 10, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(86, 'Zombo', 10, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(87, 'Hoima', 11, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(88, 'Kibaale', 11, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(89, 'Masindi', 11, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(90, 'Buliisa', 11, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(91, 'Kiryandongo', 11, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(92, 'Kagadi', 11, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(93, 'Kakumiro', 11, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(94, 'Bundibugyo', 12, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(95, 'Kabarole', 12, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(96, 'Kasese', 12, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(97, 'Kamwenge', 12, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(98, 'Kyenjojo', 12, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(99, 'Kyegegwa', 12, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(100, 'Bushenyi', 13, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(101, 'Mbarara', 13, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(102, 'Ntungamo', 13, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(103, 'Ibanda', 13, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(104, 'Isingiro', 13, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(105, 'Kiruhura', 13, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(106, 'Buhweju', 13, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(107, 'Sheema', 13, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(108, 'Kabale', 14, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(109, 'Kisoro', 14, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(110, 'Rukungiri', 14, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(111, 'Kanungu', 14, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(112, 'Mitooma', 14, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(113, 'Rubirizi', 14, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1),
(114, 'Rubanda', 14, '2022-01-09 00:49:53', '2022-01-09 00:49:53', 1, 1);

-- Dummy zones
INSERT INTO `crop_zone` (`id`, `region`, `crop`, `crop_extras`, `yield`, `created_at`, `updated_at`, `created_by`, `last_updated_by`) VALUES
(1, 1, 8, NULL, '1.607', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(2, 2, 8, NULL, '1.471', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(3, 3, 8, NULL, '1.112', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(4, 4, 8, NULL, '1.212', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(5, 5, 8, NULL, '1.287', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(6, 6, 8, NULL, '0.943', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(7, 7, 8, NULL, '1.241', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(8, 8, 8, NULL, '1.29', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(9, 9, 8, NULL, '0.923', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(10, 10, 8, NULL, '1.307', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(11, 11, 8, NULL, '1.453', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(12, 12, 8, NULL, '1.931', '2022-01-09 00:56:52', '2022-01-09 00:56:52', 1, 1),
(13, 13, 8, NULL, '1.921', '2022-01-09 00:56:53', '2022-01-09 00:56:53', 1, 1),
(14, 14, 8, NULL, '1.179', '2022-01-09 00:56:53', '2022-01-09 00:56:53', 1, 1);

