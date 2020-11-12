use JOB_DB
Select* from EMPS
Select* from JOBS
Select distinct Skill from emps 
Select top 3* from EMPS order by SALARY DESC
Select * from emps where salary>1000
Select Skill, count(*), sum(salary), max(salary), min(salary), avg(salary) as Skill_count from emps Group by skill
Select skill, count(*) as Skill_count from Emps Group by Skill having count(*)>2
Select * from Emps, Jobs /*Cross join*/
Select * from Emps inner join Jobs on Emps.Skill=Jobs.skill /*inner join*/
Select * from Emps Left join Jobs on Emps.Skill=Jobs.skill /*left join*/
Select * from Emps Right join Jobs on Emps.Skill=Jobs.skill /*right join*/
Select * from Emps Full join Jobs on Emps.Skill=Jobs.skill /*full join*/
Select Emps.* from Emps where Skill not in (Select Skill from Jobs where JobNo=1) 
Select * from Emps where skill in('SQL','Java','C#')
Select * from Emps where Salary between 1200 and 1300
Select * from Emps where DateOfBirth between '1980-03-01' and '1980-03-20'
Select* from Emps where Skill like 'C%' --lấy bất kì giá trị nào bắt đầu từ C
Select* from Emps where Skill like 'C_' --lấy kí tự bắt đầu từ C và theo sau nó là 1 kí tự
Select* from Emps where Skill like 'C__' --lấy kí tự bắt đầu từ C và theo sau nó là 2 kí tự
Select* from Emps where Salary like '12__'
Select skill,count(*) as Skill_count from emps group by skill union select 'Number of Employees', count(*) as Emps_Count from Emps order by count(*) ASC
--Cho biết thông tin các nhân viên có kĩ năng không trùng với bất kì người nào ở trong công ty
Select emps.* from EMps where skill in(select skill from emps group by skill having count(*)=1 )
--Cho biết thông tin các nhân viên có ngày sinh nhật trùng với ít nhất 1 người trong công ty
Select* from Emps except 
select T1.* from Emps as T1, Emps as T2 
	where day(T1.DateOfBirth) = day(T2.DateOfBirth)
	and month(T1.DateOfBirth) = month(T2.DateOfBirth)
	and T1.ENO<>T2.ENO
--Tăng lương 10% cho 2 nhân viên có mức lương thấp nhất
Select * from EMps 
	Update emps set EMps.SALARY=T.salary*1.1
	from (select top 2* from emps order by salary asc) as T
	where emps.eno = T.eno
--Viết truy vấn tính tổng lương của từng skill và đưa ra số lượng đồng thời cũng xuất ra lương của từng nhân viên --