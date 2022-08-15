CREATE TABLE ga_notice (
	notice_idx		 	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	notice_title		VARCHAR(255) NOT NULL,
	notice_content		MEDIUMTEXT NOT NULL,
    popup_yn			VARCHAR(1) NOT NULL,
    create_date			DATETIME NOT NULL DEFAULT now()
);