CREATE DATABASE Library2257 
ON(NAME=Library2257,FILENAME='D:\SQL\SQL_Library\Library2257.MDF',SIZE=10MB,MAXSIZE=50MB,FILEGROWTH=5MB)
LOG ON(NAME=Library2257_log,FILENAME='D:\SQL\SQL_Library\Library2257_log.LDF',SIZE=10MB,MAXSIZE=20MB,FILEGROWTH=5MB)

CREATE TABLE depart2257(班号 int NOT NULL PRIMARY KEY  ,系名 char(20) )
CREATE TABLE student2257(学号 int NOT NULL PRIMARY KEY , 姓名 char(20) ,性别 char(2), 出生日期 datetime ,班号 int )
CREATE TABLE book2257(图书编号 int NOT NULL PRIMARY KEY, 图书名 char(20) ,作者 char(20), 定价 int ,出版社 char(20))
CREATE TABLE borrow2257(学号 int NOT NULL , 图书编号 int ,借书日期 datetime  PRIMARY KEY(学号  ,图书编号))