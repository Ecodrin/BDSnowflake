insert into dim_material (name)
select distinct product_material from mock_data;


insert into dim_brand (name)
select distinct product_brand from mock_data;


insert into dim_address (country, postal_code)
select distinct customer_country, customer_postal_code from mock_data;


insert into dim_address (country, city, state, address)
select distinct store_country, store_city, store_state, store_location from mock_data;


insert into dim_address (country, city, address)
select distinct supplier_country, supplier_city, supplier_address from mock_data;

insert into dim_customer (first_name, last_name, age, email, location_id)
select distinct 
	md.customer_first_name, 
	md.customer_last_name,
	md.customer_age,
	md.customer_email,
	dl.id
from mock_data md 
left join dim_address dl on md.customer_country = dl.country 
		and md.customer_postal_code = dl.postal_code;

insert into dim_pet (type, name, breed, customer_id)
select distinct
	md.customer_pet_type, 
	md.customer_pet_name, 
	md.customer_pet_breed,
	dc.id
from mock_data md 
left join dim_customer dc on md.customer_email = dc.email;


insert into dim_seller (first_name, last_name, email, location_id)
select distinct 
	md.seller_first_name, 
	md.seller_last_name,
	md.seller_email,
	dl.id
from mock_data md 
left join dim_address dl on md.seller_country = dl.country 
		and md.seller_postal_code = dl.postal_code;


insert into dim_store (name, address_id, phone, email)
select distinct 
	md.store_name,
	da.id,
	md.store_phone,
	md.store_email 
from mock_data md
left join dim_address da on md.store_country = da.country
					and md.store_city = da.city
					and md.store_state = da.state
					and md.store_location = da.address;

insert into dim_supplier (name, contact, email, phone, address_id)
select distinct
	md.supplier_name,
	md.supplier_contact,
	md.supplier_email,
	md.supplier_phone,
	da.id
from mock_data md
left join dim_address da on md.supplier_country = da.country
					and md.supplier_city = da.city
					and md.supplier_address = da.address;


insert into dim_product (name, category, price, quantity, pet_category, 
						weight, color, size, description, rating, reviews, 
						release_date, expiry_date, material_id, brandim_id)
select distinct 
	md.product_name,
	md.product_category,
	md.product_price,
	md.product_quantity,
	md.pet_category,
	md.product_weight,
	md.product_color,
	md.product_size,
	md.product_description,
	md.product_rating,
	md.product_reviews,
	to_date(md.product_release_date, 'mm/dd/yyyy'),
	to_date(md.product_expiry_date, 'mm/dd/yyyy'),
	dm.id,
	db.id
from mock_data md
left join dim_brand db on db.name = md.product_brand
left join dim_material dm on dm.name = md.product_material;

DROP TABLE IF EXISTS product_map;
create temp table if not exists product_map as 
select 
	dp.id, 
	dp.name,
	dp.price,
	dp.weight,
	dp.release_date,
	dp.expiry_date,
	db.name as brand
from dim_product dp
left join dim_brand db on dp.brandim_id = db.id;


insert into fact_sale (sale_date, customer_id, seller_id, product_id, 
					store_id, supplier_id, quantity, total_price)
select 
	to_date(md.sale_date, 'mm/dd/yyyy'),
	dc.id,
	ds.id,
	dp.id,
	dim_store.id,
	dim_supplier.id,
	md.sale_quantity,
	md.sale_total_price
from mock_data md
left join dim_customer dc on md.customer_email = dc.email
left join dim_seller ds on md.seller_email = ds.email
left join dim_store on md.store_email = dim_store.email
left join dim_supplier on md.supplier_email = dim_supplier.email 
left join product_map dp on dp.name = md.product_name
				and dp.price = md.product_price
				and dp.weight = md.product_weight
				and dp.release_date = to_date(md.product_release_date, 'mm/dd/yyyy')
				and dp.expiry_date = to_date(md.product_expiry_date, 'mm/dd/yyyy')
				and dp.brand = md.product_brand;
