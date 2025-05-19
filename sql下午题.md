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
BEGIN IF INSERTING THEN
UPDATE School  <font color="#ff0000">SET schstunum=schstunum+1 WHERE School.schno=nrow.schno</font>
END IF; 
IF DELETING THEN
UPDATE School <font color="#ff0000">SET schstunum=schstunum-1 WHERE School.schno=orow.schno</font> ;
END IF;
END; 

【问题 4】（2 分）
查询年龄小于 19 岁的学生的学号、姓名及所属学院名，要求输出结果把同一个学院的学生排在一起，此功能由下面的 SQL 语句实现，请补全。
SELECT stuno,stuname,schname
FROM Student,School
WHERE Student.schno=School.schno
AND stuage<19 <font color="#ff0000">order</font> BY <font color="#ff0000">schname </font>;

## 2018