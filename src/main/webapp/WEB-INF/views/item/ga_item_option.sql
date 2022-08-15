show tables;

create table ga_item_option(
	item_option_idx			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    item_idx				INT NOT NULL,
	option_use_flag			VARCHAR(1) NOT NULL DEFAULT 'y',
    option_name				VARCHAR(255) NOT NULL,
	option_price			INT NOT NULL,
	option_stock_quantity	INT NOT NULL,
	option_sold_out			VARCHAR(1) NOT NULL DEFAULT '0',
	option_display_flag		VARCHAR(1) NOT NULL DEFAULT 'y',
	created_date 			DATETIME NOT NULL DEFAULT now(),
    foreign key(item_idx) references ga_item(item_idx)
);

desc ga_item_option;

create table ga_item_image(
	item_image_idx 	INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	item_idx		INT NOT NULL,
	image_name		VARCHAR(255) NOT NULL,
	created_date	DATETIME NOT NULL DEFAULT now(),
    foreign key(item_idx) references ga_item(item_idx)
);

desc ga_item_image;


create table ga_item_notice(
	item_notice_idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	item_idx		INT NOT NULL,
    notice_title1	VARCHAR(10) NOT NULL DEFAULT '품명/모델명',
	notice_value1	VARCHAR(255) NOT NULL DEFAULT '상품상세참조',
	notice_title2	VARCHAR(50) NOT NULL DEFAULT '법에 의한 인증, 허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항',
	notice_value2	VARCHAR(255) NOT NULL DEFAULT '해당없음',
	notice_title3	VARCHAR(10) NOT NULL DEFAULT '제조자(사)',
	notice_value3	VARCHAR(255) NOT NULL DEFAULT '상품상세참조',
	notice_title4	VARCHAR(10) NOT NULL DEFAULT '제조국',
	notice_value4	VARCHAR(255) NOT NULL DEFAULT '상품상세참조',
	notice_title5	VARCHAR(20) NOT NULL DEFAULT '소비자상담 관련 전화번호',
	notice_value5	VARCHAR(255) NOT NULL DEFAULT '상품상세참조',
	foreign key(item_idx) references ga_item(item_idx)
);

desc ga_item_notice;

drop table ga_item_notice;