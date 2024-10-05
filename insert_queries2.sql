select * from branch;
SELECT * from employee;
SELECT * from book;
SELECT * from members;
SELECT * from issued_status;
select * from return_status;

-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books (assume a 30-day return period). 
-- Display the member's_id, member's name, book title, issue date, and days overdue.
select m.member_id,
	   m.member_name,
	   b.book_title , 
	   ist.issued_date ,  	
	   current_date - ist.issued_date as over_due_days
from issued_status as ist
	join
		members as m 
		on m.member_id = ist.issued_member_id
	join 	
		book as b 
		on b.isbn = ist.issued_book_isbn

	left join -- because it return few books and remaining books are not returned
		return_status as rst
		on ist.issued_id = rst.issued_id
	where 
		rst.return_date is null
		and
		current_date - ist.issued_date >30
	order by 1;

-- Task 14: Update Book Status on Return
-- Write a query to update the status of books in the books table to "Yes" when they are returned 
-- (based on entries in the return_status table).

create or replace procedure add_return_records(p_return_id varchar(10), p_issued_id varchar(10),p_book_quality varchar(15))
language plpgsql
As $$
Declare
	v_isbn varchar(20);
	v_book_name varchar(75);
Begin
	-- inserting records into return table
	insert into return_status(return_id , issued_id,return_date , book_quality)
	values (p_return_id,p_issued_id,current_date ,p_book_quality);

	-- finding isbn value by using issued_id in issued_status table
	select 
		issued_book_isbn,
		issued_book_name
		into
		v_isbn ,v_book_name
	from issued_status
	where issued_id = p_issued_id;

	-- update the avail to yes in book table
	update book
	set status = 'yes'
	where isbn = v_isbn;

	raise notice 'Thank you for returning the book : %',v_book_name;
End;
$$

-- Testing FUNCTION add_return_records

issued_id = IS135
ISBN = WHERE isbn = '978-0-307-58837-1'

SELECT * FROM book
WHERE isbn = '978-0-307-58837-1';

SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-307-58837-1';

SELECT * FROM return_status
WHERE issued_id = 'IS135';

-- calling function 
CALL add_return_records('RS138', 'IS135', 'Good');

-- calling function 
CALL add_return_records('RS148', 'IS140', 'Good');

-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, 
-- showing the number of books issued, the number of books returned, and 
-- the total revenue generated from book rentals.



