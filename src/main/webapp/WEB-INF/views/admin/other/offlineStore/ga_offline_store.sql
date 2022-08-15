CREATE TABLE ga_offline_store (
	offline_store_idx 	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	store_name			VARCHAR(20) NOT NULL,
	store_tel			VARCHAR(20) NOT NULL,
    lat					text NOT NULL,
    lng					text NOT NULL,
    rode_address		text NOT NULL,
    address				text NOT NULL,
    create_date			DATETIME NOT NULL DEFAULT now()
);