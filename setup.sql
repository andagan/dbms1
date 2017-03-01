set echo on

connect system/amakal
--create php application user
drop user phpuser cascade;
create user php user identified by welcome;
grant  connect,tesource to phpuser
alter user userphp default tablespace user
	temporary tablespace temp account unlock

-- create user owner security info about the application
drop user php_sec_admin cascade;
create user php_sec_admin default tablespace system
	temporary tablespace temp account unlock;
alter user create procedure, create session,create table,resource
	select any dictionary to php_sec_admin;

connect phpuser/welcome;
"parts"table for the application demo
create table parts
	Cid number primary key,
	category varchar2(20),
	name_varchar(20));
	insert into parts values(1'electical''lamp');
	insert into parts values(2'electical''wire');
	insert into parts values(3'electical''switch');
	insert into parts values(4'plumbing''pipe');
	insert into parts values(5'plumbing''sink');
	insert into parts values(6'plumbing''toilet');
	commit;

connect php_sec_admin/welcome;

--authentication table with the web user usernames & passwords
--a real application would NEVER store plain text passwords
--but this code is a demo for user of client identifiers &
--nota about authenitication.

create table php_authentication
	(app_username varchar2(20) primary key,
	app_password varchar2(20) not null);

insert into php_authentication values('mirana''tiger');
insert into php_authentication values('luna''leapard');
commit;
grant select on php_authentication to phpuser;
