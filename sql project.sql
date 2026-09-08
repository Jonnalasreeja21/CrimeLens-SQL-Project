create database crimelens;
use crimelens;
show tables;
create table crimes (
    crime_id int primary key auto_increment,
    crime_type varchar(100) not null,
    crime_date date not null,
    location varchar(100) not null,
    severity varchar(20),
    status  varchar(30)
);
create table victims (
    victim_id int primary key auto_increment,
    name varchar(100) not null,
    age int,
    gender varchar(20),
    crime_id int,
    foreign key (crime_id) references crimes(crime_id)
);
create table suspects (
    suspect_id int primary key auto_increment,
    name varchar(100) not null,
    age int,
    gender varchar(20),
    crime_id int,
    foreign key (crime_id) references crimes(crime_id)
);
create table officers (
    officer_id int primary key auto_increment,
    name varchar(100) not null,
    office_rank varchar(50),
    department varchar(100)
);
create table cases (
    case_id int primary key auto_increment,
    crime_id int,
    officer_id int,
    opened_date date,
    closed_date date,
    case_status varchar(30),
    foreign key (crime_id) references crimes(crime_id),
    foreign key (officer_id) references officers(officer_id)
);
create table evidence (
    evidence_id int primary key auto_increment,
    crime_id int,
    evidence_type varchar(100),
    evidence_Description varchar(255),
    collected_date date,
    foreign key (crime_id) references crimes(crime_id)
);
show tables; 
insert into crimes
(crime_type, crime_date, location, severity, status)
values
('Theft','2026-01-10','Hyderabad','Medium','Solved'),
('Cyber Crime','2026-01-15','Warangal','High','Pending'),
('Fraud','2026-02-05','Hyderabad','High','Solved'),
('Robbery','2026-02-20','Vijayawada','High','Pending'),
('Assault','2026-03-01','Guntur','Medium','Solved');
select * from crimes;
select * from evidence;

insert into officers
(name, office_rank, department)
values
('Ravi Kumar','Inspector','Cyber Crime'),
('Priya Sharma','SI','Criminal Investigation'),
('Arun Rao','Inspector','Law and Order');
select * from officers;

insert into victims
(name, age, gender, crime_id)
values
('Rahul',25,'Male',1),
('Sneha',30,'Female',2),
('Kiran',35,'Male',3),
('Anjali',28,'Female',4),
('Vijay',40,'Male',5)
select * from  victims;

insert into suspects
(name, age, gender, crime_id)
VALUES
('Rohit Sharma',28,'Male',1),
('Akhil Reddy',32,'Male',2),
('Neha Singh',27,'Female',3),
('Suresh Kumar',35,'Male',4),
('Manoj Rao',30,'Male',5),
('Karthik',26,'Male',2);

select * from suspects;
-- Find high-severity crimes
select * from crimes
where severity = 'High';

-- Count crimes
select  COUNT(*) as total_crimes
from crimes;

-- Location-wise crime count
select location, COUNT(*) as crime_count
from crimes
group by location

-- Crime types
select crime_type, COUNT(*) as total
from crimes
group by crime_type
order by total desc;

-- joins
-- Crime + Victim
select
    c.crime_id,
    c.crime_type,
    v.name as victim_name,
    c.location
from crimes c
join victims v
on c.crime_id = v.crime_id;

select crime_id, crime_type
from crimes;

insert into cases
(case_id, crime_id, officer_id, opened_date, closed_date, case_status)
values
(1, 1, 1, '2026-01-10', '2026-01-20', 'Solved'),
(2, 2, 2, '2026-01-15', NULL, 'Pending'),
(3, 3, 3, '2026-02-05', '2026-02-15', 'Solved'),
(4, 4, 1, '2026-02-20', NULL, 'Pending'),
(5, 5, 2, '2026-03-01', '2026-03-10', 'Solved'),
(6, 2, 3, '2026-03-15', NULL, 'Pending');

select * from cases;

-- Crime + Case + Officer
select
    c.crime_type,
    c.location,
    o.name as officer_name,
    ca.case_status
from crimes c
join cases ca
on c.crime_id = ca.crime_id
join officers o
on ca.officer_id = o.officer_id;

-- Subqueries
select name, age
from  victims
where age > (
    select  avg (age)
    from victims
);

select location
from crimes
group by location
having COUNT(*) > 1;

-- Views
create view crime_report as
select
    c.crime_id,
    c.crime_type,
    c.location,
    c.severity,
    c.status,
    ca.case_status,
    o.name as  officer_name
from crimes c
join cases ca
on c.crime_id = ca.crime_id
join officers o
on ca.officer_id = o.officer_id;

select * from crime_report;

-- Stored Procedures
delimiter //
create procedure GetCrimesByLocation(in loc varchar(100))
begin
    select *
    from crimes
    where location = loc;
end //
delimiter ;

call  GetCrimesByLocation('Hyderabad');

-- Functions
delimiter //
create function GetSeverityLevel(
    severity_value varchar(20)
)
returns varchar(20)
deterministic
begin
	if severity_value = 'High' then
        return 'Critical';
    elseif severity_value = 'Medium'  then
        return 'Moderate';
    else
        return 'Low';
    end if;
end //

delimiter ;

select
    crime_type,
    severity,
    GetSeverityLevel(severity) as severity_level
from crimes;

-- Triggers
create table crime_audit (
    audit_id int primary key auto_increment,
    crime_id int,
    action_type varchar(30),
    action_time timestamp default current_timestamp
);

delimiter //
create trigger after_crime_insert
after insert on crimes
for each row
begin
    insert into crime_audit(crime_id, action_type)
    values (new.crime_id, 'INSERT');
end //
delimiter ;

-- Transactions
start transaction;
insert into crimes
(crime_type, crime_date, location, severity, status)
values
('Cyber Crime','2026-04-10','Hyderabad','High','Pending');
insert into evidence
(crime_id, evidence_type, evidence_description, collected_date)
values
(LAST_INSERT_ID(), 'Digital', 'Mobile device', '2026-04-10');
commit

-- Index on location
create index idx_crime_location
on crimes(location);

-- Index on crime type
create index idx_crime_type
on crimes(crime_type);

show index from crimes;
-- Crime Summary Report
select
    crime_type,
    COUNT(*) as total_crimes
from crimes
group by crime_type
order by total_crimes desc;

-- Location-wise Report
select
    location,
    COUNT(*) as total_crimes
from crimes
group by location
order by total_crimes desc;
 
-- Pending Cases Report
select
    ca.case_id,
    c.crime_type,
    c.location,
    o.name as officer
from cases ca
join crimes c
on ca.crime_id = c.crime_id
join officers o
on ca.officer_id = o.officer_id
where ca.case_status = 'Pending';
 
 -- Monthly Crime Report
 select
    month(crime_date) as month,
    COUNT(*) as total_crimes
from crimes
group by month(crime_date)
order by month;