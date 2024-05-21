-- NOT NULL

USE RBPL_IITR;

CREATE TABLE cats2(
name VARCHAR(50) NOT NULL,
age INT NOT NULL
);

DESC cats2;

INSERT INTO cats2(age,name)
VALUES (13,'mini');

-- DEFAULT

CREATE TABLE cats3(
name VARCHAR(20) DEFAULT 'no name given',
age INT DEFAULT 99
);

INSERT INTO cats3(age)
VALUES (13);

SELECT * FROM cats3;

INSERT INTO cats3() VALUES();

-- Combine NOT NULL and DEFAULT

CREATE TABLE cats4(
name VARCHAR(20) NOT NULL DEFAULT 'unnamed',
age INT NOT NULL DEFAULT 99
);

INSERT INTO cats4(age)
VALUES (13);

INSERT INTO cats4(age,name)
VALUES(7, NULL);

SELECT * FROM cats4;


-- PRIMARY KEY

CREATE TABLE unique_dogs(

dog_id INT,
name VARCHAR(20) NOT NULL,
age INT NOT NULL,
PRIMARY KEY (dog_id)
);

DESC unique_dogs;

-- Another Way of defining PK
CREATE TABLE unique_dogs2(

dog_id INT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
age INT NOT NULL
);

-- AUTO INCREMENT
CREATE TABLE unique_dogs4(

dog_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
age INT NOT NULL
);

DESC unique_dogs3;

INSERT INTO unique_dogs4(dog_id,name,age)
VALUES (1007,'Dog1',14);

INSERT INTO unique_dogs4(name,age)
VALUES ('Dog2',14);

SELECT * FROM unique_dogs4;


-- Create 'employees' table with columns: id, first_name, last_name, middle_name, age, current_status
-- id is PK with auto increment, only middle_name column can aacept NULL values, default value in current_status is 'employed'
-- two records

CREATE TABLE employees(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
middle_name VARCHAR(20),
age INT NOT NULL,
current_status VARCHAR(100) NOT NULL DEFAULT 'employed'
);

INSERT INTO employees(first_name,last_name,age)
VALUES ('Shreyas','Shukla',30);

INSERT INTO employees(first_name, last_name, middle_name,age,current_status)
VALUES ('Mahendra','Dhoni','Singh',40,'semi-retired');

SELECT * FROM employees;

-- CRUD (CREATE, READ, UPDATE, DELETE) basics:

DROP TABLE IF EXISTS cats;

CREATE TABLE cats (
   cat_id INT AUTO_INCREMENT,
   name VARCHAR(100),
   breed VARCHAR(100),
   age INT,
   PRIMARY KEY (cat_id)
);

INSERT INTO cats(name, breed, age)
VALUES ('Ringo', 'Tabby', 4),
      ('Cindy', 'Maine Coon', 10),
      ('Dumbledore', 'Maine Coon', 11),
      ('Egg', 'Persian', 4),
      ('Misty', 'Tabby', 13),
      ('George Michael', 'Ragdoll', 9),
      ('Jackson', 'Sphynx', 7);
      
      
      
-- Get all the columns
SELECT * FROM cats;

-- Get a specific column (example: age)
SELECT age FROM cats;

-- Get multiple columns
SELECT name, breed FROM cats;

-- Get columns based on some condition
SELECT * FROM cats WHERE age = 4;

SELECT name, breed FROM cats WHERE age = 4;

SELECT * FROM cats WHERE breed = 'Tabby';

SELECT * FROM cats WHERE age = cat_id;

/*
1. get all the cat_id
2. get name and age of all the cats
3. get name and age of all the cats with 'Maine Coon' breed
4. all the columns where age is atleast 10 years old
5. Rename cat 'Misty' as 'Mishy'
6. Set the breed of 'Ringo' as 'Sidebottom'
 */
 
 
-- AS : alias
SELECT name AS n , breed AS cat_breed FROM cats;


-- UPDATE DATA
SET SQL_SAFE_UPDATES = 0;
UPDATE cats SET breed = 'Indian' WHERE breed = 'Persian';

SELECT * FROM cats;

UPDATE cats SET name = 'Nameless' WHERE cat_id = 7;


-- DELETE 

DELETE FROM cats WHERE name = 'Dumbledore';

SELECT * FROM cats;


DELETE FROM cats ;  -- Delete all the rows not the table
