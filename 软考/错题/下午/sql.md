## 2023
2023 年试题三（共 15 分）
阅读下列说明，回答问题 1 至问题 4，将解答填入答题纸的对应栏内。
【说明】
某教务管理系统的部分数据库关系模式如下：
<font color="#00b050">学生：STUDENT（<u>Sno</u>, Sname, Ssex, Sage, Sdept），各属性分别表示学号、姓名、性别、年龄、所在系名；</font>
<font color="#0070c0">课程：COURSE（<u>Cno</u>, Cname, Cpno, Ceredit），各属性分别表示课程号、课程名、先修课的课程号、学分；</font>
<font color="#ffc000">选课：SC（<u>Sno, Cno</u> , Grade）,各属性分别表示学号、课程号、成绩。</font>

有关上述关系模式的说明如下： 
（1）下划线标出的属性是表的主键。 
（2）课程名取值<span style="background:#fff88f">唯一</span>。 

根据以上描述，回答下列问题，将 SQL 语句的空缺部分补充完整。
【问题 1】（3 分）
请将下面创建课程表 <span style="background:#fff88f">COURSE</span> 的 SQL 语句补充完整，要求定义实体完整性约束、参照完整性约束，以及其他完整性约束。
CREATE TABLE COURSE（
Cno CHAR（4） PRIMARY KEY, 
Cname CHAR（30）<font color="#ff0000"> UNIQUE</font> ，
Cpno CHAR（4） REFERENCES <font color="#ff0000">COURSE(Cno) </font>, 
_**一门课程的先修课必须是系统中已存在的其他课程**_
_自引用外键_
Ccredit INT）; 

【问题 2】（4 分） 有一门课程号为“C036”的新开课，要求所有学生选修。该课程的基本信息已经录入课程表COURSE 中，现需在选课表 SC 中插入该课的选课记录。实现此功能的SQL 语句如下，请补全。
<font color="#ff0000">INSERT</font> INTO SC(Sno, <font color="#ff0000">Cno</font> ) 
SELECT Sno, <font color="#ff0000">‘C036’</font>
FROM <font color="#ff0000">STUDENT</font> ; 

【问题 3】（4 分）
查询每一门课程的间接先修课（先修课的先修课），要求输出课程号和间接先修课的课程号。即使某门课程没有先修课，也需要输出，不过其间接先修课为空。此功能由下面的SQL 语句实现，请补全。
SELECT K1.Cno, <font color="#ff0000">K2.Cpno</font>
FROM COURSE K1 <font color="#ff0000">LEFT</font>
OUTER JOIN COURSE K2 
<font color="#ff0000">ON  K1.Cpno=K2.Cno</font>; 

【问题 4】（4 分）
查询选修了课程表中已有全部课程的学生，要求输出学号和姓名。此功能由下面的SQL 语句实现，请补全。
SELECT Sno,Sname FROM STUDENT
WHERE NOT EXISTS
(SELECT * FROM <font color="#ff0000">COURSE</font>
WHERE <font color="#ff0000">NOT EXISTS</font>
_- 结果为真时 → 表示该学生**没选**这门课
-结果为假时 → 表示该学生选了这门课_
(SELECT * FROM <font color="#ff0000">SC</font>
WHERE <font color="#ff0000">Sno=STUDENT.Sno AND Cno=COURSE.Cno</font>
));

## 2022
2022 年试题三（共 15 分）
阅读下列说明，回答问题 1 至问题 4，将解答填入答题纸的对应栏内。
【说明】 某工程项目管理系统的部分数据库关系模式如下：
项目：PROJECT（Jno, Jname, City, Date），各属性分别表示项目代码、项目名称、项目所在城市和项目开始日期；
<font color="#00b050">零件：PART（<u>Pno</u>, Pname, Color, Sno, Stock），各属性分别表示零件代码、零件名称、零件颜色、零件所在仓库代码及库存量；</font>
供应情况：PJ（Pno, Jno ,Qty）,各属性分别表示零件代码、项目代码、使用量。
仓库：STORE（Sno, Sname, Address），各属性分别表示仓库代码、仓库名称、仓库地址。有关上述关系模式的说明如下： 
（1）下划线标出的属性是表的主键。 
（2）零件表的属性 Sno 参照了仓库表的主码。一种零件只存放在一个仓库，库存量最低为0。
（3）供应情况表的属性 Pno 和 Jno 分别参照了零件表和项目表的主码。

根据以上描述，回答下列问题，将 SQL 语句的空缺部分补充完整。
【问题 1】（4 分）
请将下面创建零件表 PART 的 SQL 语句补充完整，要求定义实体完整性约束、参照完整性约束，以及其他完整性约束。
CREATE <font color="#ff0000">table</font> PART（
Pno CHAR（10） <font color="#ff0000">primary key</font> , 
Pname CHAR（20），
Color CHAR（4）, 
Sno CHAR（4）REFERENCES <font color="#ff0000">STORE</font> （Sno），
Stock INT <font color="#ff0000">check（ Stock>=0）</font>; 

【问题 2】（3 分）
创建视图 PART_USED，给出在项目中已使用零件的代码和使用量。此视图的创建语句如下，请补全。 
CREATE VIEW PART_USED AS
SELECT Pno, <font color="#ff0000">SUM(Qty) </font>AS Usage
FROM PJ 
<font color="#ff0000">group</font> BY <font color="#ff0000">Pno</font> ; 

