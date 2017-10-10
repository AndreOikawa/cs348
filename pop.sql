-- Example commands for (re) creating the STUDENT-COURSE database.
-- NOTE: "insert" commands should be modified to create appropriate
-- test data.

connect to cs348

drop table course
create table course ( \
    cnum        varchar(5) not null, \
    cname       varchar(40) not null, \
    primary key (cnum) )

insert into course values ('CS448', 'Introduction to Databases')
insert into course values ('CS240', '240 CS')
insert into course values ('CS245', '245 CS')
insert into course values ('CS241', '241 CS')
insert into course values ('CS246', '246 CS')
insert into course values ('CS350', '350 CS')

drop table professor
create table professor ( \
    pnum        integer not null, \
    pname       varchar(20) not null, \
    office      varchar(10) not null, \
    dept        varchar(30) not null, \
    primary key (pnum) )

insert into professor values (1, 'Weddell, Grant', 'DC3346', 'CS')
insert into professor values (2, 'Ilyas, Ihab', 'DC3348', 'CO')
insert into professor values (3, 'A, Grant', 'DC1234', 'CS')
insert into professor values (4, 'A, Ihab', 'DC3322', 'CO')
insert into professor values (5, 'AA, Grant', 'DC3146', 'PM')
insert into professor values (6, 'AA, Ihab', 'DC1142', 'PM')
insert into professor values (7, 'AAA, Grant', 'DC2346', 'CS')
insert into professor values (8, 'AAA, Ihab', 'DC9348', 'CO')

drop table student
create table student ( \
    snum        integer not null, \
    sname       varchar(20) not null, \
    year        integer not null, \
    primary key (snum) )

insert into student values (1, 'Jones, Fred', 4)
insert into student values (2, 'A, B', 1)
insert into student values (3, 'A, D', 2)
insert into student values (4, 'A, F', 3)
insert into student values (5, 'A, H', 4)
insert into student values (6, 'B, B', 1)
insert into student values (7, 'B, D', 2)
insert into student values (8, 'B, F', 3)
insert into student values (9, 'B, H', 4)
insert into student values (10, 'C, B', 1)
insert into student values (11, 'C, D', 2)
insert into student values (12, 'C, F', 3)
insert into student values (13, 'C, H', 4)
insert into student values (14, 'D, B', 1)
insert into student values (15, 'D, D', 2)
insert into student values (16, 'D, F', 3)
insert into student values (17, 'D, H', 4)

drop table class
create table class ( \
    cnum        varchar(5) not null, \
    term        varchar(5) not null, \
    section     integer not null, \
    pnum        integer not null, \
    primary key (cnum, term, section), \
    foreign key (cnum) references course (cnum), \
    foreign key (pnum) references professor (pnum) )

insert into class values ('CS448', 'S2006', 1, 1)
insert into class values ('CS448', 'S2006', 2, 2)
insert into class values ('CS240', 'S2006', 1, 3)
insert into class values ('CS240', 'S2006', 2, 4)
insert into class values ('CS245', 'S2006', 1, 5)
insert into class values ('CS245', 'S2006', 2, 6)
insert into class values ('CS240', 'S2006', 1, 7)
insert into class values ('CS245', 'S2006', 2, 8)


drop table enrollment
create table enrollment ( \
    snum        integer not null, \
    cnum        varchar(5) not null, \
    term        varchar(5) not null, \
    section     integer not null, \
    primary key (snum, cnum, term, section), \
    foreign key (snum) references student (snum), \
    foreign key (cnum, term, section) references class (cnum, term, section) )

insert into enrollment select s.snum, c.cnum, c.term, c.section from student s cross join class c

drop table mark
create table mark ( \
    snum        integer not null, \
    cnum        varchar(5) not null, \
    term        varchar(5) not null, \
    section     integer not null, \
    grade       integer not null, \
    primary key (snum, cnum, term, section), \
    foreign key (snum, cnum, term, section) \
    references enrollment (snum, cnum, term, section) )

