Create Database Bank
use Bank
Create table Accounts(AccNo char(4) not null Primary key, Cno char(4) not null, Cname char(30) not null, 
	DateExpired Date not null, PIN char(4) not null, Balance decimal not null)
Create table AccountTransfer(TransferID char(4) not null Primary key, TransferTime Time not null, AccnoSend char(4) not null, 
	AccnoReceive char(4) not null, Amount decimal not null, Fee decimal,
	Constraint FK_AccSend foreign key(AccnoSend) References Accounts(Accno),
	Constraint FK_AccReceive foreign key(AccnoReceive) References Accounts(Accno))
Create table Transactions(TranID char (4) not null Primary key, Trantime Time not null, Withdraw decimal not null, 
	Fee decimal, Accno char(4) not null, MachineNo char(4) not null,
	Constraint FK_Accounts foreign key(Accno) References Accounts(Accno))
Insert into Accounts(AccNo,Cno,Cname,DateExpired,PIN,Balance)
	Values('A001','C001','Trinh Quang Hien','2019/10/10','1111',1000)
Insert into Accounts(AccNo,Cno,Cname,DateExpired,PIN,Balance)
	Values('A002','C002','Huynh Long','2019/10/10','2222',1200)
Insert into Accounts(AccNo,Cno,Cname,DateExpired,PIN,Balance)
	Values('A003','C003','Nguyen Lam Giang','2019/09/10','3333',1200)
Insert into Accounts(AccNo,Cno,Cname,DateExpired,PIN,Balance)
	Values('A004','C004','Le Van Dat','2019/10/09','4444',1200)
Insert into Accounts(AccNo,Cno,Cname,DateExpired,PIN,Balance)
	Values('A005','C005','Bui Tien Dung','2019/10/09','5555',1200)
Select* from Accounts
Select* from AccountTransfer
Select* from Transactions
Create Trigger trigger_insert_transaction on Transactions for insert as --tạo trigger
begin
	update Accounts 
	set Accounts.Balance = Accounts.Balance - Inserted.Withdraw
	from Accounts inner join Inserted on Accounts.Accno = Inserted.Accno
end
drop Trigger trigger_insert_transaction --xoá trigger
Insert into transactions 
	values('T001',getdate(),500,1,'A001','M001')
Create Trigger trigger_insert_transfer on AccountTransfer for insert as
begin
	update Accounts
	set Accounts.Balance = Accounts.Balance - Inserted.Amount - Inserted.fee
	from Accounts inner join Inserted on Accounts.Accno = Inserted.AccnoSend
	update Accounts
	set Accounts.Balance = Accounts.Balance + Inserted.Amount
	from Accounts inner join Inserted on Accounts.Accno = Inserted.AccnoReceive
end
Insert into AccountTransfer
values('0001',getdate(),'0002','0003',350,1)
Create Trigger trigger_update_account on Accounts for Update
as
	Begin
	Select* from deleted
	Select* from inserted
	end
drop trigger trigger_update_account
