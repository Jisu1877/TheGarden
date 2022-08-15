CREATE TABLE ga_wishlist (
	wishlist_idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_idx	 INT NOT NULL,
    item_idx	 INT NOT NULL,
    foreign key(user_idx) references ga_user(user_idx),
    foreign key(item_idx) references ga_item(item_idx)
);