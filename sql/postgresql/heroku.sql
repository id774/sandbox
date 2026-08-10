-- Create a local heroku role and database for development.

create user heroku;
alter user heroku with password 'heroku';
alter role heroku createdb;
create database heroku;
