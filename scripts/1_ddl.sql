CREATE TABLE if not exists public.mock_data(
	id integer NULL,
	customer_first_name VARCHAR(50) NULL,
	customer_last_name VARCHAR(50) NULL,
	customer_age integer NULL,
	customer_email VARCHAR(50) NULL,
	customer_country VARCHAR(50) NULL,
	customer_postal_code VARCHAR(50) NULL,
	customer_pet_type VARCHAR(50) NULL,
	customer_pet_name VARCHAR(50) NULL,
	customer_pet_breed VARCHAR(50) NULL,
	seller_first_name VARCHAR(50) NULL,
	seller_last_name VARCHAR(50) NULL,
	seller_email VARCHAR(50) NULL,
	seller_country VARCHAR(50) NULL,
	seller_postal_code VARCHAR(50) NULL,
	product_name VARCHAR(50) NULL,
	product_category VARCHAR(50) NULL,
	product_price real NULL,
	product_quantity integer NULL,
	sale_date VARCHAR(50) NULL,
	sale_customer_id integer NULL,
	sale_seller_id integer NULL,
	sale_product_id integer NULL,
	sale_quantity integer NULL,
	sale_total_price real NULL,
	store_name VARCHAR(50) NULL,
	store_location VARCHAR(50) NULL,
	store_city VARCHAR(50) NULL,
	store_state VARCHAR(50) NULL,
	store_country VARCHAR(50) NULL,
	store_phone VARCHAR(50) NULL,
	store_email VARCHAR(50) NULL,
	pet_category VARCHAR(50) NULL,
	product_weight real NULL,
	product_color VARCHAR(50) NULL,
	product_size VARCHAR(50) NULL,
	product_brand VARCHAR(50) NULL,
	product_material VARCHAR(50) NULL,
	product_description VARCHAR(1024) NULL,
	product_rating real NULL,
	product_reviews integer NULL,
	product_release_date VARCHAR(50) NULL,
	product_expiry_date VARCHAR(50) NULL,
	supplier_name VARCHAR(50) NULL,
	supplier_contact VARCHAR(50) NULL,
	supplier_email VARCHAR(50) NULL,
	supplier_phone VARCHAR(50) NULL,
	supplier_address VARCHAR(50) NULL,
	supplier_city VARCHAR(50) NULL,
	supplier_country VARCHAR(50) NULL
);


create table if not exists dim_address (
	id SERIAL primary key,
	country VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50),
	address VARCHAR(50),
	postal_code VARCHAR(50)
);


create table if not exists dim_customer (
	id SERIAL primary key,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	age INTEGER,
	email VARCHAR(50),
	location_id INTEGER references dim_address(id)
);

create table if not exists dim_pet (
	id SERIAL primary key,
	type VARCHAR(50),
	name VARCHAR(50),
	breed VARCHAR(50),
	customer_id INTEGER references dim_customer(id)
);

create table if not exists dim_seller (
	id SERIAL primary key,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	location_id INTEGER references dim_address(id)
);


create table if not exists dim_brand (
	id SERIAL primary key,
	name VARCHAR(50)
);

create table if not exists dim_material (
	id SERIAL primary key,
	name VARCHAR(50)
);

create table if not exists dim_supplier (
	id SERIAL primary key,
	name VARCHAR(50),
	contact VARCHAR(50),
	email VARCHAR(50),
	phone VARCHAR(50),
	address_id INTEGER references dim_address(id) 
);

create table if not exists dim_store (
	id SERIAL primary key,
	name VARCHAR(50),
	address_id INTEGER references dim_address(id),
	phone VARCHAR(50),
	email VARCHAR(50)
);

create table if not exists dim_product (
	id SERIAL primary key,
	name VARCHAR (50),
	category VARCHAR(50),
	price real,
	quantity INTEGER,
	pet_category VARCHAR(50),
	weight real,
	color VARCHAR(50),
	size VARCHAR(50),
	description TEXT,
	rating real,
	reviews INTEGER,
	release_date date,
	expiry_date date,
	material_id INTEGER references dim_material(id),
	brandim_id INTEGER references dim_brand(id)
	
);

create table if not exists fact_sale (
	id SERIAL primary key,
	sale_date date,
	customer_id INTEGER references dim_customer(id),
	seller_id INTEGER references dim_seller(id),
	product_id INTEGER references dim_product(id),
	store_id INTEGER references dim_store(id),
	supplier_id INTEGER references dim_supplier(id),
	quantity INTEGER,
	total_price real
);


copy mock_data from '/src_data/MOCK_DATA.csv'	  with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (1).csv' with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (2).csv' with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (3).csv' with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (4).csv' with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (5).csv' with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (6).csv' with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (7).csv' with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (8).csv' with (FORMAT csv, HEADER true);
copy mock_data from '/src_data/MOCK_DATA (9).csv' with (FORMAT csv, HEADER true);