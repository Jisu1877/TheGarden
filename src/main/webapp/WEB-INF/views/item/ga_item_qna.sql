CREATE TABLE ga_item_qna (
	item_qna_idx 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_idx			INT NOT NULL,
    item_idx			INT NOT NULL,
    item_qna_content	MEDIUMTEXT NOT NULL,
    view_yn				VARCHAR(1) NOT NULL,
    item_qna_pwd		VARCHAR(255),
    write_date			DATETIME NOT NULL DEFAULT now(),
    admin_answer_yn		VARCHAR(1) NOT NULL DEFAULT 'n',
    admin_answer		MEDIUMTEXT,
	foreign key(user_idx) references ga_user(user_idx),
    foreign key(item_idx) references ga_item(item_idx)
);