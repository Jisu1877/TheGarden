
drop table ga_review;

CREATE TABLE ga_review (
	review_idx 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    item_idx		INT NOT NULL,
    user_idx		INT NOT NULL,
	order_idx		INT NOT NULL,
    order_list_idx	INT NOT NULL,
    rating			INT NOT NULL,
    review_subject	VARCHAR(255) NOT NULL,
    review_contents	MEDIUMTEXT NOT NULL,
    photo			MEDIUMTEXT,
    delete_yn		VARCHAR(1) NOT NULL DEFAULT 'y',
    created_date 			DATETIME NOT NULL DEFAULT now(),
    foreign key(user_idx) references ga_user(user_idx),
    foreign key(item_idx) references ga_item(item_idx),
	foreign key(order_idx) references ga_order(order_idx),
	foreign key(order_list_idx) references ga_order_list(order_list_idx)
);