USE Library2257

--ALTER TABLE student2257
--ADD CONSTRAINT CK_student2257_性别 CHECK (性别 IN ('男', '女'));

--ALTER TABLE student2257
--ADD CONSTRAINT DF_student2257_性别 DEFAULT '男' FOR 性别;

--ALTER TABLE student2257
--ADD CONSTRAINT FK_student2257_班号 
--FOREIGN KEY (班号) REFERENCES depart2257(班号);

--ALTER TABLE borrow2257
--ADD CONSTRAINT PK_borrow2257 PRIMARY KEY (学号, 图书编号);

---- 删除student表的性别检查约束
--ALTER TABLE student2257
--DROP CONSTRAINT CK_student2257_性别;

---- 删除student表性别的默认值约束
--ALTER TABLE student2257
--DROP CONSTRAINT DF_student2257_性别;

---- 删除student表的班号外键约束
--ALTER TABLE student2257
--DROP CONSTRAINT FK_student2257_班号;

---- 删除borrow表的主键约束
--ALTER TABLE borrow2257
--DROP CONSTRAINT PK_borrow2257;


--BEGIN TRANSACTION;

--SELECT * FROM depart2257;

--INSERT INTO depart2257 (班号, 系名) VALUES ('601', '计算机系');
--INSERT INTO depart2257 (班号, 系名) VALUES ('602', '数学系');

--SELECT * FROM depart2257;

--ROLLBACK TRANSACTION;

--SELECT * FROM depart2257;



--BEGIN TRANSACTION;
--SELECT * FROM depart2257;


--INSERT INTO depart2257 (班号, 系名) VALUES ('701', '英语系');
--SAVE TRANSACTION SavePoint1;

--INSERT INTO depart2257 (班号, 系名) VALUES ('703', '物理系');
--INSERT INTO depart2257 (班号, 系名) VALUES ('704', '历史系');

--SELECT * FROM depart2257;

--ROLLBACK TRANSACTION SavePoint1;
--SELECT * FROM depart2257;

--COMMIT TRANSACTION;

--SELECT * FROM depart2257;


GO
CREATE FUNCTION dbo.Sum (@n INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT = 0;
    DECLARE @i INT = 1;
    
    WHILE @i <= @n
    BEGIN
        SET @result = @result + @i;
        SET @i = @i + 1;
    END
    
    RETURN @result;
END;
GO

-- 测试函数
SELECT dbo.Sum(10) AS '1到10的和';  -- 应返回55
SELECT dbo.Sum(100) AS '1到100的和'; -- 应返回5050

GO
CREATE FUNCTION dbo.nbook2 (@系名 VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT s.学号, s.姓名, s.班号, b.图书名, br.借书日期
    FROM student2257 s
    JOIN depart2257 d ON s.班号 = d.班号
    JOIN borrow2257 br ON s.学号 = br.学号
    JOIN book2257 b ON br.图书编号 = b.图书编号
    WHERE d.系名 = @系名
);
GO

-- 测试函数
SELECT * FROM dbo.nbook2('计算机系');
SELECT * FROM dbo.nbook2('电子工程系');

GO
CREATE FUNCTION dbo.pbook ()
RETURNS @result TABLE (系名 VARCHAR(50), 平均价格 DECIMAL(10,2))
AS
BEGIN
    INSERT INTO @result
    SELECT d.系名, AVG(b.定价) AS 平均价格
    FROM depart2257 d
    JOIN student2257 s ON d.班号 = s.班号
    JOIN borrow2257 br ON s.学号 = br.学号
    JOIN book2257 b ON br.图书编号 = b.图书编号
    GROUP BY d.系名;
    
    RETURN;
END;
GO
-- 测试函数
SELECT * FROM dbo.pbook();

GO
CREATE PROCEDURE dbo.sp_BookTypeCount
AS
BEGIN
    SELECT 出版社, COUNT(*) AS 图书数量
    FROM book2257
    GROUP BY 出版社
    ORDER BY 图书数量 DESC;
END;
GO

-- 测试存储过程
EXEC dbo.sp_BookTypeCount;

GO
CREATE PROCEDURE dbo.sp_FindStudentByBook2
    @bookName VARCHAR(100)
AS
BEGIN
    SELECT s.学号, s.姓名, s.班号, b.图书名
    FROM student2257 s
    JOIN borrow2257 br ON s.学号 = br.学号
    JOIN book2257 b ON br.图书编号 = b.图书编号
    WHERE b.图书名 LIKE '%' + @bookName + '%';
END;
GO

-- 测试存储过程
EXEC dbo.sp_FindStudentByBook2 '数据结构';  -- 查询书名包含"数据库"的借阅学生
EXEC dbo.sp_FindStudentByBook2 '操作系统';   -- 查询书名包含"编程"的借阅学生