--insert into mark (snum, cnum, term, section, grade) select s.snum, c.cnum, c.term, c.section, cast((rand() * 100) as int) from student s cross join class c


drop table schedule
create table schedule ( \
    cnum        varchar(5) not null, \
    term        varchar(5) not null, \
    section     integer not null, \
    day         varchar(10) not null, \
    time        varchar(5) not null, \
    room        varchar(10) not null, \
    primary key (cnum, term, section, day, time), \
    foreign key (cnum, term, section) \
    references class (cnum, term, section) )

insert into schedule values ('CS448', 'S2006', 1, 'Monday', '09:30', 'MC4063')
insert into schedule values ('CS448', 'S2006', 1, 'Wednesday', '09:30', 'MC4063')
insert into schedule values ('CS448', 'S2006', 1, 'Friday', '09:30', 'MC4063')
insert into schedule values ('CS448', 'S2006', 2, 'Monday', '11:30', 'MC4058')
insert into schedule values ('CS448', 'S2006', 2, 'Wednesday', '11:30', 'MC4058')
insert into schedule values ('CS448', 'S2006', 2, 'Friday', '11:30', 'MC4058')

insert into mark (snum, cnum, term, section, grade) values (1, 'CS240', 'S2006',           1,           3)
insert into mark (snum, cnum, term, section, grade) values (2, 'CS240', 'S2006',           1,          40)
insert into mark (snum, cnum, term, section, grade) values (3, 'CS240', 'S2006',           1,           3)
insert into mark (snum, cnum, term, section, grade) values (4, 'CS240', 'S2006',           1,          55)
insert into mark (snum, cnum, term, section, grade) values (5, 'CS240', 'S2006',           1,          84)
insert into mark (snum, cnum, term, section, grade) values (6, 'CS240', 'S2006',           1,          45)
insert into mark (snum, cnum, term, section, grade) values (7, 'CS240', 'S2006',           1,          45)
insert into mark (snum, cnum, term, section, grade) values (8, 'CS240', 'S2006',           1,          18)
insert into mark (snum, cnum, term, section, grade) values (9, 'CS240', 'S2006',           1,           4)
insert into mark (snum, cnum, term, section, grade) values (10, 'CS240', 'S2006',           1,          11)
insert into mark (snum, cnum, term, section, grade) values (11, 'CS240', 'S2006',           1,          25)
insert into mark (snum, cnum, term, section, grade) values (12, 'CS240', 'S2006',           1,          36)
insert into mark (snum, cnum, term, section, grade) values (13, 'CS240', 'S2006',           1,          63)
insert into mark (snum, cnum, term, section, grade) values (14, 'CS240', 'S2006',           1,          61)
insert into mark (snum, cnum, term, section, grade) values (15, 'CS240', 'S2006',           1,          85)
insert into mark (snum, cnum, term, section, grade) values (16, 'CS240', 'S2006',           1,          40)
insert into mark (snum, cnum, term, section, grade) values (17, 'CS240', 'S2006',           1,          94)
insert into mark (snum, cnum, term, section, grade) values (1, 'CS240', 'S2006',           2,          60)
insert into mark (snum, cnum, term, section, grade) values (2, 'CS240', 'S2006',           2,          52)
insert into mark (snum, cnum, term, section, grade) values (3, 'CS240', 'S2006',           2,          14)
insert into mark (snum, cnum, term, section, grade) values (4, 'CS240', 'S2006',           2,          94)
insert into mark (snum, cnum, term, section, grade) values (5, 'CS240', 'S2006',           2,          93)
insert into mark (snum, cnum, term, section, grade) values (6, 'CS240', 'S2006',           2,          38)
insert into mark (snum, cnum, term, section, grade) values (7, 'CS240', 'S2006',           2,          12)
insert into mark (snum, cnum, term, section, grade) values (8, 'CS240', 'S2006',           2,          70)
insert into mark (snum, cnum, term, section, grade) values (9, 'CS240', 'S2006',           2,          13)
insert into mark (snum, cnum, term, section, grade) values (10, 'CS240', 'S2006',           2,          99)
insert into mark (snum, cnum, term, section, grade) values (11, 'CS240', 'S2006',           2,          43)
insert into mark (snum, cnum, term, section, grade) values (12, 'CS240', 'S2006',           2,          63)
insert into mark (snum, cnum, term, section, grade) values (13, 'CS240', 'S2006',           2,          94)
insert into mark (snum, cnum, term, section, grade) values (14, 'CS240', 'S2006',           2,          81)
insert into mark (snum, cnum, term, section, grade) values (15, 'CS240', 'S2006',           2,           2)
insert into mark (snum, cnum, term, section, grade) values (16, 'CS240', 'S2006',           2,          92)
insert into mark (snum, cnum, term, section, grade) values (17, 'CS240', 'S2006',           2,          40)
insert into mark (snum, cnum, term, section, grade) values (1, 'CS245', 'S2006',           1,          22)
insert into mark (snum, cnum, term, section, grade) values (2, 'CS245', 'S2006',           1,          79)
insert into mark (snum, cnum, term, section, grade) values (3, 'CS245', 'S2006',           1,          65)
insert into mark (snum, cnum, term, section, grade) values (4, 'CS245', 'S2006',           1,          12)
insert into mark (snum, cnum, term, section, grade) values (5, 'CS245', 'S2006',           1,          45)
insert into mark (snum, cnum, term, section, grade) values (6, 'CS245', 'S2006',           1,           6)
insert into mark (snum, cnum, term, section, grade) values (7, 'CS245', 'S2006',           1,          20)
insert into mark (snum, cnum, term, section, grade) values (8, 'CS245', 'S2006',           1,           8)
insert into mark (snum, cnum, term, section, grade) values (9, 'CS245', 'S2006',           1,           1)
insert into mark (snum, cnum, term, section, grade) values (10, 'CS245', 'S2006',           1,          84)
insert into mark (snum, cnum, term, section, grade) values (11, 'CS245', 'S2006',           1,          30)
insert into mark (snum, cnum, term, section, grade) values (12, 'CS245', 'S2006',           1,          50)
insert into mark (snum, cnum, term, section, grade) values (13, 'CS245', 'S2006',           1,           3)
insert into mark (snum, cnum, term, section, grade) values (14, 'CS245', 'S2006',           1,          53)
insert into mark (snum, cnum, term, section, grade) values (15, 'CS245', 'S2006',           1,          39)
insert into mark (snum, cnum, term, section, grade) values (16, 'CS245', 'S2006',           1,          39)
insert into mark (snum, cnum, term, section, grade) values (17, 'CS245', 'S2006',           1,          19)
insert into mark (snum, cnum, term, section, grade) values (1, 'CS245', 'S2006',           2,          34)
insert into mark (snum, cnum, term, section, grade) values (2, 'CS245', 'S2006',           2,          58)
insert into mark (snum, cnum, term, section, grade) values (3, 'CS245', 'S2006',           2,          15)
insert into mark (snum, cnum, term, section, grade) values (4, 'CS245', 'S2006',           2,          47)
insert into mark (snum, cnum, term, section, grade) values (5, 'CS245', 'S2006',           2,          17)
insert into mark (snum, cnum, term, section, grade) values (6, 'CS245', 'S2006',           2,          95)
insert into mark (snum, cnum, term, section, grade) values (7, 'CS245', 'S2006',           2,          70)
insert into mark (snum, cnum, term, section, grade) values (8, 'CS245', 'S2006',           2,          47)
insert into mark (snum, cnum, term, section, grade) values (9, 'CS245', 'S2006',           2,          24)
insert into mark (snum, cnum, term, section, grade) values (10, 'CS245', 'S2006',           2,          48)
insert into mark (snum, cnum, term, section, grade) values (11, 'CS245', 'S2006',           2,          83)
insert into mark (snum, cnum, term, section, grade) values (12, 'CS245', 'S2006',           2,          68)
insert into mark (snum, cnum, term, section, grade) values (13, 'CS245', 'S2006',           2,          15)
insert into mark (snum, cnum, term, section, grade) values (14, 'CS245', 'S2006',           2,          24)
insert into mark (snum, cnum, term, section, grade) values (15, 'CS245', 'S2006',           2,           2)
insert into mark (snum, cnum, term, section, grade) values (16, 'CS245', 'S2006',           2,          20)
insert into mark (snum, cnum, term, section, grade) values (17, 'CS245', 'S2006',           2,          73)
insert into mark (snum, cnum, term, section, grade) values (1, 'CS448', 'S2006',           1,          30)
insert into mark (snum, cnum, term, section, grade) values (2, 'CS448', 'S2006',           1,          47)
insert into mark (snum, cnum, term, section, grade) values (3, 'CS448', 'S2006',           1,          43)
insert into mark (snum, cnum, term, section, grade) values (4, 'CS448', 'S2006',           1,          22)
insert into mark (snum, cnum, term, section, grade) values (5, 'CS448', 'S2006',           1,          83)
insert into mark (snum, cnum, term, section, grade) values (6, 'CS448', 'S2006',           1,          62)
insert into mark (snum, cnum, term, section, grade) values (7, 'CS448', 'S2006',           1,          25)
insert into mark (snum, cnum, term, section, grade) values (8, 'CS448', 'S2006',           1,          34)
insert into mark (snum, cnum, term, section, grade) values (9, 'CS448', 'S2006',           1,          96)
insert into mark (snum, cnum, term, section, grade) values (10, 'CS448', 'S2006',           1,          81)
insert into mark (snum, cnum, term, section, grade) values (11, 'CS448', 'S2006',           1,          12)
insert into mark (snum, cnum, term, section, grade) values (12, 'CS448', 'S2006',           1,          69)
insert into mark (snum, cnum, term, section, grade) values (13, 'CS448', 'S2006',           1,          83)
insert into mark (snum, cnum, term, section, grade) values (14, 'CS448', 'S2006',           1,          56)
insert into mark (snum, cnum, term, section, grade) values (15, 'CS448', 'S2006',           1,          75)
insert into mark (snum, cnum, term, section, grade) values (16, 'CS448', 'S2006',           1,          98)
insert into mark (snum, cnum, term, section, grade) values (17, 'CS448', 'S2006',           1,          34)
insert into mark (snum, cnum, term, section, grade) values (1, 'CS448', 'S2006',           2,          90)
insert into mark (snum, cnum, term, section, grade) values (2, 'CS448', 'S2006',           2,          59)
insert into mark (snum, cnum, term, section, grade) values (3, 'CS448', 'S2006',           2,          57)
insert into mark (snum, cnum, term, section, grade) values (4, 'CS448', 'S2006',           2,          18)
insert into mark (snum, cnum, term, section, grade) values (5, 'CS448', 'S2006',           2,          29)
insert into mark (snum, cnum, term, section, grade) values (6, 'CS448', 'S2006',           2,          96)
insert into mark (snum, cnum, term, section, grade) values (7, 'CS448', 'S2006',           2,          98)
insert into mark (snum, cnum, term, section, grade) values (8, 'CS448', 'S2006',           2,          53)
insert into mark (snum, cnum, term, section, grade) values (9, 'CS448', 'S2006',           2,          68)
insert into mark (snum, cnum, term, section, grade) values (10, 'CS448', 'S2006',           2,          96)
insert into mark (snum, cnum, term, section, grade) values (11, 'CS448', 'S2006',           2,          57)
insert into mark (snum, cnum, term, section, grade) values (12, 'CS448', 'S2006',           2,          98)
insert into mark (snum, cnum, term, section, grade) values (13, 'CS448', 'S2006',           2,          15)
insert into mark (snum, cnum, term, section, grade) values (14, 'CS448', 'S2006',           2,           4)
insert into mark (snum, cnum, term, section, grade) values (15, 'CS448', 'S2006',           2,          21)
insert into mark (snum, cnum, term, section, grade) values (16, 'CS448', 'S2006',           2,          20)
insert into mark (snum, cnum, term, section, grade) values (17, 'CS448', 'S2006',           2,          57)
commit work
