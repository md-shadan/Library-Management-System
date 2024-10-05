create table branch(
	branch_id varchar(10) primary key,
	manager_id varchar(10),
	branch_address varchar(30),
	contact_no varchar(15)
);



alter table employee
alter column salary type float;

create table employee(
	emp_id varchar(10) primary key,	
	emp_name varchar(25),	
	position varchar(15),
	salary int,
	branch_id varchar(10)
);


create table book(
	isbn varchar(20) primary key,
	book_title varchar(75),
	category varchar(25),
	rental_price float,
	status varchar(15),
	author varchar(35),
	publisher varchar(55)
);
create table members(
	member_id varchar(10) primary key,
	member_name varchar(25),
	member_address varchar(75),
	reg_date date
);

create table issued_status(
	issued_id varchar(10) primary key,
	issued_member_id varchar(10),
	issued_book_name varchar(75),
	issued_date date,
	issued_book_isbn varchar(25),
	issued_emp_id varchar(10)
);

CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50)  	
);

-- foreign key 
alter table issued_status
add constraint fk_member 
foreign key (issued_member_id)
references members(member_id );

alter table issued_status
add constraint fk_books 
foreign key (issued_book_isbn)
references book(isbn);

alter table issued_status
add constraint fk_emploees 
foreign key (issued_emp_id)
references employee(emp_id);

alter table employee
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id);

alter table return_status
add constraint fk_issued
foreign key (issued_id)
references issued_status(issued_id);

alter table return_status
add constraint fk_book
foreign key (return_book_isbn)
references book(isbn);





