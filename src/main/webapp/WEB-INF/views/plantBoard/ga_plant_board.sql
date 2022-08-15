CREATE TABLE ga_plant_board (
	plant_board_idx  	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_idx		 	INT NOT NULL,
    user_id 			VARCHAR(20) NOT NULL,
    email				VARCHAR(60) NOT NULL,
    title				VARCHAR(255) NOT NULL,
    content				MEDIUMTEXT NOT NULL,
    notice_yn			VARCHAR(1) NOT NULL DEFAULT 'n',
    admin_answer_yn			VARCHAR(1) NOT NULL DEFAULT 'n',
    write_date			DATETIME NOT NULL DEFAULT now(),
    foreign key(user_idx) references ga_user(user_idx)
);


CREATE TABLE ga_plant_board_reply (
	plant_board_reply_idx 	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	plant_board_idx		INT NOT NULL,
	user_id 			VARCHAR(20) NOT NULL,
    write_date			DATETIME NOT NULL DEFAULT now(),
    content				MEDIUMTEXT NOT NULL,
    level				INT NOT NULL,
    levelOrder			INT NOT NULL,
    foreign key(plant_board_idx) references ga_plant_board(plant_board_idx)
);