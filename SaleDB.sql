Use SaleDB
Select * from Items
Select * from Customers
Select * from Orders
--Q1--
Create table Items(Ino char(4) primary key not null, Iname char(30) not null, TaxRate decimal(7,2) not null, 
	UnitPrice decimal(7,2) not null, AmountAvailable int not null)
Create table Customers(Cno char(4) primary key not null, Cname char(30) not null, Caddress char(30), Email char(30) not null)
Create table Orders(Ono char(4) not null, Ino char(4) not null, Odate date not null, Cno char(4) not null, Amount int not null, 
	Tax decimal(7,2), Total decimal(10,2),
	Constraint FK_Ino foreign key (Ino) references Items(Ino),
	Constraint FK_Cno foreign key (Cno) references Customers(Cno),
	Constraint PK primary key(Ono,Ino))
--Q2--
Insert into Items values ('I001','Chicken',0.5,20.5,2)
Insert into Items values ('I002','Rice',0.1,7.5,101)
Insert into Items values ('I003','Lemon',0.2,4.15,5)
Insert into Items values ('I004','Orange',0.9,4.6,7)
Insert into Items values ('I005','Potato',0.6,2.1,76)
Insert into Customers values ('C001','Trinh Quang Hien','Thua Thien Hue','quanghien1712@gmail.com')
Insert into Customers values ('C002','Huynh Long','Thua Thien Hue','huynhlongplocgmail.com')
Insert into Customers values ('C003','Vo Nhu Khang','Da Nang','vonhukhang@gmail.com')
Insert into Customers values ('C004','Nguyen Lam Giang','Nghe An','giangnlda140060@fpt.edu.vn')
Insert into Customers values ('C005','Do Viet Khoa','Da Nang','khoadvde140010@fpt.edu.vn')
Insert into Orders (Ono, Ino, Odate, Cno, Amount)
	values ('O001','I002','2019/10/18','C001',12)
Insert into Orders (Ono, Ino, Odate, Cno, Amount) 
	values ('O002','I003','2018/01/17','C002',3)
Insert into Orders (Ono, Ino, Odate, Cno, Amount) 
	values('O003','I004','2018/04/17','C003',1)
Insert into Orders (Ono, Ino, Odate, Cno, Amount) 
	values ('O004','I005','2019/10/01','C004',2)
Insert into Orders (Ono, Ino, Odate, Cno, Amount) 
	values ('O005','I001','2019/10/18','C005',1)
--Q3--
Update Orders
set total = Amount * Items.UnitPrice from Items inner join Orders on Items.Ino = Orders.Ino
--Q4-- 
Update Orders
set Tax = Total * Items.TaxRate from Items inner join Orders on Items.Ino = Orders.Ino 
--Q5--
Select top 2* from Orders where year(Odate)='2018' order by Amount DESC
--Q6--
Select Customers.* from Customers inner join orders on Customers.Cno = Orders.Cno where Ono = '1101'
--Q7--
Create Trigger trigger_insert_Order on Orders for Insert as
BEGIN
	update Items set Items.AmountAvailable = Items.AmountAvailable - inserted.amount
	from Items inner join inserted on Items.Ino=inserted.Ino
END
--drop trigger trigger_insert_Order
Insert into Orders (Ono, Ino, Odate, Cno, Amount) 
	values ('O113','I002',getDate(),'C003',22)
--Q8--
Create Procedure sp_Insert_Order(@Ono char(4), @Ino char(4), @Cno char(4), @Amount int)
as
BEGIN
	if not exists(Select * from Items where Ino = @Ino) print 'This item does not exist'
	else
		if not exists (Select * from Customers where Cno = @Cno) print 'This customer does not exist'
		else
		begin
			if  @amount > (select AmountAvailable from Items where Ino = @Ino) print 'There is no enough amount'
			else
			begin
				insert into Orders values(@Ono,@Ino,getdate(),@Cno,@Amount,null,null)
				print 'Insert successful'
			end
		end
END
--drop Procedure sp_Insert_Order
sp_Insert_Order 'O103','I001','C002',10
--More(Bài tập tự làm thêm)--(Tạo trigger để database tự động update Total và Tax trong bảng Orders chứ không cần phải tự update như trong Question 3,4)
Create Trigger trigger_insert_Tax_Total on Orders for insert as
BEGIN
	update Orders set Orders.Total = inserted.Amount*Items.UnitPrice from Items inner join inserted on items.Ino = inserted.Ino where Orders.Ono=inserted.Ono
	update Orders set Orders.Tax = Orders.Total*Items.TaxRate from Items inner join inserted on items.Ino = inserted.Ino where Orders.Ono=inserted.Ono
END
--drop Trigger trigger_insert_Tax_Total
Insert into Orders (Ono, Ino, Odate, Cno, Amount) 
	values ('O006','I002','2019/10/18','C004',12)