【问题 3】（4 分）
在视图 PART_USED 的基础上查询所有零件的信息，要求输出每种零件的零件代码、零件名、零件颜色和零件总量（使用量与库存量之和），查询结果按照零件总量降序排列。此功能由下面的 SQL 语句实现，请补全。

_这个查询要做的是：**列出所有零件的信息，并计算每个零件的总量(使用量+库存量)，按总量从大到小排序**。_

SELECT Pno, Pname, Color, <font color="#ff0000">(Stock+Usage)</font> AS Total
FROM PART, PART_USED 
WHERE PART.Pno = PART_USED.Pno 
_处理有使用记录的零件_
<font color="#ff0000">union</font>
_处理从未被使用过的零件_
SELECT Pno, Pname, Color, Stock AS Total
FROM PART
WHERE Pno <font color="#ff0000">NOT IN</font>
( SELECT DISTINCT Pno FROM PJ)
ORDER BY Total  <font color="#ff0000">DESC</font> ; 

【问题 4】（4 分）
由于某种原因，要拆除代码为‘A006’的仓库，该仓库中的零件转入‘A002’仓库存放。据此更新数据库的功能由下面的 SQL 语句实现，请补全。
UPDATE <font color="#ff0000">PART</font> SET <font color="#ff0000">Sno=’A002’</font> WHERE Sno=’A006’; 
<font color="#ff0000">DELETE</font> FROM <font color="#ff0000">STORE</font> WHERE Sno=’A006’;

## 2021
2021 年试题三（共 15 分）
阅读下列说明，回答问题 1 至问题 3，将解答填入答题纸的对应栏内。
【说明】 某竞赛管理系统的部分数据库关系模式如下：
选手：PLAYER（<u>Pno</u>, Pname, Sex, Region, Tel），各属性分别表示参赛选手的编号、姓名、性别、地区和联系电话；
竞赛项目：CONTEST（<u>Cno</u>, Cname, Type, Date），各属性分别表示竞赛项目的编号、名称、类别和举办日期；
选手参赛：PC（<u>Pno, Cno</u> ,City, Rank,Point）,各属性分别表示选手编号、竞赛项目编号、竞赛所在城市、选手取得的名次和积分。 
有关关系模式的说明如下：
（1）下划线标出的属性是表的主码。 
（2）选手参赛表的属性 Pno 和 Cno 分别参照了选手表和竞赛项目表的主码。
（3）一个选手参加一项竞赛有一个名次和一个积分，名次有 4 个取值（一，二，三，无）。另外，竞赛所在城市不能为空。 根据以上描述，回答下列问题，将 SQL 语句的空缺部分补充完整。
【问题 1】（5 分）
请将下面创建选手参赛表 PC 的 SQL 语句补充完整，要求定义<span style="background:#fff88f">实体完整性约束</span>、<span style="background:#fff88f">参照完整性约束</span>，<span style="background:#fff88f">以及其他完整性约束</span>。
CREATE TABLE PC（
Pno CHAR（10） REFERENCES <font color="#ff0000">PLAYER</font>（Pno）,
Cno CHAR（3） REFERENCES <font color="#ff0000">CONTEST</font>（Cno）,
City CHAR（20） <font color="#ff0000">NOT NULL</font>, 
Rank CHAR（2）<font color="#ff0000">check (rank in ('一','二','三','无') )</font>
Point SMALLINT, 
<font color="#ff0000">primary key (Pno,Cno)</font>
 ） 

【问题 2】（6 分） 查询所有未参加‘AI’类别竞赛的选手，要求输出选手的编号（Pno），查询结果按照选手编号的<span style="background:#fff88f">升序排列</span>。此功能由下面的 SQL 语句实现，请补全。 SELECT Pno FROM <font color="#ff0000">PLAYER</font>
WHERE Pno <font color="#ff0000">NOT IN</font> （
SELECT <font color="#ff0000">Pno</font> FROM PC, Contest
WHERE <font color="#ff0000">CONTEST.Cno=PC.Cno</font>
<font color="#ff0000">AND</font> Type ='AI'）
<font color="#ff0000">ORDER BY</font> Pno; 

【问题 3】（4 分） 由于某种原因，编号为'E06'的竞赛项目在正式举办前被取消了。而此前系统中已经记录了一些选手的报名参赛情况，<font color="#00b050">因此需要在系统中删除'E06'的竞赛项目记录，以及该竞赛的所有报名参赛纪录。</font>
根据问题 1 在选手参赛表 PC 上定义的参照完整性约束，此功能可以由下面的SQL 语句实现，请补全。

<font color="#ff0000">DELETE</font> FROM <font color="#ff0000">PC</font> WHERE Cno='E06';
<font color="#ff0000">DELETE</font> FROM <font color="#ff0000">CONTEST</font> WHERE Cno='E06'; 


## 2020
2020 年试题三（共 15 分） 
【说明】
某订单管理系统的部分数据库关系模式如下：
客户：CUSTOMERS(Cno,Cname,Cage,Csex)，
各属性分别表示客户编号、客户姓名、年龄和性别；
商品：GOODS（Gno, Gname, Gprice, Gorigin)，
各属性分别表示商品编号、商品名称、单价和产地； 订单：ORDERS(Ono, Cno, Gno, Oprice, Onumber)，
各属性分别表示订单编号、客户编号、商品编号、顾客购买商品的单价和数量。
有关关系模式的说明如下： 
（1）下划线标出的属性是表的主键。 
（2）商品表中的 Gprice 是商品的当前价格，可能会发生变动；<font color="#00b050">订单表中的Oprice 是订单成交是的商品单价。</font> 
（3）<font color="#00b050">一个订单只包含一位顾客购买的一种商品；其商品数量至少1 件，最多99 件。</font>

