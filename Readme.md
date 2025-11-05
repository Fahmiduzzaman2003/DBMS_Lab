# MySQL Atomic Transaction Demo

This project demonstrates the use of atomic transactions in MySQL to ensure data integrity. It uses a simple bank transfer scenario between two accounts in the `Krishna_Nagar` database.

The two key principles shown are:
* **COMMIT**: If all operations in the transaction succeed, the changes are saved.
* **ROLLBACK**: If any operation fails, all changes are undone, returning the database to its previous state.

---

## Transaction 1: Successful Commit

This script demonstrates a successful transfer. The transaction will `COMMIT` because all conditions are met.

* **Action**: Transfer 100 Mohor from Gopal Bhar to Montri Moshai.
* **Condition**: Montri's balance (`700`) is `<= 1000`.
* **Result**: The first update succeeds (`@changed = 1`), allowing the second update to run. The transaction is committed.

### Code (`commit.sql`)

```sql
-- Transaction Done Successfully
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
select 'After attempt ' as step ;
select *from accounts ;
```

### Output (Successful Commit)

Here you can see the balances are correctly updated. Gopal's balance is 100, and Montri's is 800.

![Successful Commit Output](Commit.png)

---

## Transaction 2: Automatic Rollback

This script demonstrates a failed transfer. The transaction will `ROLLBACK` because a condition is not met.

* **Action**: Attempt to transfer 100 Mohor from Gopal to Montri.
* **Condition**: Montri's balance (`1001`) is *not* `<= 1000`.
* **Result**: The first `UPDATE` statement affects 0 rows. The `@changed` variable becomes `0`. This causes the second `UPDATE` (Gopal's withdrawal) to be skipped, and the `IF()` statement correctly chooses `ROLLBACK`.

### Code (`rollback.sql`)

```sql
-- Rolled Back As Montri Moshai s Balance >1000
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
select *from accounts ; -- Shows initial state before transaction
   

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

select * from accounts; -- Shows final state after attempt
```

### Output (Automatic Rollback)

The output shows the status as 'Rolled Back'. The final `SELECT *` query confirms that the balances are unchanged (Gopal: 200, Montri: 1001). The atomic transaction successfully prevented the invalid update.

![Rollback Output](RolledBack.png)
