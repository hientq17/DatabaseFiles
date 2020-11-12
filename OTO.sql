Use OTO
Select* from Hopdong
Select* from Khach
Select* from Xe
/*Cho biết thông tin của các xe cho thuê của hãng Toyota sản xuất giảm dần theo đơn giá*/
Select* from Xe where HangSX='Toyota' order by Dongia DESC 
/*Cho biết thông tin 2 xe cho thuê 4 chỗ có giá thấp nhất*/
Select top 2* from Xe where Socho=4 order by Dongia ASC
/*Cho biết số xe cho thuê theo số chỗ ngồi*/
Select Socho ,count(*) as Soxe_count from Xe group by Socho
/*Cho biết hãng sản xuất nào có số xe cho thuê từ 3 chiếc trở lên*/
Select Hangsx, count(*) as Soxe_count from Xe group by Hangsx having count(*)>=3
/*Cho biết thông tin các khách hàng thuê xe trong quý 4 năm 2018*/
Select Khach.*, NgayKy from Hopdong inner join Khach on Hopdong.CMND=Khach.CMND 
	where year(NgayKy)=2018 and month(NgayKy)>9 
/*Cho biết số lần thuê, tổng thời gian thuê của mỗi xe trong năm 2018*/
Select Hopdong.Bienso ,count(*) as So_Lan_Thue, sum(ThoiGianThue) as Sum_ThoiGianThue 
	from Hopdong inner join Xe on Hopdong.Bienso=Xe.Bienso where Year(NgayKy)=2018 group by Hopdong.Bienso 
/*Cho biết thông tin các hợp đồng thuê xe trong tháng 10 -2018, sắp xếp giảm dần theo giá trị hợp đồng*/
Select* from Hopdong where year(ngayky)=2018 and month(ngayky)=10 order by GiaTriHD DESC
Select *from XE
/*Cho biết hãng sản xuất và đơn giá thuê của các xe 4 chỗ*/
Select Socho, HangSx, DonGia from XE Where Socho='4'
/*Cho biết tên và điện thoại của khách kí hợp đồng HD001*/
Select Hoten,DienThoai from KHACH inner join HOPDONG on KHACH.CMND=HOPDONG.CMND Where SoHD='HD001' 
Select Hoten,DienThoai from KHACH Where CMND in (Select CMND from HOPDONG where SoHD='HD001')
/*Cho biết thời gian thuê, giá trị hợp đồng, họ tên của khách, đơn giá thuê, biển số xe của tất cả hợp đồng thuê xe kí trong quý I 2019*/
Select HoTen, DienThoai, HangSx, SoCho, DonGia, ThoiGianThue, NgayKy, GiaTriHD, KHACH.CMND from 
(HOPDONG inner Join XE on HOPDONG.Bienso=XE.Bienso) 
inner join KHACH on KHACH.CMND=HOPDONG.CMND where Month(NgayKy)>9 and Year(NgayKy)=2018