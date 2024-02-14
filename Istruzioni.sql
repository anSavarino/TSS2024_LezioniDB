create database if not exists tss2024;
show create database tss2024;
-- create database if not exists test;
-- drop database if exists test;
show warnings;
create user 'app_tss'@'localhost' identified by 'tss_2024!';
create user 'app_test'@'localhost' identified by 'test';
grant all on tss2024.* to 'app_tss'@'localhost';

create database if not exists java;
grant all on java.* to 'app_tss'@'localhost';


create database if not exists corsi;
grant all on corsi.* to 'app_tss'@'localhost';