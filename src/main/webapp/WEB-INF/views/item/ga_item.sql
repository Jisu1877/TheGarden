show tables;

create table ga_item(
	item_idx 				INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	item_code				VARCHAR(20) NOT NULL,
	item_name				VARCHAR(255) NOT NULL,
	item_summary			VARCHAR(255) NOT NULL,
	display_flag			VARCHAR(1) NOT NULL DEFAULT 'y',
	sale_price				INT NOT NULL,
    seller_discount_flag	VARCHAR(1) NOT NULL,
    seller_discount_amount	INT,
	seller_point_flag		VARCHAR(1) NOT NULL,
    seller_point			INT,
	sold_out				VARCHAR(1) NOT NULL DEFAULT '0',
    stock_quantity			INT NOT NULL,
    stock_schedule_date		VARCHAR(20),
    order_min_quantity		INT NOT NULL,
	order_max_quantity		INT NOT NULL,
	sale_quantity			INT DEFAULT 0,
	item_option_flag		VARCHAR(1) NOT NULL DEFAULT 'n',
	detail_content_flag 	VARCHAR(1) NOT NULL,
	detail_content			MEDIUMTEXT,
	detail_content_image	VARCHAR(255),
	brand					VARCHAR(50),
	form					VARCHAR(50),
	item_model_name			VARCHAR(50) NOT NULL,
	origin_country			VARCHAR(50)	NOT NULL,
	after_service			VARCHAR(50)	NOT NULL,
	item_notice_idx			INT NOT NULL,
	item_image				VARCHAR(255) NOT NULL,
	shipment_address		VARCHAR(255) NOT NULL,
	shipment_return_address	VARCHAR(255) NOT NULL,
	shipment_type			VARCHAR(1) NOT NULL,
	shipping_price			INT NOT NULL,
	shipping_free_amount	INT NOT NULL,
	shipping_extra_charge	INT NOT NULL,
	item_return_flag		VARCHAR(1) NOT NULL DEFAULT 'y',
	shipping_return_price	INT NOT NULL,
	item_keyword			VARCHAR(255),
	created_admin_id		VARCHAR(20) NOT NULL,
	created_date			DATETIME NOT NULL DEFAULT now()
);

desc ga_item;


select Max(item_idx) as item_idx from ga_item


select * from ga_item as item JOIN ga_item_notice as notice ON item.item_idx = notice.item_idx where item_name like '%테스트%';