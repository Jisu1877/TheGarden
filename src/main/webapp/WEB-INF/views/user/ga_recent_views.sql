CREATE TABLE ga_recent_views (
	recent_views_idx 	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_idx			INT NOT NULL,
    item_idx			INT NOT NULL,
    recent_date			DATETIME NOT NULL DEFAULT now(),
	foreign key(user_idx) references ga_user(user_idx),
    foreign key(item_idx) references ga_item(item_idx)
);

drop table ga_recent_views;