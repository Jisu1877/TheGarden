show tables;

create table ga_category_group(
	category_group_idx 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	category_group_code		varchar(8) NOT NULL UNIQUE,
	category_group_name		varchar(10) NOT NULL,
	category_group_use_yn	varchar(1) NOT NULL DEFAULT 'y',
	category_group_level	INT NOT NULL
);

desc ga_category_group;

select * from ga_category_group where category_group_use_yn = 'y';

select g.*, c.* from ga_category_group g
LEFT JOIN ga_category c ON g.category_group_idx = c.category_group_idx
order by category_group_use_yn desc, category_group_level

create table ga_category(
	category_idx 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	category_group_idx  INT NOT NULL,
	category_name		varchar(10) NOT NULL,
	category_use_yn	varchar(1) NOT NULL DEFAULT 'y',
	foreign key(category_group_idx) references ga_category_group(category_group_idx)
);

desc ga_category;

select * from ga_category_group where category_group_use_yn = 'y'order by category_group_level;