【问题 1】（3 分）
请将下面创建订单表的 SQL 语句补充完整，要求定义实体完整性约束，参照完整性约束，以及其它完整性约束。
CREATE TABLE ORDERS （
Ono CHAR(20) PRIMARY KEY
Cno CHAR(10) <font color="#ff0000">references CUSTOMERS(Cno)</font> ，
Gno CHAR(15) <font color="#ff0000">references GOODS(Gno)</font>，
Oprice NUMERIC(7,2), 
Onumber SMALLINT
<font color="#ff0000">check (Onumber between 1 and 99)</font>；

【问题 2】（5 分）
查询所有订单的详细情况，要求输出订单号（Ono）、客户姓名（Cname）、商品名称（Gname）、单价（Oprice）、数量（Onumber）和金额（Oamount），查询结果按照金额从大到小排列。此功能由下面的 SQL 语句实现，请补全。 

SELECT Ono, Cname, Gname, Oprice, Onumber, <span style="background:#fff88f">（Oprice* Onumber）</span> AS Oamount
FROM CUSTOMERS, ORDERS, GOODS 
WHERE  <span style="background:#fff88f">orders.cno=customers.cno</span>
AND <span style="background:#fff88f">orders.gno=goods.gno </span>
<span style="background:#fff88f">order</span> BY <span style="background:#fff88f">Oamount DESC</span> ；

【问题 3】（5 分） 创建已售商品信息视图，给出已售商品的编号（Gno）、名称（Gname）、订单个数（Onum）及<font color="#ff0000">平均每单的商品数量（GAnum）</font>。此视图的创建语句如下，请补全。


CREATE <font color="#ff0000">VIEW</font> GOODS_SOLD AS
SELECT ORDERS.Gno AS Gno, MIN(GOODS.Gname) AS Gname, 
       <font color="#ff0000">COUNT(* )</font> AS Onum, 
       <font color="#ff0000">AVG(ORDERS.Onumber)</font> AS GAnum
FROM <u>ORDERS, GOODS</u>
WHERE ORDERS.Gno = GOODS.Gno
<font color="#ff0000">GROUP</font> BY <font color="#ff0000">ORDERS.Gno</font>;

//**`COUNT(*)` 的计算范围严格取决于 `GROUP BY` 的分组定义**


【问题 4】（2 分）
查询未售出商品的编号和名称。此功能由下面的 SQL 语句实现，请补全。
SELECT Gno, Gname
FROM <font color="#ff0000">goods</font>
<font color="#ff0000">except</font>
_**找出在第一个查询结果中存在，但在第二个查询结果中不存在的记录**。_
SELECT Gno,Gname 
FROM GOODS_SOLD;


