Create database OnlineStore;
use OnlineStore;
CREATE TABLE Customer(
	Cno varchar(16) primary key,
	Cpass varchar(16) NOT NULL,
	Cname nvarchar(50) NOT NULL,
	Cgender bit NOT NULL,
	Cphone varchar(11) NULL,
	Caddress nvarchar(50) NULL,
	Cadmin bit NOT NULL);
CREATE TABLE Invoice(
	Inno int auto_increment primary key,
	Cno varchar(16) NOT NULL,
	DateSale date NOT NULL,
	ShipFee double NULL,
	TotalPayment double NULL,
	PaymentStatus bit NOT NULL);
CREATE TABLE ItemType(
	ITno int auto_increment primary key,
	ITname nvarchar(50) NOT NULL,
	ImageURL varchar(100) NULL);
CREATE TABLE Item(
	Ino int auto_increment primary key,
	ITno int NOT NULL,
	Iname nvarchar(50) NOT NULL,
	UnitPrice double NOT NULL,
	DateImport date NOT NULL,
	DateExpired date NULL,
	AvailableAmount int NOT NULL,
	ImageURL varchar(100) NULL);
CREATE TABLE InvoiceDetail(
	Inno int not null,
	Ino int not null,
	ItemAmount int NOT NULL,
	TotalPrice double NULL,
    constraint primary key (inno, ino));
CREATE TABLE Cart(
	Cno varchar(16) not null,
	Ino int NOT NULL,
	Quantity int NOT NULL,
    primary key (cno,ino));
Alter table Item add foreign key (itno) references itemtype(itno);
Alter table InvoiceDetail add foreign key (inno) references invoice(inno),
						add foreign key (ino) references item(ino);
Alter table Invoice add foreign key (Cno) references customer(cno);
Alter table Cart add foreign key (Cno) references customer(cno), 
				add foreign key (Ino) references item(ino);
                
INSERT Customer (Cno, Cpass, Cname, Cgender, Cphone, Caddress, Cadmin) VALUES (N'DE140069', N'22222222', N'Huynh Long', 1, N'0987651234', N'T.T.Hue', 1);
INSERT Customer (Cno, Cpass, Cname, Cgender, Cphone, Caddress, Cadmin) VALUES (N'DE140148', N'12341234', N'Le Duc Son', 1, N'0987654321', N'Quang Binh', 0);
INSERT Customer (Cno, Cpass, Cname, Cgender, Cphone, Caddress, Cadmin) VALUES (N'DE140248', N'12345678', N'Trinh Quang Hien', 0, N'0901942964', N'Hue', 1);
INSERT Customer (Cno, Cpass, Cname, Cgender, Cphone, Caddress, Cadmin) VALUES (N'DE150021', N'1234512345', N'Nguyen Go', 1, N'0978655431', N'Hue', 0);
INSERT Customer (Cno, Cpass, Cname, Cgender, Cphone, Caddress, Cadmin) VALUES (N'Giangggg', N'11111111', N'Lam Giang', 0, N'09812313131', N'Nhà Giang', 0);

