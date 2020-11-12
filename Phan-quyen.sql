use Bank
/*Cấp phát quyền truy cập
--Grant <Privilieges/All> on <Database Objects> to <Users> [with grant option]
--with grant option: cho phép người dùng chuyển tiếp quyền cho người khác
*/
Grant Select, Update on Accounts to chung with Grant Option
/*Thu hồi quyền truy cập
--Revoke <Privileges> on <Database Objects> from <Users> [casade]--remove
--casade: Nếu ta đã cấp phát quyền cho người dùng nào đó bằng câu lệnh GRANT với tuỳ chọn WITH GRANT OPTION thì khi thu hồi quyền bằng câu lệnh REVOKE phải chỉ định tuỳ chọn CASCADE
*/
Revoke Update on Accounts from Chung casade
--Ref link: http://bis.net.vn/forums/p/805/1754.aspx