## 2019
2019 年试题四（共 15 分）
某学生信息管理系统的部分数据库关系模式如下：
学生：Student(stuno,stuname,stuage,stusex,schno)，各属性分别表示学生的学号、姓名、年龄、性别，以及学生所属学院的编号；
学院：School(schno,schname,schstunum)，各属性分别表示学院的编号、名称及学生人数；
俱乐部：Club(clubno,clubname,clubyear,clubloc），各属性分别表示俱乐部的编号、名称、成立年份和活动地点； 参加：JoinClub(stuno,clubno,joinyear），各属性分别表示学号、俱乐部编号，以及学生加入俱乐部的年份。

有关关系模式的说明如下： 
（1）学生的性别取值为“F”和“M”(F 表示女性，M 表示男性)。 
（2）删除一个学院的记录时，通过外键约束级联删除该学院的所有学生记录。
（3）学院表中的学生人数值与学生表中的实际人数要完全保持一致。也就是说，当学生表中增减记录时，就要自动修改相应学院的人数。

根据以下描述，回答下列问题，将 SQL 语句的空缺部分补充完整。 

【问题 1】（4 分）
请将下面创建学生表的 SQL 语句补充完整，要求定义实体完整性约束、参照完整性约束，以及其他完整性约束。 CREATE TABLE Student( 
stuno CHAR(11) <font color="#ff0000">primary key</font> , 
stuname VARCHAR(8), 
stuage SMALLINT, 
stusex CHAR(1) <font color="#ff0000">check (stusex in('F','M')</font>) ,
schno CHAR(3) <font color="#ff0000">references School(schno)</font>  ON DELETE <font color="#ff0000">CASCADE</font>); 

【问题 2】（5 分） 创建俱乐部人数视图，能统计每个俱乐部已加入学生的人数，属性有clubno,clubname和clubstunum。对于暂时没有学生参加的俱乐部，其人数为 0。此视图的创建语句如下，请补全。
Create VIEW CS_NUMBER(clubno,clubname,clubstunum) AS
SELECT JoinClub.clubno, <font color="#ff0000">MAX(Club.clubname)</font>, 
<font color="#ff0000">count(* ) AS clubstunum</font>
FROM <span style="background:#fff88f">JoinClub, Club</span>
WHERE <span style="background:#40a9ff">JoinClub.clubno = Club.clubno </span>
<font color="#ff0000">GROUP</font> BY JoinClub.clubno 
<font color="#ff0000">UNION</font> SELECT clubno,clubname,0 FROM Club
WHERE clubno NOT IN
(SELECT DISTINCT clubno FROM <font color="#ff0000">JoinClub</font> ); 

【问题 3】（4 分） 每当系统中新加或删除一个学生，就需要自动修改相应学院的人数，以便保持系统中学生人数的完整性与一致性。此功能由下面的触发器实现，请补全。 CREATE TRIGGER STU_NUM_TRG
AFTER INSERT OR DELETE ON <font color="#ff0000">Student</font>
REFERENCING new row AS nrow,old row AS orow 
FOR EACH <font color="#ff0000">row</font>
BEGIN 
IF INSERTING THEN
UPDATE School  <font color="#ff0000">SET schstunum=schstunum+1 WHERE School.schno=nrow.schno</font>
END IF; 

IF DELETING THEN
UPDATE School <font color="#ff0000">SET schstunum=schstunum-1 
WHERE School.schno=orow.schno</font> ;
END IF;
END; 

【问题 4】（2 分）
查询年龄小于 19 岁的学生的学号、姓名及所属学院名，要求输出结果把同一个学院的学生排在一起，此功能由下面的 SQL 语句实现，请补全。
SELECT stuno,stuname,schname
FROM Student,School
WHERE Student.schno=School.schno
AND stuage<19 <font color="#ff0000">order</font> BY <font color="#ff0000">schname </font>;

## 2018
2018 年试题四 （共 15 分）
阅读下列说明和图，回答问题 1 至问题 4，将解答填入答题纸的对应栏内。
【说明】 
某汽车租赁公司建立汽车租赁管理系统，其数据库的部分关系模式如下：
用户：USERS（UserID，Name，Balance），各属性分别表示用户编号、姓名、余额；
汽车：CARS（CID，Ctype，Cprice，CStatus），各属性分别表示汽车编号、型号、价格（日租金）、状态；
租用记录：BORROWS（BRID，UserID，CID，STime，ETime），各属性分别表示租用编号、用户编号、汽车编号、租用时间，归还时间； 
不良记录：BADS（Bid，UserID，BRID，BTime），各属性分别表示不良记录编号、用户编号、租用编号、不良记录时间。 
相关关系模式的属性及说明如下： 
（1）用户租用汽车时，其用户表中的余额不能小于 500，否则不能租用。
（2）汽车状态为待租和已租，待租汽车可以被用户租用，已租汽车不能租用。
（3）用户每租用一次汽车，向租用记录中添加一条租用记录，租用时间默认为系统当前时间，归还时间为空值，并将所租汽车状态变为已租。用户还车时，修改归还时间为系统当前时间，并将汽车状态改为待租。要求用户不能同时租用两辆及以上汽车。 
（4）租金从租用时间起按日自动扣除。 
根据以上描述，回答下列问题，将 SQL 语句的空缺部分补充完整。

【问题 1】（4 分）
请将下面建立租用记录表的 SQL 语句补充完整，要求定义主码完整性约束和引用完整性约束。
CREATE TABLE BORROWS（
BRID CHAR（20） <font color="#ff0000">primary key</font> ，
UserID CHAR（10） <font color="#ff0000">references users(UserID)</font> ，
CID CHAR（10） <font color="#ff0000">references cars(CID)</font> ，
STime DATETIME <font color="#ff0000">default GETDATE（）</font> ，
ETime DATETIME， ）；

【问题 2】（4 分）
当归还时间为空值时，表示用户还未还车，系统每天调用事务程序从用户余额中自动扣除当日租金，每个事务修改一条用户记录中的余额值。由用户表上的触发器实现业务：如用户当日余额不足，不扣除当日租金，自动向不良记录表中加入一条记录，记录中的BID 取值由UserID+系统当前日期构成，BTime 采用 GETDATE（）函数取系统当前时间。补全创建<font color="#00b050">触发器</font>Bad_TRG的 SQL 语句。

CREATE TRIGGER Bad_TRG<font color="#ff0000"> after</font> UPDATE OF Balance ON USERS
Referencing new row as nrow
For each row
When nrow.Balance<0
BEGIN 
<font color="#ff0000">ROLLBACK</font>；-- 回滚事务
//插入不良记录 
INSERT INTO BADS 
SELECT CONCAT（BORROWS.UserID, CONVERT（varchar(100)，GETDATE（），10）），
BORROWS.UserID，
BRID，
<font color="#ff0000">GetDate()</font> ；
//CONVERT（）函数将日期型数据改为字符串型 //CONCAT（）函数实现字符串拼接 
FROM BORROWS
WHERE <font color="#ff0000">BORROWS.UserID=nrow.UserID</font> AND ETime IS NULL；
END 

【问题 3】（4 分） 不良记录是按日记录的，因此用户一次租车可能会产生多条不良记录。创建不良记录单视图BADS_Detail，统计每次租车产生的<font color="#00b050">不良记录租金费用</font>总和大于 200 的记录，属性有UserID、Name、BRID、CID、STime、ETime 和 total（表示未缴纳租金总和）。补全建立视图BADS_Detail 的 SQL 语句。

CREATE VIEW <font color="#ff0000">BADS_Detail(UserID,Name,BRID,CID,Stime,Etime,total)</font>
AS 
SELECT BADS.UserID，USERS.Name，BADS.BRID，CARS.CID，STime，ETime，<font color="#ff0000">SUM(CARS.CPrice)</font>
AS total
FROM BORROWS，BADS，CARS，USERS
WHERE
BORROWS.BRID = BADS.BRID
AND BORROWS.CID=CARS.CID
AND <font color="#ff0000">USERS.UserID </font>=BADS.UserID
GROUP BY BADS.UserID，USERS.Name，BADS.BRID，CARS.CID，STime，ETime
HAVING <font color="#ff0000">SUM(CARS.CPrice) > 200</font> ； 

【问题 4】（3 分） 查询租用了型号为“A8”且不良记录次数大于等于 2 的用户，输出用户编号、姓名，并按用户姓名降序输出。 
SELECT USERS.UserID，Name
FROM USERS，BORROWS，CARS
WHERE USERS.UserID=BORROWS.UserID
AND BORROWS.CID=CARS.CID
AND <font color="#ff0000">CARS.Ctype=’A8'</font>
AND EXISTS（
SELECT * FROM BADS
WHERE BADS.UserID=BORROWS.UserID
AND <font color="#ff0000">BADS.BRID=BORROWS.BRID</font>
GROUP BY UserID
HAVING COUNT（* ）>=2）
ORDER BY <font color="#ff0000">Name DESC</font> ;

## 2017
2017 年试题四（共 15 分）
阅读下列说明，回答问题 1 至问题 5 ，将解答填入答题纸的对应栏内。
【说明】
某公司要对其投放的自动售货机建立商品管理系统，其数据库的部分关系模式如下：
售货机：VEM（VEMno， Location) ，各属性分别表示售货机编号、部署地点；
商品： GOODS(Gno， Brand， Price) ，各属性分别表示商品编号、品牌名和价格；
销售单： SALES(Sno， VEMno，Gno，SDate，STime)，各属性分别表示销售号、售货机编号、商品编号、日期和时间。
缺货单：OOS(VEMno，Gno，SDate，STime )，各属性分别表示售货机编号、商品编号、日期和时间。
相关关系模式的属性及说明如下： 
（1）售货机摆放固定种类的商品，售货机内每种商品最多可以储存 10 件。管理员在每天结束的时候将售货机中所有售出商品补全 
（2）每售出一件商品，就自动向销售单中添加一条销售记录。如果一天内某个售货机上某种商品的销售记录达到 10 条，则表明该售货机上该商品已售完，需要通知系统立即补货，通过自动向缺货单中添加一条缺货记录来实现。 根据以上描述，回答下列问题，将 SQL 语句的空缺部分补充完整。 

【问题 1】（3 分）
请将下面创建销售单表的 SQL 语句补充完整，要求指定关系的主码和外码约束。
CREATE TABLE SALES （
Sno CHAR(8) <font color="#ff0000">primary key</font>
VEMno CHAR(5) <font color="#ff0000">references vem(VEMno)</font>
Gno CHAR(8) <font color="#ff0000">references GOODS(Gno)</font>
SDate DATE, 
STime TIME）; 

【问题 2】（4 分）
创建销售记录详单视图 SALES_Detail ，要求按日期统计每个售货机上各种商品的销售数量，属性有 VEMno、Location 、Gno、Brand 、Price 、amount 和 SDate。
为方便实现，首先建立一个视图 SALES_Total ，然后利用 SALES_Total 完成视图 SALES_Detail 的定义。

CREATE VIEW SALES_Total (VEMno, Gno, SDate, amount) AS 
SELECT VEMno ,Gno ,SDate ,count(* )
FROM SALES
GROUP BY <font color="#ff0000">VEMno,Gno,SDATE</font> ;

CREATE VIEW SALES_Detail AS
SELECT VEM.VEMno，Location ，GOODS.Gno ，Brand，Price，amount，SDate
FROM VEM，GOODS，SALES_Total
WHERE <font color="#ff0000">VEM.VEMno = SALES_Total.VEMno</font> 
AND <font color="#ff0000">GOODS.Gno=SALES_Total.Gno</font> ；

【问题 3】（3 分）
每售出一件商品，就自动向销售单中添加一条销售记录。如果一天内某个售货机上某种商品的销售记录达到 10 条，则自动向缺货单中添加一条缺货记录。需要用触发器来实现缺货单的自动维护。程序中的 GetTime（）获取当前时间。
CREATE <font color="#ff0000">trigger</font> OOS_TRG AFTER <font color="#ff0000">insert</font> ON SALES REFERENCING new row AS nrow
FOR EACH ROW
BEGIN
INSERT INTO OOS
SELECT SALES .VENno, <font color="#ff0000">SALES.Gno, SALES.SDate</font>,GetTime（）
FROM SALES
WHERE SALES.VEMno = nrow.VEMno
AND SALES.Gno = nrow.Gno
<font color="#00b050">AND SALES.SDate=nrow.SDate</font>
GROUP BY
SALES.VEMno，SALES.Gno，SALES.SDate
HAVING
count（* ）> 0 AND mod（count（* ）， 10）= 0 ;
END 

【问题 4】（3 分） 查询当天销售最多的商品编号、品牌和数量。程序中的 GetDate( ) 获取当天日期。
SELECT GOODS.Gno ，Brand，
<font color="#ff0000">count(* ) </font>
FROM GOODS, SALES
WHERE GOODS.Gno=SALES.GNO
AND SDate =GetDate( )
GROUP BY <font color="#ff0000">GOODS.Gno, Brand</font>
HAVING <font color="#ff0000">Count(* ) >=ALL</font>
( SELECT count(* ) 
FROM SALES
WHERE SDate = GetDate( )
GROUP BY Gno ); 

【问题 5】（2 分）
查询一件都没有售出的所有商品编号和品牌。
SELECT Gno ,Brand
FROM GOODS
WHERE Gno <font color="#ff0000">not in</font> ( 
SELECT DISTINCT Gno
FROM <font color="#ff0000">SALES</font> ) ;

## 2016
2016 年试题二（共 15 分）
阅读下列说明，回答问题 1 至问题 3，将解答填入答题纸的对应栏内。
【说明】
某单位公用车辆后勤服务部门数据库的部分关系模式如下：
驾驶员：EMP（Eno, Ename, Age, Sex, telephone），各属性分别表示驾驶员工号、姓名、年龄、性别和电话号码； 车辆：CAR（Cno,Brand,Capacity），各属性分别表示汽车车牌号、品牌名和排量；
调度：SCHEDULE（Sno, Eno, Cno, StartTime, Endtime），各属性分别表示调度号、驾驶员工号、汽车车牌号、发车时间和收车时间；
奖金：BONUS（Eno, Year, Month, Amount），各属性分别表示驾驶员工号、年、月和当月的奖金数量。
有关车辆调度的相关说明如下： 公车的行驶时间只能在工作时间内，因此规定调度表中每天安排发车的时间在上午07:00:00至下午 18:00:00 范围内。 

【问题 1】（4 分）
请将下面创建调度关系的 SQL 语句的空缺部分补充完整，要求指定关系的主码、外码，以及调度表中每天安排发车的时间在上午 07:00:00 至下午 18:00:00 范围内的约束（由函数TimeGet_time(DATETIME StartTime)返回出车的时间）。
CREATE TABLE SCHEDULE
Sno CHAR(10),
Eno CHAR(10) <font color="#ff0000">references emp(Eno)</font> , 
Cno CHAR(8) <font color="#ff0000">references car(Cno)</font> , 
StartTime DATETIME
<font color="#ff0000">CHECK (TimeGet_time(StartTime) BETWEEN '07:00:00' AND '18:00:00'),</font>
EndTime DATETIME, 
PRIMARY KEY <font color="#ff0000">(Sno)</font> ）; 

【问题 2】（6 分） 
（1）<font color="#00b050">创建所有“奥迪”品牌汽车</font>的调度信息的视图 AudiSCHEDULE，属性有Eno、Ename、Cno、Brand、StartTime 和 EndTime，请将下面 SQL 语句的空缺部分补充完整。
CREATE <font color="#ff0000">view  AudiSCHEDULE(Eno、Ename、Cno、Brand、StartTime、EndTime) </font>AS
SELECT EMP.Eno, Ename,
CAR.Cno, Brand, StartTime, EndTime
<font color="#00b050">FROM EMP, CAR, SCHEDULE</font>
WHERE <font color="#ff0000">EMP.Eno=SCHEDULE. Eno and </font>
<font color="#ff0000">CAR.Cno=SCHEDULE. Cno and brand='奥迪'</font>; 

（2）驾驶员的奖金在收车时间写入时，由出车时间段自动计算，并用触发器来实现奖金的自动维护，函数 float Bonus_value(DATETIME StartTime, DATETIME EndTime)依据发车时间和收车时间来计算本次出车的奖金。系统在每月初自动增加一条该员工的当月奖金记录，初始金额为零。请将下面 SQL 语句的空缺部分补充完整。
CREATE <font color="#ff0000">trigger</font> Bonus_TRG AFTER <font color="#ff0000">update</font>
ON SCHEDULE
REFERENCING new row AS nrow
FOR EACH ROW 
BEGIN
UPDATE BONUS SET 
<font color="#ff0000">Amount=Amount+Bonus_value(nrow.StartTime, nrow.EndTime)</font>
WHERE <font color="#ff0000">BONUS.Eno=nrow.Eno</font>
AND Year = Get_Year(nrow.StartTime) AND Month = Get_Month(nrow.StartTime) ; 
END 

【问题 3】（5 分） 请将下面 SQL 语句的空缺部分补充完整。 
（1）查询调度次数最多的汽车车牌号及其品牌。
SELECT CAR.Cno, Brand
FROM CAR, SCHEDULE
WHERE CAR.Cno=SCHEDULE.Cno
GROUP BY <font color="#ff0000">CAR.Cno, Brand</font>
HAVING <font color="#ff0000">count(* ) >= all  </font>
( SELECT COUNT(* ) 
FROM SCHEDULE
GROUP BY Cno ) ; 

（2）查询所有在调度表中没有安排过“大金龙”品牌车辆的驾驶员工员和姓名。
SELECT Eno, Ename
FROM EMP
WHERE Eno <font color="#ff0000">not in</font>
( SELECT Eno FROM <font color="#ff0000">car,schedule</font>
WHERE <font color="#ff0000">schedule.cno=car.cno</font>
AND Brand='大金龙' ) ;

## 2015
2015 年试题二（共 15 分）
【说明】
某大型集团公司的数据库的部分关系模式如下：
员工表：EMP（Eno，Ename，Age，Sex， Title），各属性分别表示员工工号、姓名、年龄、性别和职称级别，其中性别取值为“男”“女”；
公司表：COMPANY（Cno，Cname，City），各属性分别表示公司编号、名称和所在城市；
工作表：WORKS（Eno，Cno，Salary），各属性分别表示职工工号、工作的公司编号和工资。
有关关系模式的属性及相关说明如下：
（1）允许一个员工在多家公司工作，使用身份证号作为工号值。 
（2）工资不能低于 1500 元。 
【问题 1】（4 分） 
请将下面创建工作关系的 SQL 语句的空缺部分补充完整，要求指定关系的主码、外码，以及工资不能低于 1500 元的约束。
CREATE TABLE WORKS(
Eno CHAR(10) <font color="#ff0000">references EMP(Eno)</font> , 
Cno CHAR(4) <font color="#ff0000">references COMPANY(Cno)</font> , 
Salary int <font color="#ff0000">check (salary>=1500)</font> , 
PRIMARY KEY<font color="#ff0000"> (Eno,Cno) </font>, 

【问题 2】（6 分）
（1）创建女员工信息的<font color="#00b050">视图</font> FemaleEMP。属性有 Eno、Ename、Cno、Cname 和Salary，请将下面 SQL 语句的空缺部分补充完整。
CREATE <font color="#ff0000">view FemaleEMP(Eno,Ename,Cno,Cname,Salary) </font>AS
<font color="#00b050">SELECT EMP.Eno, Ename, COMPANY.Cno, Cname, Salary</font> From EMP, COMPANY, WORKS
WHERE  <font color="#ff0000">EMP.Eno=WORKS.Eno</font>
<font color="#ff0000">and COMPANY.Cno=WORKS.Cno</font>
<font color="#ff0000">and EMP.Sex='女'; </font>

（2）员工的工资<font color="#00b050">由职称级别的修改自动调整</font>，需要用触发器来实现员工工资的自动维护，函数float Salary_value(char(10) Eno)依据员工号计算员工新的工资。请将下面SQL 语句的空缺部分补充完整。 
Create <font color="#ff0000">trigger</font> Salary_TRG AFTER <font color="#ff0000">update</font>
ON EMP
REFERENCING new row AS nrow
FOR EACH ROW
BEGIN
UPDATE WORKS
SET <font color="#ff0000">Salary=Salary_value(nrow.Eno)</font>
WHERE <font color="#ff0000">WORKS.Eno=nrow.Eno</font> ;
END

【问题 3】（5 分）
请将下面 SQL 语句的空缺部分补充完整。
（1）查询员工最多的公司编号和公司名称。
SELECT COMPANY.Cno, Cname
FROM COMPANY, WORKS
WHERE COMPANY.Cno=WORKS.Cno
GROUP BY <font color="#ff0000">COMPANY.Cno, Cname</font>
HAVING <font color="#ff0000">COUNT(* ) >= all</font>
( SELECT COUNT(* ) FROM WORKS GROUP BY Cno ); 

（2）查询所有不在“中国银行北京分行”工作的员工工号和姓名。 
SELECT Eno, Ename
FROM EMP 
WHERE Eno <font color="#ff0000">not in</font>
( SELECT Eno FROM <font color="#ff0000">WORKS,COMPANY</font>
WHERE <font color="#ff0000">WORKS.Cno=COMPANY.Cno</font>
AND Cname = '中国银行北京分行' );


## 2014
2014 年试题二（共 15 分）
阅读下列说明，回答问题 1 至问题 3，将解答填入答题纸的对应栏内。
【说明】 
某健身俱乐部要开发一个信息管理系统，该信息系统的部分关系模式如下：
员工（员工身份证号，姓名，工种，电话，住址）
会员（会员手机号，姓名，折扣）
项目（项目名称，项目经理，价格）
预约单（会员手机号，预约日期，项目名称，使用时长）(外键：会员手机号) 
消费（流水号，会员手机号，项目名称，消费金额，消费日期）（外键：会员手机号，项目名称）
有关关系模式的属性及相关说明如下： 
（1）俱乐部有多种健身项目，不同的项目每小时的价格不同。俱乐部实行会员制，且需要电话或在线提前预约。 （2）每个项目都有一个项目经理，一个经理只能负责一个项目。
（3）俱乐部对会员进行积分，达到一定积分可以进行升级，不同的等级具有不同的折扣。根据以上描述，回答下列问题：

【问题 1】（4 分）
请将下面创建消费关系的 SQL 语句的空缺部分补充完整，要求指定关系的主码、外码，以及消费金额大于零的约束。
CREATE TABLE 消费 ( 
流水号 CHAR(12) <font color="#ff0000">primary key</font> , 
会员手机号 CHAR(11), 
项目名称 CHAR (8), 
消费金额 NUMBER <font color="#ff0000">check (消费金额>=0)</font> ,
消费日期 DATE, 
<font color="#ff0000">foreign key (会员手机号) references 会员 (会员手机号)</font> , 
<font color="#ff0000">foreign key (项目名称) references 项目 (项目名称) </font>
, );

【问题 2】（6 分）
（1）手机号为 18812345678 的客户预约了 2014 年 3 月 18 日两个小时的羽毛球场地，消费流水号由系统自动生成。请将下面 SQL 语句的空缺部分补充完整。
INSERT INTO 消费（流水号，会员手机号，项目名称，消费金额，消费日期）
SELECT ‘201403180001’, ‘18812345678’, ‘羽毛球’, 
价格 * 使用时长 * 折扣,
‘2014/3/18’ 
FROM 会员，项目，预约单
WHERE 预约单.项目名称=项目.项目名称
AND <font color="#ff0000">会员.会员手机号=预约单.会员手机号</font>
AND 项目.项目名称=‘羽毛球’ 
AND 会员.会员手机号=‘18812345678’；

（2）需要用触发器来实现会员等级折扣的自动维护，函数 float vip_value(char(11) 会员手机号）依据输入的手机号计算会员的折扣。请将下面 SQL 语句的空缺部分补充完整。
CREATE TRIGGER VIP_TRG AFTER <font color="#ff0000">insert</font>
ON <font color="#ff0000">消费</font>
REFERENCING new row AS nrow
FOR EACH ROW 
BEGIN
UPDATE 会员 SET <font color="#ff0000">折扣=vip_value( nrow.会员手机号）</font>
WHERE <font color="#ff0000">会员.会员手机号=nrow.会员手机号 </font>；
END

【问题 3】（5 分）
请将下面 SQL 语句的空缺部分补充完整。
（1）俱乐部年底对各种项目进行绩效考核，需要统计出所负责项目的消费总金额大于等于十万元的<font color="#00b050">项目和项目经理</font>，并按消费金额总和降序输出。
SELECT 项目.项目名称，项目经理，SUM（消费金额） FROM 项目，消费
WHERE <font color="#ff0000">项目.项目名称=消费.项目名称</font>
GROUP BY 
<font color="#ff0000">项目.项目名称，项目经理</font>
<font color="#ff0000">HAVING SUM(消费金额）>=100000</font>
；
ORDER BY <font color="#ff0000">SUM（消费金额）DESC</font> ; 

（2）查询所有手机号码以"888”结尾，姓“王”的员工姓名和电话。
SELECT 姓名，电话
FROM 员工
WHERE 姓名 <font color="#ff0000">LIKE ‘王%’</font>
AND 电话 <font color="#ff0000">LIKE ‘%8888’</font>

## 2013
2013 年试题二（共 15 分）： 
某航空公司要开发一个订票信息处理系统，该系统的部分关系模式如下：
航班（航班编号，航空公司，起飞地，起飞时间，目的地，到达时间，票价）
折扣（航班编号，开始日期，结束日期，折扣）
旅客（身份证号，姓名，性别，出生日期，电话，VIP 折扣）
购票（购票单号，身份证号，航班编号，搭乘日期，购票金额）
有关关系模式的属性及相关说明如下： 
（1）航班表中的起飞时间和到达时间不包含日期，同一航班不会在一天出现两次及两次以上； 
（2）各航空公司会根据旅客出行淡旺季适时调整机票的折扣，旅客购买机票的购票金额计算公式为：票价×折扣×VIP 折扣，其中旅客的 VIP 折扣与该旅客已购买过的机票的购票金额总和相关，在旅客每次购票后被修改。VIP 折扣值的计算由函数 float vip_value（char[18]身份证号）完成。根据以上描述，回答下列问题。

【问题 1】（4 分） 请将如下创建购票关系的 SQL 语句的空缺部分补充完整，要求指定关系的主键、外键，以及购票金额<font color="#00b050">大于零</font>的约束。
CREATE TABLE 购票 （ 
购票单号 CHAR(15) <font color="#ff0000">primary key</font> , 
身份证号 CHAR(18), 
航班编号 CHAR(6), 
搭乘日期 DATE, 
购票金额 FLOAT <font color="#ff0000">check (购票金额>0)</font> , 
<font color="#ff0000">foreign key （身份证号）references 旅客（身份证号）</font> , 
<font color="#ff0000">foreign key （航班编号）references 航班（航班编号）</font> , 
）; 

【问题 2】（6 分） 
（1）身份证号为 210000196006189999 的客户购买了 2013 年 2 月 18 日CA5302 航班的机票，购票单号由系统自动生成。下面的 SQL 语句将上述购票信息加入系统中，请将空缺部分补充完整。 
INSERT INTO 购票（购票单号，身份证号，航班编号，搭乘日期，购票金额）
SELECT ‘201303105555’，‘210000196006189999’，‘CA5302’，‘2013/2/18’，
<font color="#ff0000">（票价×折扣×VIP 折扣）</font>
FROM 航班，折扣，旅客
WHERE <font color="#ff0000">航班.航班编号=折扣.航班编号</font>
AND 航班.航班编号=‘CA5302’ 
AND‘2013/2/18’BETWEEN 折扣.开始日期 
AND 折扣.结束日期
AND 旅客.身份证号 =‘210000196006189999’； 

（2）需要用触发器来实现 VIP 折扣的修改，调用函数 vip_value（）来实现。请将如下SQL 语句的空缺部分补充完整。
CREATE TRIGGER VIP TRG AFTER update
ON <font color="#ff0000">购票</font>
REFERENCING new row AS nrow
FOR EACH row
BEGIN 
UPDATE 旅客 SET <font color="#ff0000">VIP折扣=vip_value（nrow.身份证号）</font>
WHERE <font color="#ff0000">旅客.身份证号=nrow.身份证号</font> ; 
END 

【问题 3】（5 分） 
请将如下 SQL 语句的空缺部分补充完整。 
（1）查询搭乘日期在 2012 年 1 月 1 日至 2012 年 12 月 31 日之间，且合计购票金额大于等于10000 元的所有旅客的身份证号、姓名和购票金额总和，并按购票金额总和降序输出。
SELECT 旅客.身份证号，姓名，SUM（购票金额）
FROM 旅客，购票
WHERE <font color="#ff0000">旅客.身份证号=购票.身份证号 AND 搭乘日期 BETWEEN '2012/1/1' AND '2012/12/31'</font>
GROUP BY <font color="#ff0000">旅客.身份证号，姓名</font>
<font color="#ff0000">HAVING SUM（购票金额）>=10000</font>,
ORDER BY<font color="#ff0000"> SUM（购票金额）DESC</font> ; 

（2）经过中转的航班与相同始发地和目的地的直达航班相比，会享受更低的折扣。查询从广州到北京，经过一次中转的所有航班对，输出广州到中转地的航班编号、中转地和中转地到北京的航班编号。
SELECT <font color="#ff0000">航班 1.航班编号，航班 1.目的地，航班 2.航班编号</font>
FROM 航班航班 1，航班航班 2 
WHERE <font color="#ff0000">航班 1.起飞地=‘广州’AND 航班 2.目的地=‘北京’ AND 航班1.目的地=航班2. 起飞地</font> ;