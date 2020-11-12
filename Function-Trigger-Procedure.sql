--Cau 1--------------
Create database ThueCanHo
use ThueCanHo
Select * from CANHO
Select * from KHACHTHUE
Select * from HOPDONG
--a---------------
create table CANHO(MaCanHo char(6) not null primary key, DiaChi varchar(30) not null,
	LoaiCanHo char not null, DienTich decimal(10,2) not null, DonGiaThue decimal(10,2))
create table KHACHTHUE(MaKhach char(6) not null primary key, HoTen varchar(30) not null, 
	DiaChi varchar(30) not null, DienThoai char(12) not null, GioiTinh bit not null)
create table HOPDONG(SoHopDong char(6) not null primary key, MaCanHO char(6) not null,
	MaKhach char(6) not null, NgayThue date not null, NgayTra date not null, ThoiGianThue int,
	GiaTriHopDong decimal(10,2), ChietKhau decimal(10,2),
	constraint FK_MaCanHo foreign key (MaCanHo) references CANHO(MaCanHo),
	constraint fk_MaKhach foreign key (MaKhach) references KHACHTHUE(MaKhach),
	UNIQUE(MaCanHo))
--b-------------------------
insert into CANHO(MaCanHo,DiaChi,LoaiCanHo,DienTich) values('CH0001','Thua Thien Hue','A',251.5),('CH0002','Sai Gon','C',167.1),
	('CH0003','Ha Noi','A',351.6),('CH0004','Da Nang','B',279),('CH0005','Kon Tum','C',141)
--
insert into KHACHTHUE values('KT0001','Trinh Quang Hien','Thua Thien Hue','+84912871971',1),('KT0002','Nguyen Lam Giang','Nghe An','+84121871961',0),
	('KT0002','Nguyen Lam Giang','Nghe An','+84121871961',0),('KT0003','Huynh Long','Thua Thien Hue','+84903881952',1),
	('KT0004','Vo Khoi Tuan Anh','Da Nang','+84121871200',1),('KT0005','Nguyen Ngoc Khanh','Quang Nam','+84126761891',0)
--
insert into HOPDONG(SoHopDong,MaCanHO,MaKhach,NgayThue,NgayTra) values('HD0001','CH0002','KT0003','2018/02/17','2018/05/17'),('HD0002','CH0003','KT0004','2016/05/12','2017/01/12'),
	('HD0003','CH0004','KT0005','2017/12/20','2018/11/20'),('HD0004','CH0005','KT0001','2018/01/07','2021/01/07'),('HD0005','CH0001','KT0002','2018/11/11','2019/12/11')
--c--------------------------------------------------
Create function set_DonGiaThue(@LoaiCanHo char) returns decimal(10,2) as
BEGIN
	declare @DonGiaThue decimal(10,2)
	set @DonGiaThue = case
		when @LoaiCanHo = 'A' then 700
		when @LoaiCanHo = 'B' then 500
		when @LoaiCanHo = 'C' then 300
	end
	return @DonGiaThue
END
--drop function set_DonGiaThue
Update CANHO set DonGiaThue=dbo.set_DonGiaThue(LoaiCanHo)
--d-------------------------------------------------------
Create function set_ThoiGianThue(@NgayThue date, @NgayTra date) returns int as
BEGIN
	declare @ThoiGianThue int
	set @ThoiGianThue= datediff(MONTH,@NgayThue,@NgayTra)
	if @ThoiGianThue=0 return 1
	return @ThoiGianThue
END
update HOPDONG set ThoiGianThue = dbo.set_ThoiGianThue(NgayThue,NgayTra)
--e-----------------------
update HOPDONG set GiaTriHopDong = ThoiGianThue*CANHO.DonGiaThue from CANHO inner join HOPDONG on CANHO.MaCanHo = HOPDONG.MaCanHO 
--f--------------------------
Select KHACHTHUE.* from KHACHTHUE inner join HOPDONG on KHACHTHUE.MaKhach=HOPDONG.MaKhach where SoHopDong='HD0001'
--g-------------------------
Select LoaiCanHo,count(*) as SoCanHo from CANHO group by LoaiCanHo
--h-------------------------
Select HOPDONG.* from HOPDONG where year(NgayThue)=2018 and month(NgayThue)<4 order by GiaTriHopDong DESC
--Cau 2----------------------------
Create function Tinh_Chiet_Khau(@ThoiGianThue int,@GiaTriHopDong decimal(10,2)) returns decimal(10,2) as
BEGIN
	Declare @ChietKhau decimal(10,2)
	set @Chietkhau = case
		when @ThoiGianThue<=3 then 0
		when @ThoiGianThue<=6 then 0.05*@GiaTriHopDong
		when @ThoiGianThue<=12 then 0.07*@GiaTriHopDong
		when @ThoiGianThue >12 then 0.1*@GiaTriHopDong
	end
	return @ChietKhau  
END
--drop function Tinh_Chiet_Khau
update HOPDONG set ChietKhau = dbo.Tinh_Chiet_Khau(ThoiGianThue,GiaTriHopDong)
--Cau 3--------------------------------------
Create procedure pr_insert_HOPDONG(@SoHopDong char(6),@MaCanHo char(6), @MaKhach char(6), @NgayThue date, @NgayTra date) as
BEGIN
	if exists(Select * from HOPDONG where SoHopDong=@SoHopDong) 
	begin
		print 'Hop Dong da ton tai'
		return
	end
	if not exists(Select * from KHACHTHUE where MaKhach=@MaKhach)
	begin
		print 'Khach thue khong ton tai'
		return
	end
	if not exists(Select * from CANHO where MaCanHo=@MaCanHo)
	begin
		print 'Can ho khong ton tai'
		return
	end
	if exists(Select * from HOPDONG where MaCanHo=@MaCanHo)
	begin
		print 'Can ho da duoc thue'
		return
	end
	if (@NgayTra<=@NgayThue)
	begin
		print 'Ngay tra phai lon hon ngay thue'
		return
	end
	declare @ThoiGianThue int
	set @ThoiGianThue = datediff(MONTH,@NgayThue,@NgayTra)
	declare @GiaTriHopDong decimal(10,2)
	set @GiaTriHopDong = @ThoiGianThue*(Select CANHO.DonGiaThue from CANHO inner join HOPDONG on CANHO.MaCanHo = HOPDONG.MaCanHO
		where SoHopDong=@SoHopDong)
	declare @Chietkhau decimal(10,2)
	set @Chietkhau = dbo.Tinh_Chiet_Khau(@ThoiGianThue,@GiaTriHopDong)
	insert into HOPDONG values(@SoHopDong,@MaCanHo,@MaKhach,@NgayThue,@NgayTra,@ThoiGianThue,@GiaTriHopDong,@Chietkhau)
END
--drop procedure pr_insert_HOPDONG
insert into CANHO(MaCanHo,DiaChi,LoaiCanHo,DienTich) values('CH0006','Dak Lak','B',241)
pr_insert_HOPDONG 'HD0006','CH0006','KT0001','2018/11/12','2019/05/12'
