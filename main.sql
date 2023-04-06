create database if not exists `kaosrave`;

use `kaosrave`;

drop table if exists `ticket`;
drop table if exists `ticket_status`;
drop table if exists `batch`;
drop table if exists `event`;
drop table if exists `session`;
drop table if exists `user`;
drop table if exists `person`;

create table `person` (
    `id` integer unsigned not null auto_increment,
    `name` varchar(255) not null,
    `contact` varchar(255) not null,
    `pronouns` varchar(255),
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    index (`name`),
    primary key (`id`)
);

create table `user` (
    `id` integer unsigned not null auto_increment,
    `fk_person` integer unsigned not null,
    `username` varchar(255) not null unique,
    `password` varchar(255) not null,
    `password_update` tinyint(1) not null default 1,
    `active` tinyint(1) not null default 1,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    index (`username`),
    primary key (`id`),
    foreign key (`fk_person`) references `person` (`id`)
);

create table `session` (
    `id` integer unsigned not null auto_increment,
    `fk_user` integer unsigned not null,
    `refresh_token` varchar(255) not null,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    index (`refresh_token`),
    primary key (`id`),
    foreign key (`fk_user`) references `user` (`id`)
);

create table `event` (
    `id` integer unsigned not null auto_increment,
    `name` varchar(255) not null unique,
    `slug` varchar(255) not null unique,
    `location` varchar (255),
    `active` tinyint(1) not null,
    `date` datetime not null,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    index (`name`),
    index (`slug`),
    primary key (`id`)
);

create table `batch` (
    `id` integer unsigned not null auto_increment,
    `fk_event` integer unsigned not null,
    `name` varchar(255) not null,
    `price` double not null,
    `stock` integer unsigned not null,
    `active` tinyint(1) not null default 0,
    `date_start` datetime,
    `date_end` datetime,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    primary key (`id`),
    foreign key (`fk_event`) references `event` (`id`)
);

create table `ticket_status` (
    `id` integer unsigned not null auto_increment,
    `name` varchar(255) not null,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    primary key (`id`)
);

create table `ticket` (
    `id` integer unsigned not null auto_increment,
    `fk_event` integer unsigned not null,
    `fk_batch` integer unsigned not null,
    `fk_person` integer unsigned not null,
    `fk_ticket_status` integer unsigned not null,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    primary key (`id`),
    foreign key (`fk_event`) references `event` (`id`),
    foreign key (`fk_batch`) references `batch` (`id`),
    foreign key (`fk_person`) references `person` (`id`),
    foreign key (`fk_ticket_status`) references `ticket_status` (`id`)
);

-- CONSTANTS

insert into `ticket_status` (`id`, `name`) 
values
    (1, 'active'),
    (2, 'blocked'),
    (3, 'used');

-- BASE DATA

insert into `person` (`id`, `name`, `contact`)
values 
    (1, 'Santiago Taschetta', 'tsch.tt'),
    (2, 'Ivan Klecker', 'kleck.er'),
    (3, 'Facundo Scenna', '_fakito'),
    (4, 'Juma', '_clipperstealer');

insert into `user` (`id`, `fk_person`, `username`, `password`)
values 
    (1, 1, 'santi', '$2b$10$fvvNO0bQEpC5zwh1NEhVl.ALRdp.3PgTQlE8d5pn2DH0h88oeTqC2'),
    (2, 2, 'ivan', '$2b$10$fvvNO0bQEpC5zwh1NEhVl.ALRdp.3PgTQlE8d5pn2DH0h88oeTqC2'),
    (3, 3, 'fakito', '$2b$10$fvvNO0bQEpC5zwh1NEhVl.ALRdp.3PgTQlE8d5pn2DH0h88oeTqC2'),
    (4, 4, 'juma', '$2b$10$fvvNO0bQEpC5zwh1NEhVl.ALRdp.3PgTQlE8d5pn2DH0h88oeTqC2');

-- TEST DATA

insert into `event` (`id`, `name`, `slug`, `location`, `active`, `date`)
values
    (1, 'Kaos Bunker 2', 'kaos-bunker-2', 'Casa 12', 1, current_timestamp());

insert into `batch` (`id`, `fk_event`, `name`, `price`, `stock`, `active`)
values
    (1, 1, 'Primera Tanda', 1000, 50, 0),
    (2, 1, 'Segunda Tanda', 1500, 50, 0),
    (3, 1, 'Tercera Tanda', 2000, 100, 1),
    (4, 1, 'Puerta', 2500, 100, 0);

insert into `person` (`id`, `name`, `contact`)
values
    (5, 'Juan Gomex', 'gomex'),
    (6, 'Lucia Parra', 'ciparra'),
    (7, 'Pedro Perez', 'pepe_z'),
    (8, 'Juliana Arepa', 'arepa_pa'),
    (9, 'Ramiro Amaraz', 'amaraz');
    
insert into `ticket` (`id`, `fk_event`, `fk_batch`, `fk_person`, `fk_ticket_status`)
values
    (1, 1, 1, 5, 1),
    (2, 1, 1, 6, 2),
    (3, 1, 2, 7, 1),
    (4, 1, 2, 8, 1),
    (5, 1, 3, 9, 3);