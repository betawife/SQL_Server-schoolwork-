CREATE DATABASE Library2257 
ON(NAME=Library2257,FILENAME='D:\SQL\SQL_Library\Library2257.MDF',SIZE=10MB,MAXSIZE=50MB,FILEGROWTH=5MB)
LOG ON(NAME=Library2257_log,FILENAME='D:\SQL\SQL_Library\Library2257_log.LDF',SIZE=10MB,MAXSIZE=20MB,FILEGROWTH=5MB)

CREATE TABLE depart2257(��� int NOT NULL PRIMARY KEY  ,ϵ�� char(20) )
CREATE TABLE student2257(ѧ�� int NOT NULL PRIMARY KEY , ���� char(20) ,�Ա� char(2), �������� datetime ,��� int )
CREATE TABLE book2257(ͼ���� int NOT NULL PRIMARY KEY, ͼ���� char(20) ,���� char(20), ���� int ,������ char(20))
CREATE TABLE borrow2257(ѧ�� int NOT NULL , ͼ���� int ,�������� datetime  PRIMARY KEY(ѧ��  ,ͼ����))