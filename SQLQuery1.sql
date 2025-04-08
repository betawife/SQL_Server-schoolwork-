--DECLARE @S int ,@i int
--SET @i=0
--SET @S=0
--WHIlE @i<=100
--BEGIN 
--SET @S =@S+@i
--SET @i=@i+1
--END
--PRINT '1+2+...+100='+CAST(@S AS char(25)) 

--DECLARE @avg float 
--USE School 
--IF (SELECT COUNT(*)FROM score WHERE 学号='108')=0 
--GOTO labell 
--BEGIN 
--PRINT '108学号学生的平均成绩：'
--SELECT @avg=AVG(分数)FROM score WHERE 学号= '108' AND 分数 IS NOT NULL 
--PRINT @avg 
--RETURN 
--END 
--labell: 
--PRINT '108学号的学生无成绩'

--USE School 
--IF OBJECT_ID('stud','U') IS NULL 
--PRINT ' school数据库中没有stud表'
--ELSE 
--SELECT * FROM Student
--GO 

--USE School 
--SELECT student.学号, student.姓名, score.课程号,
--CASE 
--WHEN 分数>=80 THEN 'PASS' 
--WHEN 分数<80 THEN 'NO PASS' 
--END AS '成绩'
--FROM student, score 
--WHERE student.学号= score.学号 AND student.班号='1003' 
--ORDER BY 学号

--USE test
--GO
--IF OBJECT_ID('tb1','U') IS NOT NULL
--DROP TABLE tbl
--GO
--CREATE TABLE tbl(ID int PRIMARY KEY)
--BEGIN TRY
--INSERT INTO tbl(ID) VALUES(1);
--INSERT INTO tbl(ID) VALUES(2);
--UPDATE tbl SET ID=1 WHERE ID = 2
--END TRY
--BEGIN CATCH
--PRINT '在CATCH中';
--THROW
--PRINT 'OK'
--END CATCH

--USE school
--GO
--DECLARE @fs int
----声明变量
--DECLARE @n1 int,@n2 int
--SET @n1=0
--SET @n2=0
--DECLARE fs_cursor CURSOR
----声明游标
--FOR SELECT 分数 FROM score WHERE 分数 IS NOT NULL
--OPEN fs_cursor
----打开游标
--FETCH NEXT FROM fs_cursor INTO @fs
----提取第一行数据
--WHILE @@FETCH_STATUS = 0
--BEGIN
--IF @fs>=80 SET @n1=@n1+1
--ELSE SET @n2=@n2+1
--FETCH NEXT FROM fs_cursor INTO @fs
----提取下一行数据
--END
--CLOSE fs_cursor
----关闭游标
--DEALLOCATE fs_cursor
----释放游标
--PRINT '80分以上人次：'+CAST(@n1 AS CHAR(3))
--PRINT '其他人次：'+CAST(@n2 AS CHAR(3))
--GO

--USE school
--GO
--SET NOCOUNT ON
---- 声明变量
--DECLARE @sno int,@sname char(10),@sclass char(10),@savg float
---- 声明游标
--DECLARE st_cursor CURSOR
--FOR SELECT student.学号,student.姓名,student.班号,AVG(score.分数)
--FROM student,score
--WHERE student.学号=score.学号 AND score.分数>0
--GROUP BY student.学号,student.姓名,student.班号
--ORDER BY student.班号,student.学号
---- 打开游标
--OPEN st_cursor
---- 提取第一行数据
--FETCH NEXT FROM st_cursor INTO @sno,@sname,@sclass,@savg
---- 打印表标题
--PRINT'学号 姓名 班号 平均分'
--PRINT'---------------------'
--WHILE @@FETCH_STATUS = 0
--BEGIN
---- 打印一行数据
--PRINT CAST(@sno AS char(8))+@sname+@sclass +' '+
--CAST(@savg AS char(5))
---- 提取下一行数据
--FETCH NEXT FROM st_cursor INTO @sno,@sname,@sclass,@savg
--END
---- 关闭游标
--CLOSE st_cursor
---- 释放游标
--DEALLOCATE st_cursor
--GO

USE school
GO
ALTER TABLE score ADD 等级 char(2)
GO
DECLARE st_cursor CURSOR
FOR SELECT 分数 FROM score WHERE 分数 IS NOT NULL
DECLARE @fs int,@dj char(1)
OPEN st_cursor
FETCH NEXT FROM st_cursor INTO @fs
WHILE @@FETCH_STATUS = 0
BEGIN
SET @dj = CASE
WHEN @fs >= 90 THEN 'A'
WHEN @fs >= 80 THEN 'B'
WHEN @fs >= 70 THEN 'C'
WHEN @fs >= 60 THEN 'D'
ELSE 'E'
END
UPDATE score
SET 等级 = @dj
WHERE CURRENT OF st_cursor
FETCH NEXT FROM st_cursor INTO @fs
END
CLOSE st_cursor
DEALLOCATE st_cursor
GO
SELECT * FROM score ORDER BY 学号
ALTER TABLE score DROP COLUMN 等级
