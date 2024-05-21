
-- Use double dash for comments

-- Showing Databases in your server
SHOW DATABASES;

-- Creating a database
CREATE DATABASE soap_store;
CREATE DATABASE RBPL_IITR;

-- Using a database
USE RBPL_IITR;

-- Creating Tables

CREATE TABLE hello(
name varchar(50));

-- CREATE TABLE <table_name>(<column1_name datatype>, <col2_name,datatype> ..... )
CREATE TABLE cats(
name VARCHAR(50),
age INT );

CREATE TABLE dogs(
name VARCHAR(50), 
breed VARCHAR(50), 
age INT );

-- Showing tables in the database
SHOW TABLES;

-- Showing columns from a table
SHOW COLUMNS FROM dogs;

-- Describe tables
DESC cats;

-- Dropping or permanently deleting table
DROP TABLE hello;

-- Dropping or permanently deleting a database
DROP DATABASE soap_store;


-- INSERTING SINGLE values
DESC dogs;

INSERT INTO dogs(age,breed,name)
VALUES (11,'labrador','Jackie'); -- Strings can take any value

INSERT INTO dogs(age,name)
VALUES (13,'Mini');

INSERT INTO dogs(age,name)
VALUES (15);  -- This will throw an error

-- Inserting multiple values
INSERT INTO dogs(age,breed,name)
VALUES (11,'labrador1','Tiger'),
(18,'breed2','Mickie'),
(19,'breed3','Fluffy');


INSERT INTO dogs(age,breed,name)
VALUES (11,'l8127&^%$%981','T9213981');

INSERT INTO dogs(age,breed,name)
VALUES ('seven',3562,'T9213981');


-- Query a table
SELECT * FROM dogs;

-- Data Types
DROP DATABASE IF EXISTS teams;
CREATE DATABASE teams;
USE teams;

CREATE TABLE Australia(
player_name VARCHAR(25),
age TINYINT,
dob DATE,
match_time time,
debut_year year,
first_innings datetime
);
 DESC Australia;
 INSERT INTO Australia (player_name,age,dob,first_innings)
 VALUES ('Steve Smith',27,'1997-11-29','2009-12-18 10:08:56');
 INSERT INTO Australia (player_name,age,dob,first_innings, match_time, debut_year)
 VALUES ('David Smith',27,'1997-11-29','2009-04-18 13:08:56','11:05:52','2012');
SELECT * FROM Australia;

-- Create a list of 7 players with table Australia