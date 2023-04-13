use `kaosrave`;

drop table if exists `ticket`;
drop table if exists `ticket_status`;
drop table if exists `batch`;
drop table if exists `event`;
drop table if exists `location`;
drop table if exists `session`;
drop table if exists `staff`;
drop table if exists `user`;
drop table if exists `person`;

create table `person` (
    `id` integer unsigned not null auto_increment,
    `name` varchar(255) not null,
    `contact` varchar(255),
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    index (`name`),
    primary key (`id`)
);

create table `user` (
    `id` integer unsigned not null auto_increment,
    `active` tinyint(1) not null default 1,
    `fk_person` integer unsigned not null,
    `username` varchar(255) not null unique,
    `password` varchar(255) not null,
    `password_update` tinyint(1) not null default 1,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    index (`username`),
    primary key (`id`),
    foreign key (`fk_person`) references `person` (`id`)
);

create table `staff` (
    `id` integer unsigned not null auto_increment,
    `active` tinyint(1) not null default 1,
    `fk_person` integer unsigned not null,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
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

create table `location` (
    `id` integer unsigned not null auto_increment,
    `name` varchar(255) not null,
    `address` varchar(255) not null,
    `link` varchar(255) not null,
    primary key (`id`)
);

create table `event` (
    `id` integer unsigned not null auto_increment,
    `active` tinyint(1) not null,
    `fk_location` integer unsigned not null,
    `name` varchar(255) not null unique,
    `slug` varchar(255) not null unique,
    `date` datetime not null,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    index (`name`),
    index (`slug`),
    primary key (`id`),
    foreign key (`fk_location`) references `location` (`id`)
);

create table `batch` (
    `id` integer unsigned not null auto_increment,
    `active` tinyint(1) not null,
    `name` varchar(255) not null,
    `value` double not null,
    `created_at` datetime not null default current_timestamp,
    `updated_at` datetime on update current_timestamp,
    primary key (`id`)
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
    `fk_ticket_status` integer unsigned not null default 1,
    `value` double not null,
    `notes` text,
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

insert into `batch` (`id`, `name`, `value`, `active`)
values
    (1, 'Tanda 1', 1800, 0),
    (2, 'Tanda 2', 2500, 0),
    (3, 'Tanda 3', 2500, 0),
    (4, 'Preventa', 1500, 0),
    (5, 'Puerta (transferencia)', 3500, 1),
    (6, 'Puerta (efectivo)', 3500, 1),
    (7, 'Comprobante', 0, 1),
    (8, 'Staff', 0),
    (9, 'Free', 0);

-- BASE DATA

insert into `person` (`id`, `name`, `contact`)
values 
    (1, 'Santiago Taschetta', 'tsch.tt'),
    (2, 'Ivan Klecker', 'kleck.er'),
    (3, 'Facundo Scenna', '_fakito'),
    (4, 'Juan Manuel Grasso', '_clipperstealer');


insert into `user` (`id`, `fk_person`, `username`, `password`)
values 
    (1, 1, 'santi', '$2b$10$fvvNO0bQEpC5zwh1NEhVl.ALRdp.3PgTQlE8d5pn2DH0h88oeTqC2'),
    (2, 2, 'ivan', '$2b$10$fvvNO0bQEpC5zwh1NEhVl.ALRdp.3PgTQlE8d5pn2DH0h88oeTqC2'),
    (3, 3, 'fakito', '$2b$10$fvvNO0bQEpC5zwh1NEhVl.ALRdp.3PgTQlE8d5pn2DH0h88oeTqC2'),
    (4, 4, 'juma', '$2b$10$fvvNO0bQEpC5zwh1NEhVl.ALRdp.3PgTQlE8d5pn2DH0h88oeTqC2');
