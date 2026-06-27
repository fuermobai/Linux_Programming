--
-- 新建 children 数据表
--


create table children(
	childno int(11) not null auto_increment,
	fname varchar(30),
	age int(11),
	primary key (childno)
);

--
-- children表格构成：
--

insert into children(childno,fname,age) values(1,'Jenny',21);
insert into children(childno,fname,age) values(2,'Andrew',17);
insert into children(childno,fname,age) values(3,'Gavin',8);
insert into children(childno,fname,age) values(4,'Duncan',6);
insert into children(childno,fname,age) values(5,'Emma',4);
insert into children(childno,fname,age) values(6,'Alex',15);
insert into children(childno,fname,age) values(7,'Adrian',9);