INSERT ItemType (ITno, ITname, ImageURL) VALUES (1, N'Comestics', N'ItemType1.jpg');
INSERT ItemType (ITno, ITname, ImageURL) VALUES (2, N'Toys', N'ItemType2.jpg'');
INSERT ItemType (ITno, ITname, ImageURL) VALUES (3, N'Clothes', N'ItemType3.jpg'');
INSERT ItemType (ITno, ITname, ImageURL) VALUES (4, N'Phone accessories', N'ItemType4.jpg'');
INSERT ItemType (ITno, ITname, ImageURL) VALUES (5, N'Watch', N'ItemType5.jpg'');

INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (1, 1, N'Perfume', CAST(199000.00 AS Decimal(18, 2)), CAST(N'2019-11-06' AS Date), NULL, 12, N'Item1.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (2, 1, N'Sunscreen', CAST(59000.00 AS Decimal(18, 2)), CAST(N'2020-06-25' AS Date), NULL, 3, N'Item2.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (3, 2, N'Car', CAST(120000.00 AS Decimal(18, 2)), CAST(N'2019-11-18' AS Date), NULL, 37, N'Item3.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (4, 2, N'Doll', CAST(27000.00 AS Decimal(18, 2)), CAST(N'2019-11-15' AS Date), NULL, 14, N'Item4.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (5, 3, N'Jacket', CAST(499000.00 AS Decimal(18, 2)), CAST(N'2019-11-12' AS Date), NULL, 9, N'Item5.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (6, 3, N'Jean', CAST(300000.00 AS Decimal(18, 2)), CAST(N'2019-11-01' AS Date), NULL, 55, N'Item6.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (7, 4, N'Headphone', CAST(75000.00 AS Decimal(18, 2)), CAST(N'2019-11-02' AS Date), NULL, 43, N'Item7.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (8, 4, N'Charger', CAST(50000.00 AS Decimal(18, 2)), CAST(N'2019-11-04' AS Date), NULL, 67, N'Item8.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (9, 5, N'Casio', CAST(23000.00 AS Decimal(18, 2)), CAST(N'2019-11-03' AS Date), NULL, 1, N'Item9.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (10, 5, N'Rolex', CAST(1190000.00 AS Decimal(18, 2)), CAST(N'2019-11-02' AS Date), NULL, 19, N'Item10.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (11, 3, N'Dress', CAST(550000.00 AS Decimal(18, 2)), CAST(N'2020-07-20' AS Date), NULL, 2, N'Item11.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (12, 4, N'Jack 3.5mm', CAST(41000.00 AS Decimal(18, 2)), CAST(N'2020-07-23' AS Date), NULL, 9, N'Item12.jpg');
INSERT Item (Ino, ITno, Iname, UnitPrice, DateImport, DateExpired, AvailableAmount, ImageURL) VALUES (13, 3 , N'Vest', CAST(1120000.00 AS Decimal(18, 2)), CAST(N'2020-07-28' AS Date), NULL, 4, N'Item13.jpg');


INSERT Cart (Cno, Ino, Quantity) VALUES (N'de140069', 2, 1);
INSERT Cart (Cno, Ino, Quantity) VALUES (N'de140069', 9, 1);
INSERT Cart (Cno, Ino, Quantity) VALUES (N'DE140248', 1, 1);
INSERT Cart (Cno, Ino, Quantity) VALUES (N'DE140248', 9, 1);
INSERT Cart (Cno, Ino, Quantity) VALUES (N'giangggg', 4, 1);

INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (10, N'DE140248', CAST(N'2020-05-19' AS Date), CAST(0.00 AS Decimal(18, 2)), CAST(1592000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (15, N'DE140248', CAST(N'2020-07-16' AS Date), CAST(30000.00 AS Decimal(18, 2)), CAST(298000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (17, N'DE140248', CAST(N'2020-07-16' AS Date), CAST(30000.00 AS Decimal(18, 2)), CAST(325000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (18, N'DE140248', CAST(N'2020-07-16' AS Date), CAST(30000.00 AS Decimal(18, 2)), CAST(330000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (19, N'DE140248', CAST(N'2020-07-16' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(79000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (20, N'DE140248', CAST(N'2020-07-16' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(170000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (21, N'DE140248', CAST(N'2020-07-17' AS Date), CAST(0.00 AS Decimal(18, 2)), CAST(420000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (22, N'DE140248', CAST(N'2020-07-17' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(79000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (23, N'DE140248', CAST(N'2020-07-18' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(170000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (24, N'DE140248', CAST(N'2020-07-18' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(120000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (25, N'DE140148', CAST(N'2020-07-18' AS Date), CAST(30000.00 AS Decimal(18, 2)), CAST(330000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (26, N'DE150021', CAST(N'2020-07-18' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(186000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (27, N'DE150021', CAST(N'2020-07-18' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(70000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (29, N'DE140248', CAST(N'2020-07-19' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(197000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (34, N'de140069', CAST(N'2020-07-22' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(170000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (40, N'de140069', CAST(N'2020-07-23' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(101000.00 AS Decimal(18, 2)), 0);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (45, N'DE140148', CAST(N'2020-07-23' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(171000.00 AS Decimal(18, 2)), 1);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (46, N'giangggg', CAST(N'2020-07-24' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(95000.00 AS Decimal(18, 2)), 0);
INSERT Invoice (Inno, Cno, DateSale, ShipFee, TotalPayment, PaymentStatus) VALUES (48, N'de140069', CAST(N'2020-07-24' AS Date), CAST(20000.00 AS Decimal(18, 2)), CAST(138000.00 AS Decimal(18, 2)), 0);

INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (10, 1, 5, CAST(995000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (10, 5, 1, CAST(499000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (10, 7, 1, CAST(75000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (10, 9, 1, CAST(23000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (15, 2, 2, CAST(118000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (15, 7, 2, CAST(150000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (17, 2, 5, CAST(295000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (18, 1, 2, CAST(300000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (19, 2, 1, CAST(59000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (20, 1, 1, CAST(150000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (21, 1, 2, CAST(300000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (21, 3, 1, CAST(120000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (22, 2, 1, CAST(59000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (23, 1, 1, CAST(150000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (24, 8, 2, CAST(100000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (25, 1, 2, CAST(300000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (26, 3, 1, CAST(120000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (26, 9, 2, CAST(46000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (27, 8, 1, CAST(50000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (29, 2, 3, CAST(177000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (34, 1, 1, CAST(150000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (40, 4, 3, CAST(81000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (45, 9, 3, CAST(69000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (45, 12, 2, CAST(82000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (46, 7, 1, CAST(75000.00 AS Decimal(18, 2)));
INSERT InvoiceDetail (Inno, Ino, ItemAmount, TotalPrice) VALUES (48, 2, 2, CAST(118000.00 AS Decimal(18, 2)));

-- drop trigger trigger_insert_cart;
Create trigger trigger_insert_Cart after insert on Cart for each row
 update Item set Item.AvailableAmount = Item.AvailableAmount - new.Quantity 
	where Item.ino = new.ino;
 
-- drop trigger trigger_update_cart;
 Create trigger trigger_update_Cart after update on Cart for each row
	  update Item set Item.AvailableAmount = Item.AvailableAmount - new.Quantity + old.Quantity 
		where Item.ino = new.ino;

-- drop trigger trigger_delete_cart;     
Create trigger trigger_delete_Cart before delete on Cart for each row
	update Item set Item.AvailableAmount = Item.AvailableAmount + old.Quantity 
		where Item.ino = old.ino;

-- drop procedure insert_InvoiceDetail
delimiter //
Create procedure insert_InvoiceDetail(IN inno int, IN ino int, IN itemAmount int)
BEGIN	
	Declare COUNT int default 0;
    Declare TOTALPRICE double default 0;
    Declare TOTALAMOUNT int default 0;
    set Count = (Select count(ino) from InvoiceDetail where InvoiceDetail.inno = inno and InvoiceDetail.ino = ino);
    if COUNT>0 then 
			set TOTALAMOUNT = itemAmount + (Select InvoiceDetail.itemAmount from InvoiceDetail where InvoiceDetail.inno = inno and InvoiceDetail.ino = ino);
			set TOTALPRICE = TOTALAMOUNT * (Select Item.Unitprice from Item where Item.ino = ino);
			Select 'Update ',inno as 'inno', ino as 'ino', TOTALAMOUNT as 'TotalAmount', TOTALPRICE as 'totalPrice';
            Update InvoiceDetail set InvoiceDetail.itemAmount = TOTALAMOUNT , InvoiceDetail.totalPrice = TOTALPRICE 
							where InvoiceDetail.inno=inno and InvoiceDetail.ino=ino;
    else
			set TOTALPRICE = itemAmount*(Select Item.Unitprice from Item where Item.ino = ino LIMIT 1);
            Select 'Insert ', inno as 'inno', ino as 'ino', itemAmount as 'itemAmount', TOTALPRICE as 'TotalPrice';
			Insert into InvoiceDetail values(inno,ino,itemAmount,TOTALPRICE);
    end if;
END//
delimiter ;	


-- drop trigger trigger_insert_InvoiceDetail
delimiter //
Create trigger trigger_insert_InvoiceDetail after insert on InvoiceDetail for each row
BEGIN
	declare TOTALPAYMENT double default 0;
	set TOTALPAYMENT =  (Select sum(InvoiceDetail.TotalPrice) from InvoiceDetail where InvoiceDetail.inno = new.inno group by InvoiceDetail.Inno);
	update Invoice set TotalPayment = TOTALPAYMENT where Invoice.inno = new.Inno; 
END//

-- drop trigger trigger_update_InvoiceDetail
delimiter //
Create trigger trigger_update_InvoiceDetail after update on InvoiceDetail for each row
BEGIN
	declare TOTALPAYMENT double default 0;
	set TOTALPAYMENT =  (Select sum(InvoiceDetail.TotalPrice) from InvoiceDetail where InvoiceDetail.inno = new.inno group by InvoiceDetail.Inno);
	update Invoice set TotalPayment = TOTALPAYMENT where Invoice.inno = new.Inno; 
END//

delimiter ;
