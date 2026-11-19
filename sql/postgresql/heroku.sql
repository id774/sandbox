-- heroku.sql: Local heroku role and database
--
-- Description:
-- Create a local heroku role and database for development, with the role
-- password heroku and the right to create databases.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     psql -f heroku.sql
--
-- Requirements:
-- - PostgreSQL with a superuser connection for psql
--

create user heroku;
alter user heroku with password 'heroku';
alter role heroku createdb;
create database heroku;
