use HOUSEDB
Select * from CONTRACTS
Select * from CUSTOMERS
Select * from EMPLOYEES
Select * from HOUSES
--Q1--Cho biết thông tin các căn hộ cho thuê có giá từ 600 đến 800. Sắp xếp giảm dần theo diện tích.
Select * from HOUSES where price>=600 and price<=800 order by Area_m2 DESC
--Q2--
Select CUSTOMERS.*, ContractNo from CONTRACTS inner join CUSTOMERS on CONTRACTS.CustomerID=CUSTOMERS.CustomerID where ContractNo='CT001'
--Q3--
Select HOUSES.HouseID, startDate from HOUSES inner join CONTRACTS on CONTRACTS.HouseID=HOUSES.HouseID 
	where year(startDate)!=2018 or (year(startDate)=2018 and month(startDate)<10 )
--Q4--
Select BedRoom, count(*) as numberOfBedroom from HOUSES group by BedRoom
--Q5--
Select Ename, CONTRACTs.EmpID, count(CONTRACTs.EmpID) as numberOfContracts from EMPLOYEES inner join CONTRACTS on EMPLOYEES.EmpID=CONTRACTS.EmpID where year(StartDate)=2018 
	group by CONTRACTS.EmpID, Ename having count(CONTRACTs.EmpID)>=1 
--Q6--
Select Cname, CUSTOMERS.Gender, HOUSES.HouseID, Area_m2, startDate, endDate, Duration, ContractValue, Ename from CONTRACTS inner join HOUSES on CONTRACTS.houseID=HOUSES.houseID 
	inner join EMPLOYEES on CONTRACTS.empID=EMPLOYEES.empID inner join CUSTOMERS on CONTRACTS.CustomerID=CUSTOMERS.CustomerID 
	where year(endDate)=2018 and month(endDate)=6
--Q7--
Select BedRoom, count(*) as numberOfHouses from HOUSES inner join CONTRACTs on HOUSES.houseID=CONTRACTS.houseID 
	where year(StartDate)=2018 and month(StartDate)<10 and  month(StartDate)>6 group by BedRoom
--Q8--
Select HouseID, count(*) as numberOfRented, sum(Duration) sumDuration, sum(ContractValue) from CONTRACTS 
	where year(StartDate)=2018 group by HouseID
--Q9--
Select top 1* from CONTRACTS where year(StartDate)=2018 order by Duration DESC
--Q10--
Select * from HOUSES where BedRoom=3 and Price<500