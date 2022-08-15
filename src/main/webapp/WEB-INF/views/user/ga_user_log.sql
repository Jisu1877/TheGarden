show tables;

create table ga_user_log(
	log_idx 	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_idx 	INT NOT NULL,
	login_time	DATETIME NOT NULL DEFAULT now(),
	host_ip		varchar(255) NOT NULL,
	foreign key(user_idx) references ga_user(user_idx)
);

desc ga_user_log;