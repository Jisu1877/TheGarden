show tables;
create table ga_user(
	user_idx 	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id 	VARCHAR(20) NOT NULL,
    user_pwd 	VARCHAR(255) NOT NULL,
    name 		VARCHAR(20) NOT NULL,
    gender		VARCHAR(1) NOT NULL DEFAULT 'm',
    email		VARCHAR(60) NOT NULL,
    tel			VARCHAR(20) NOT NULL,
    status_code INT NOT NULL DEFAULT 9,
    login_count INT DEFAULT 0,
    buy_count 	INT DEFAULT 0,
    buy_price	INT DEFAULT 0,
    level		INT DEFAULT 2,
    point		INT DEFAULT 500,
    seller_yn	VARCHAR(1) NOT NULL DEFAULT 'n',
    agreement	INT DEFAULT 2,
    login_date	DATETIME DEFAULT now(),
    created_date DATETIME NOT NULL DEFAULT now(),
    updated_date DATETIME,
    deny_date DATETIME,
    leave_date DATETIME,
    leave_reason text
);

desc ga_user;

drop table ga_user;

select * from ga_user where user_id = 'admin';