
USE TodoList;

 CREATE TABLE `Status` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
 CREATE TABLE `Task` (
    `description` VARCHAR(255) NOT NULL,
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `todo_id` bigint(20) NOT NULL,
    KEY `FK1460928652787` (`todo_id`),
    CONSTRAINT `FK1460928652787` FOREIGN KEY (`todo_id`) REFERENCES `TodoItem` (`id`),
    PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
 CREATE TABLE `TodoItem` (
    `completed` BIT NOT NULL,
    `dueDate` Date NOT NULL,
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `order` INT(10) NOT NULL,
    `status_id` bigint(20) NOT NULL,
    /* tasks one to Many */
    `title` VARCHAR(255) NOT NULL,
    `url` VARCHAR(255) NOT NULL,
    KEY `FK1460928652827` (`status_id`),
    CONSTRAINT `FK1460928652827` FOREIGN KEY (`status_id`) REFERENCES `Status` (`id`),
    PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 

