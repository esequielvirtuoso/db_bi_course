-- varchar variable (tamanho que ocupa depende do tamanho do valor armazenado)
CREATE TABLE country (
	ct_id int NOT NULL PRIMARY KEY,
	ct_name varchar(50) NOT NULL
);

CREATE TABLE state (
	st_id int NOT NULL PRIMARY KEY,
	st_name varchar(100) NOT NULL,
	ct_id int NOT NULL FOREIGN KEY (ct_id) REFERENCES country(ct_id)
);

ALTER TABLE state
ADD st_initial varchar(2);

CREATE TABLE city (
	city_id int NOT NULL PRIMARY KEY,
	city_name varchar(100) NOT NULL,
	st_id int NOT NULL FOREIGN KEY (st_id) REFERENCES state(st_id)
);

CREATE TABLE address (
	add_id int NOT NULL PRIMARY KEY,
	add_street varchar(150) NOT NULL,
	add_number int NOT NULL,
	add_zip_code varchar(10) NOT NULL,
	city_id int NOT NULL FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE customers (
	cust_id int NOT NULL PRIMARY KEY,
	cust_first_name varchar(30) NOT NULL,
	cust_last_name varchar(30) NOT NULL,
	cust_gender varchar(1) NOT NULL,
	cust_birth_date date NOT NULL,
	cust_credit_limit money,
	cust_first_buy bit,
	cust_add_id int NOT NULL FOREIGN KEY REFERENCES address(add_id)
);

CREATE TABLE product_category(
	pcat_id int NOT NULL PRIMARY KEY,
	pcat_name varchar(50) NOT NULL,
	pcat_description varchar(255) NOT NULL
);

CREATE TABLE product_brand(
	pbrd_id int NOT NULL PRIMARY KEY,
	pbrd_name varchar(40) NOT NULL
);

CREATE TABLE products (
	prd_cod varchar(10) NOT NULL PRIMARY KEY,
	prd_model varchar(50) NOT NULL,
	prd_engine varchar(20) NOT NULL,
	prd_weight decimal(10,2) NOT NULL,
	prd_cost money NOT NULL,
	prd_price money NOT NULL,
	prd_max_speed decimal(10,2) NOT NULL,
	prd_doors int NOT NULL,
	prd_passenger int NOT NULL,
	pcat_id int NOT NULL FOREIGN KEY REFERENCES product_category(pcat_id),
	pbrd_id int NOT NULL FOREIGN KEY REFERENCES product_brand(pbrd_id)
);

CREATE TABLE position_employee (
	pos_id int NOT NULL PRIMARY KEY,
	pos_name varchar(50) NOT NULL
);

CREATE TABLE education (
	edu_id int NOT NULL PRIMARY KEY,
	edu_level varchar(50) NOT NULL
);

CREATE TABLE store (
	store_id int NOT NULL PRIMARY KEY,
	store_name varchar(100) NOT NULL,
	add_id int NOT NULL FOREIGN KEY REFERENCES address(add_id)
);

CREATE TABLE employee(
	emp_cod varchar(5) NOT NULL PRIMARY KEY,
	emp_name varchar(100) NOT NULL,
	emp_birth_date date NOT NULL,
	emp_gender varchar(1) NOT NULL,
	emp_sin varchar(15) NOT NULL, -- social insurance number
	emp_sales bit NOT NULL, -- if 0 false if 1 true
	emp_commision decimal(3,2),
	store_id int NOT NULL FOREIGN KEY REFERENCES store(store_id),
	pos_id int NOT NULL FOREIGN KEY REFERENCES position_employee(pos_id),
	edu_id int NOT NULL FOREIGN KEY REFERENCES education(edu_id)
);

CREATE TABLE sales(
	sle_id int NOT NULL PRIMARY KEY,
	sle_quantity_items int NOT NULL,
	date_sales DATE NOT NULL,
	cust_id int NOT NULL FOREIGN KEY REFERENCES customers(cust_id),
	emp_cod varchar(5) NOT NULL FOREIGN KEY REFERENCES employee(emp_cod),
	store_id int NOT NULL FOREIGN KEY REFERENCES store(store_id)
);

CREATE TABLE sales_item(
	sle_itm_id int NOT NULL PRIMARY KEY,
	quantity int NOT NULL,
	amount money,
	sle_id int NOT NULL FOREIGN KEY REFERENCES sales(sle_id),
	prd_cod varchar(10) NOT NULL FOREIGN KEY REFERENCES products(prd_cod)
);