CREATE TABLE ga_save_point(
	save_point_idx 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_idx			INT NOT NULL,
    save_point_amount 	INT NOT NULL,
    save_reason			VARCHAR(255) NOT NULL,
    order_idx			INT,
    admin_id			VARCHAR(20),
    created_date 		DATETIME NOT NULL DEFAULT now(),
    foreign key(user_idx) references ga_user(user_idx)
);


CREATE TABLE ga_use_point(
	use_point_idx		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_idx			INT NOT NULL,
    use_point_amount 	INT NOT NULL,
    order_idx			INT,
    created_date 		DATETIME NOT NULL DEFAULT now(),
    foreign key(user_idx) references ga_user(user_idx)
);