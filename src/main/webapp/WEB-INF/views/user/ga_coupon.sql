CREATE TABLE ga_coupon(
	coupon_idx				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    coupon_explan 			VARCHAR(255) NOT NULL,
    discount_rate			INT NOT NULL,
    coupon_period			INT NULL NULL
);


CREATE TABLE ga_coupon_user(
	coupon_user_idx 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_idx				INT NOT NULL,
    coupon_idx				INT NOT NULL,
    reason	 				VARCHAR(255) NOT NULL,
    expiry_date				VARCHAR(255) NOT NULL,
    use_flag				VARCHAR(1) NOT NULL DEFAULT 'n',
	created_date 			DATETIME NOT NULL DEFAULT now(),
	foreign key(user_idx) references ga_user(user_idx),
	foreign key(coupon_idx) references ga_coupon(coupon_idx)
);

delete from ga_coupon;

insert into ga_coupon values (DEFAULT, '첫구매 10% 할인쿠폰', 10, 30);

insert into ga_coupon values (DEFAULT, '10만원 이상 구매 10% 할인쿠폰', 10, 30);