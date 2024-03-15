 --In the given input table,some of the invoice are missing,write a sql query to identify the missing serial number
  --As an assumption consider the serial number with lowest generated value to be first generated invoice and the highest serial number
  --value to be the last generated invoice
  
drop table if exists invoice;
create table invoice
(
	serial_no		int,
	invoice_date	date
);


INSERT INTO invoice VALUES (330115, '2024-03-01');
INSERT INTO invoice VALUES (330120, '2024-03-01');
INSERT INTO invoice VALUES (330121, '2024-03-01');
INSERT INTO invoice VALUES (330122, '2024-03-02');
INSERT INTO invoice VALUES (330125, '2024-03-02');

with  r_cte as (
  select min(serial_no) as serial_no,max(serial_no) as maxi_sno  from invoice 
  union  all
  select (serial_no +1) as serial_no,maxi_sno from r_cte where serial_no <maxi_sno
  )
  select serial_no as missing_serial_number from r_cte 
  except 
  select serial_no as missing_serial_number from invoice
  
  
  
  
  
  
 
