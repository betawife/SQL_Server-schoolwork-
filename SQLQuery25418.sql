--CREATE DATABASE test ;

USE test
--GO
--IF OBJECT_ID('table9','U') IS NOT NULL
--DROP TABLE table9

--GO
--CREATE TABLE table9
--( c1 smallint,
--c2 smallint DEFAULT 10 * 2,
--c3 char(10),
--c4 char(10) DEFAULT'xyz')
--GO
--IF OBJECT_ID('con3','D') IS NOT NULL
--DROP DEFAULT con3

--GO
--CREATE DEFAULT con3 AS 'China'
--GO
--EXEC sp_bindefault con3,'table9.c3'

--GO
--INSERT INTO table9(c1) VALUES (1)

--INSERT INTO table9(c1,c2) VALUES (2,50)
--INSERT INTO table9(c1,c3) VALUES (3,'Wuhan')
--INSERT INTO table9(c1,c3,c4) VALUES (4,'Beijing','Good')
--SELECT * FROM table9
--GO

--CREATE TABLE table10 (
--    学号 int,
--    姓名 char(10),
--    专业 char(20),
--    分数 int
--);

--ALTER TABLE table10
--ALTER COLUMN 学号 int NOT NULL;

--ALTER TABLE table10
--ADD CONSTRAINT PK_table10 PRIMARY KEY (学号);

--ALTER TABLE table10
--ADD CONSTRAINT CHK_table10_分数 CHECK (分数 >= 1 AND 分数 <= 100);

--ALTER TABLE table10
--ADD CONSTRAINT DF_table10_专业 DEFAULT '计算机科学与技术' FOR 专业;

CREATE TABLE table11 (
    图书编号 int,
   书名 char(30),
   借书人学号 int 
);
ALTER TABLE table11
ADD CONSTRAINT FK_table11_table10 FOREIGN KEY (借书人学号) REFERENCES table10(学号);
