alter table useraccount alter column username type varchar(100);
alter table useraccount alter column username set not null;
alter table useraccount add unique (username);

update useraccount set username = 'gabe@gabrieltocci.com' where id = 1;
update useraccount set username = 'rachaeltocci@email.com' where id = 2;
commit;