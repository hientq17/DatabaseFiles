Create database OnlineStore
use OnlineStore
Select * from Customer
Select * from ItemType
Select * from Item
Select * from Invoice
Select * from InvoiceDetail
Select * from Cart
------------tạo trigger for insert InvoiceDetail--------------
Create trigger trigger_insert_InvoiceDetail on InvoiceDetail for insert as
BEGIN
	update Item set AvailableAmount = Item.AvailableAmount -inserted.ItemAmount from Item inner join inserted on Item.Ino = inserted.Ino
	declare @TotalPrice decimal(10,2)
	set @TotalPrice =  (Select sum(InvoiceDetail.TotalPrice) from InvoiceDetail inner join inserted on InvoiceDetail.Inno = inserted.Inno group by InvoiceDetail.Inno) 
	update Invoice set ShipFee = dbo.CalculateShipFee(@TotalPrice),
					TotalPayment = dbo.CalculateShipFee(@TotalPrice) + @TotalPrice from inserted inner join Invoice on inserted.Inno = Invoice.Inno
	update Invoice set TotalPayment = TotalPayment*(0.7) from inserted inner join Invoice on inserted.Inno = Invoice.Inno and day(DateSale)=15
END
--drop trigger trigger_insert_InvoiceDetail
------------tạo trigger for update InvoiceDetail--------------
Create trigger trigger_update_InvoiceDetail on InvoiceDetail for update as
BEGIN
	update Item set Item.AvailableAmount = Item.AvailableAmount -inserted.ItemAmount + deleted.ItemAmount from Item inner join inserted on Item.Ino = inserted.Ino 
		inner join deleted on Item.Ino = deleted.Ino
	declare @TotalPrice decimal(10,2)
	set @TotalPrice =  (Select sum(InvoiceDetail.TotalPrice) from InvoiceDetail inner join inserted on InvoiceDetail.Inno = inserted.Inno group by InvoiceDetail.Inno)
	update Invoice set ShipFee = dbo.CalculateShipFee(@TotalPrice),
					TotalPayment = dbo.CalculateShipFee(@TotalPrice) + @TotalPrice from inserted inner join Invoice on inserted.Inno = Invoice.Inno
	update Invoice set TotalPayment = TotalPayment*(0.7) from inserted inner join Invoice on inserted.Inno = Invoice.Inno and day(DateSale)=15
END
--drop trigger trigger_update_InvoiceDetail
Create trigger trigger_insert_Cart on Cart for insert as
BEGIN
	update Item set AvailableAmount = Item.AvailableAmount -inserted.Quantity from Item inner join inserted on Item.Ino = inserted.Ino
END
--drop trigger trigger_insert_cart
Create trigger trigger_update_Cart on Cart for update as
BEGIN
	update Item set Item.AvailableAmount = Item.AvailableAmount -inserted.Quantity + deleted.Quantity from Item inner join inserted on Item.Ino = inserted.Ino 
		inner join deleted on Item.Ino = deleted.Ino
END
--drop trigger trigger_update_cart
Create trigger trigger_delete_Cart on Cart for delete as
BEGIN
	update Item set Item.AvailableAmount = Item.AvailableAmount + deleted.Quantity from Item inner join deleted on Item.Ino = deleted.Ino
END
--drop trigger trigger_delete_cart
--------------tạo function tính Ship Fee-----------------------------
Create function CalculateShipFee(@TotalPrice decimal(10,2)) returns decimal(10,2) as
BEGIN
	declare @ShipFee decimal(10,2)
	set @ShipFee = case
	when @TotalPrice between 0 and 200000 then 20000
	when @TotalPrice <= 350000 then 30000
	else 0
	end
	return @ShipFee
END
--drop function CalculateShipFee
--------------tạo procedure for insert Invoice----------------
Create Procedure sp_insert_Invoice(@Cno varchar(16),@DateSale date, @PaymentStatus bit) as
BEGIN
	if not exists (Select* from Customer where @Cno = Cno) 
	begin
		print 'This customer does not exist'
		return
	end
	insert into Invoice(Cno, DateSale, PaymentStatus) values (@Cno, @DateSale, @PaymentStatus)
END
--drop procedure sp_insert_Invoice
-------------tạo procedure for insert InvoiceDetail-------------------
Create procedure sp_insert_InvoiceDetail(@Inno int,@Ino char(4),@ItemAmount int) as
BEGIN
	if not exists(Select * from Invoice where Inno = @Inno)
	begin
		print('This invoice does not exist')
		return
	end
	if not exists(Select * from Item where Ino = @Ino)
	begin
		print('This item does not exist')
		return
	end
	if @ItemAmount>(Select AvailableAmount from Item where Ino = @Ino)
	begin
		print('This item is not still enough for you')
		return
	end
	if exists(Select * from InvoiceDetail where Inno = @Inno and Ino = @Ino)
	begin
		update InvoiceDetail set ItemAmount=ItemAmount+@ItemAmount,
			TotalPrice=(ItemAmount+@ItemAmount)*(Select UnitPrice from Item where Ino = @Ino)  where Inno = @Inno and Ino = @Ino
		return
	end
	declare @TotalPrice decimal(10,2)
	set @TotalPrice = @ItemAmount*(Select UnitPrice from Item where Ino = @Ino)
	insert into InvoiceDetail values(@Inno,@Ino,@ItemAmount,@TotalPrice) 
END
--drop procedure sp_insert_InvoiceDetail
-------xem và loại bỏ những item đã hết hạn-----------------------
Select * from Item where DateExpired<getdate()
update Item set AvailableAmount = 0 where DateExpired<getdate()
-------xem những sản phẩm theo loại của chúng-----------------
Select Item.* from Item inner join ItemType on Item.ITno = ItemType.ITno where ITname = 'Comestics'
Select Item.* from Item inner join ItemType on Item.ITno = ItemType.ITno where ITname = 'Toys'
Select Item.* from Item inner join ItemType on Item.ITno = ItemType.ITno where ITname = 'Clothes'
Select Item.* from Item inner join ItemType on Item.ITno = ItemType.ITno where ITname = 'Phone Accessories'
Select Item.* from Item inner join ItemType on Item.ITno = ItemType.ITno where ITname = 'Watch'
--------xem top 3 đơn hàng có giá cao nhất----------------------
Select top 3* from Invoice order by TotalPayment DESC
--------xem top 3 sản phẩm bán chạy nhất------------------------
Select top 3 InvoiceDetail.Ino, Iname, UnitPrice, sum(ItemAmount) as TotalAmount from InvoiceDetail inner join Item on Item.Ino = InvoiceDetail.Ino 
	group by InvoiceDetail.Ino, Iname, UnitPrice order by TotalAmount DESC
--------xem tổng doanh thu từ Casio----------------------
Select InvoiceDetail.Ino, Iname, sum(TotalPrice) as Total from InvoiceDetail inner join Item on InvoiceDetail.Ino=Item.Ino 
	where InvoiceDetail.Ino in (Select Ino from Item where Iname='Casio') group by InvoiceDetail.Ino, Iname
-------xem tổng doanh thu tháng 11 năm 2019----------------------------
Select Inno, sum(TotalPrice) as Total from InvoiceDetail where Inno in (Select Inno from Invoice where Year(DateSale)=2019 and Month(DateSale)=11) group by Inno
-------xem những mặt hàng được nhập vào kho trước ngày 15-11-2019------------
Select * from Item where year(DateImport)<=2019 and MONTH(DateImport)<=11 and Day(DateImport)<15
------------------------------------------------------------------
