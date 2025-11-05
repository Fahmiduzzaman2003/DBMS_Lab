DROP DATABASE IF EXISTS Krishna_Nagar;
CREATE DATABASE Krishna_Nagar;
USE Krishna_Nagar;

CREATE TABLE accounts (
id int auto_increment primary key ,
first_name varchar(50) not null,
last_name varchar(50) not null,
balance decimal(12,2) not null,
currency char(5)not null default 'Mohor',
unique key full_name(first_name,last_name)
)engine=InnoDB;
  
INSERT INTO accounts (first_name,last_name,balance, currency) VALUES
    ('Gopal', 'Bhar', 200.00, 'Mohor'),
    ('Montri', 'Moshai', 700.00, 'Mohor');  
update accounts
set balance=1001 where first_name='Montri';
select *from accounts ;

set @@autocommit=0;
start transaction;
update accounts 
set balance =balance+100
where first_name='Montri' and currency='Mohor' and balance <=1000;
set @changed:=row_count();
update accounts
set balance=balance-100
where first_name="Gopal" and  currency ='Mohor' and balance >=100 and @changed=1;
set @command:=if(@changed=1,'Commit','Rollback');
prepare operation from @command ;
execute operation ;
deallocate prepare  operation;
select case 
when @changed=1 then 'Commited'
else 'Rolled Back'
end 
as status ;

select * from accounts;
