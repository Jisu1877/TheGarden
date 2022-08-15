show tables;
create table ga_cart(
	cart_idx 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_idx		INT NOT NULL,
	item_idx		INT NOT NULL,
	user_id 		VARCHAR(20) NOT NULL,
	item_option_flag VARCHAR(1) NOT NULL,
	item_option_idx	INT,
	option_name		VARCHAR(255),
	option_price	INT,
	option_quantity	INT,
	total_quantity	INT NOT NULL,
	total_price		INT NOT NULL,
	shipping_group_code	TEXT NOT NULL,
	sold_out				VARCHAR(1) NOT NULL DEFAULT '0',
	created_date DATETIME NOT NULL DEFAULT now(),
	foreign key(user_idx) references ga_user(user_idx),
	foreign key(item_idx) references ga_item(item_idx)
);

desc ga_cart;

drop table ga_cart;