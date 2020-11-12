/*Basic Programming in SQL
Declare Variable in SQL
Granted Value
Control Structures in SQL (If, case, while)
Block of code 
------------------
Declare @Varname data type [=initial value]
Granted value: set, select
*/
Declare @name varchar(50), @age int=30, @gender bit
set @name='John'
Select @gender=1
print 'Hello' +@name
if @gender=1 print 'Hello Mr' +@name
else print 'Hello Ms'+@name
--while loop
declare @i int=0, @n int=10, @result int=0
while (@i <= @n)
begin
	set @result = @result+@i
	set @i += 1
end
print str(@result)
declare @j int = 0
while (@j < 10)
begin
	if(@j<7) print 'Hoc database'
	else print 'Da nho'
	set @j += 1
end
--Kiem tra so nguyen to
declare @so int = 2, @k int = 2, @tmp bit=1
while(@k <= sqrt(@so))
begin
	if(@so % @k = 0) 
		begin 
			set @tmp = 0 
			break 
		end
	set @k += 1  
end
 if @tmp = 1 print str(@so)+ ' la so nguyen to'
		else print str(@so)+ ' khong phai la so nguyen to'
declare @kwh int =100, @pay decimal(10,2)
set  @pay = case 
	when @kwh between 0 and 50 then @kwh*1678
	when @kwh between 51 and 100 then  50*1678 + (@kwh-50)*1734
	when @kwh between 101 and 200 then 50*1678 + 100*1734 + (@kwh-100)*2014
	when @kwh between 201 and 300 then 50*1678 + 100*1734 + 200*2014 + (@kwh-200)*2536
	when @kwh between 301 and 400 then 50*1678 + 100*1734 + 200*2014 + 300*2536 + (@kwh-300)*2834
	when @kwh >= 401 then 50*1678 + 100*1734 + 200*2014 + 300*2536 + 400*2834 + (@kwh-400)*2461
end
print str(@pay*1.1)
--User variable begin with @
--System variable begin with @@ (ex @@erro)
use JOB_DB
Delete from JOBs where JobNo=5 --xoá dữ liệu trong bảng
Truncate table Jobs --xoá bảng
Delete Jobs --xoá bảng (giống với truncate)
Use bank
Select * from Accounts
 --Rollback Case
Begin Transaction T1
Update Accounts
set Balance = 0
where AccNo = '0001'
Rollback Transaction T1 --Nothing change on 0001
 --Commit case
Begin Transaction T2
Update Accounts
set Balance = 0
where AccNo = '0001'
Commit Transaction T2 -- 0001 has been changed
---------
Begin Transaction T3
Update Accounts set Balance = 100 where AccNo = '0001'
Save transaction SP1
Update Accounts set Balance = 200 where AccNo = '0002'
Save transaction SP2
Update Accounts set Balance = 300 where AccNo = '0003'
Rollback transaction SP1
Update Accounts set Balance = 400 where AccNo = '0004'
Commit Transaction T3 --Nothing changes on 0002 & 0003
--Điều khiển tương tranh
Begin Transaction 
update accounts set balance = 1100 where accno='0001'
waitfor delay '00:00:10'
Rollback transaction 

