USE School
----12题
--DECLARE @course_id varchar(20) 
--DECLARE @course_name varchar(50)
--DECLARE @avg_score decimal(5,2)

--DECLARE course_cursor CURSOR FOR
--SELECT c.课程号, c.课程名
--FROM Course c

--OPEN course_cursor

--FETCH NEXT FROM course_cursor INTO @course_id, @course_name

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SELECT @avg_score = AVG(CAST(分数 AS decimal(5,2)))
--    FROM Score
--    WHERE 课程号 = @course_id
    
--    PRINT  '课程名: ' + @course_name + ', 平均分: ' + CAST(ISNULL(@avg_score, 0) AS varchar(10))
   
--   FETCH NEXT FROM course_cursor INTO @course_id, @course_name
--END

--CLOSE course_cursor
--DEALLOCATE course_cursor


----13题
--DECLARE @学号 varchar(20)
--DECLARE @课程号 varchar(20)
--DECLARE @分数 int
--DECLARE @等级 char(1)

--DECLARE score_cursor CURSOR FOR
--SELECT 学号, 课程号, 分数 FROM Score

--OPEN score_cursor

--CREATE TABLE #Result (
--    学号 varchar(20),
--    课程号 varchar(20),
--    等级 char(1)
--)

--FETCH NEXT FROM score_cursor INTO @学号, @课程号, @分数
--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SET @等级 = CASE 
--        WHEN @分数 >= 90 THEN 'A'
--        WHEN @分数 >= 80 THEN 'B'
--        WHEN @分数 >= 70 THEN 'C'
--        WHEN @分数 >= 60 THEN 'D'
--        ELSE 'E'
--    END
--    PRINT '学号: ' + @学号 + ', 课程号: ' + @课程号 + ', 等级: ' + @等级
--    INSERT INTO #Result VALUES (@学号, @课程号, @等级)
--    FETCH NEXT FROM score_cursor INTO @学号, @课程号, @分数
--END
--CLOSE score_cursor
--DEALLOCATE score_cursor

--SELECT * FROM #Result
--DROP TABLE #Result


----14题
--DECLARE @班号 varchar(20)
--DECLARE @课程号 varchar(20)
--DECLARE @课程名 varchar(100)
--DECLARE @平均分 decimal(10,2)

--DECLARE class_course_cursor CURSOR FOR
--SELECT DISTINCT s.班号, c.课程号, c.课程名
--FROM Student s
--JOIN Score sc ON s.学号 = sc.学号
--JOIN Course c ON sc.课程号 = c.课程号
--ORDER BY s.班号, c.课程号

--CREATE TABLE #ClassCourseAvg (
--    班号 varchar(20),
--    课程号 varchar(20),
--    课程名 varchar(100),
--    平均分 decimal(10,2)
--)

--OPEN class_course_cursor
--FETCH NEXT FROM class_course_cursor INTO @班号, @课程号, @课程名

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SELECT @平均分 = AVG(CAST(sc.分数 AS decimal(10,2)))
--    FROM Student s
--    JOIN Score sc ON s.学号 = sc.学号
--    WHERE s.班号 = @班号 AND sc.课程号 = @课程号

--    INSERT INTO #ClassCourseAvg VALUES (@班号, @课程号, @课程名, @平均分)

--    FETCH NEXT FROM class_course_cursor INTO @班号, @课程号, @课程名
--END

--CLOSE class_course_cursor
--DEALLOCATE class_course_cursor

--SELECT 班号, 课程号, 课程名, 平均分
--FROM #ClassCourseAvg
--ORDER BY 班号, 课程号

--DROP TABLE #ClassCourseAvg

USE Library2257
----01
--CREATE TABLE #PublisherRatio (
--    出版社 varchar(100),
--    图书数量 int,
--    图书比例 decimal(5,2),
--    比例等级 varchar(10)
--)
--DECLARE @出版社 varchar(100)
--DECLARE @图书数量 int
--DECLARE @总数量 int
--DECLARE @图书比例 decimal(10,2)
--DECLARE @比例等级 varchar(10)

--SELECT @总数量 = COUNT(*) FROM book2257

--DECLARE publisher_cursor CURSOR FOR
--SELECT 出版社, COUNT(*) 
--FROM book2257
--GROUP BY 出版社

--OPEN publisher_cursor
--FETCH NEXT FROM publisher_cursor INTO @出版社, @图书数量

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SET @图书比例 = (@图书数量 * 100.0) / @总数量
--    SET @比例等级 = CASE 
--        WHEN @图书比例 > 50 THEN '很高'
--        WHEN @图书比例 > 30 THEN '较高'
--        WHEN @图书比例 > 10 THEN '一般'
--        ELSE '其他'
--    END

--    INSERT INTO #PublisherRatio VALUES (@出版社, @图书数量, @图书比例, @比例等级)

--    FETCH NEXT FROM publisher_cursor INTO @出版社, @图书数量
--END

--CLOSE publisher_cursor
--DEALLOCATE publisher_cursor
--SELECT 
--    出版社,
--    图书数量,
--    图书比例,
--    比例等级
--FROM #PublisherRatio
--ORDER BY 图书比例 ASC

--DROP TABLE #PublisherRatio

----02
--DECLARE @系名 varchar(50)
--DECLARE @学生总数 int
--DECLARE @借书学生数 int
--DECLARE @借书比例 decimal(10,2)
--DECLARE @比例等级 varchar(10)

--CREATE TABLE #DeptBorrowStats (
--    系名 varchar(50),
--    学生总数 int,
--    借书学生数 int,
--    借书比例 decimal(10,2),
--    比例等级 varchar(10)
--)

--DECLARE dept_cursor CURSOR FOR
--SELECT DISTINCT d.系名 
--FROM depart2257 d
--ORDER BY d.系名

--OPEN dept_cursor
--FETCH NEXT FROM dept_cursor INTO @系名

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SELECT @学生总数 = COUNT(DISTINCT s.学号)
--    FROM student2257 s
--    JOIN depart2257 d ON s.班号 = d.班号
--    WHERE d.系名 = @系名

--    SELECT @借书学生数 = COUNT(DISTINCT b.学号)
--    FROM borrow2257 b
--    JOIN student2257 s ON b.学号 = s.学号
--    JOIN depart2257 d ON s.班号 = d.班号
--    WHERE d.系名 = @系名

--    IF @学生总数 > 0
--        SET @借书比例 = CAST(@借书学生数 AS decimal(10,2)) / @学生总数 * 100
--    ELSE
--        SET @借书比例 = 0

--    SET @比例等级 = CASE
--        WHEN @借书比例 > 50 THEN '很高'
--        WHEN @借书比例 > 30 THEN '较高'
--        WHEN @借书比例 > 10 THEN '一般'
--        ELSE '较低'
--    END

--    INSERT INTO #DeptBorrowStats 
--    VALUES (@系名, @学生总数, @借书学生数, @借书比例, @比例等级)

--    FETCH NEXT FROM dept_cursor INTO @系名
--END

--CLOSE dept_cursor
--DEALLOCATE dept_cursor

--SELECT 系名, 学生总数, 借书学生数, 借书比例, 比例等级
--FROM #DeptBorrowStats
--ORDER BY 借书比例 DESC

--DROP TABLE #DeptBorrowStats

----03
--DECLARE @图书名 varchar(100)
--DECLARE @定价 decimal(10,2)
--DECLARE @价格评价 varchar(10)

--CREATE TABLE #BookPriceEvaluation (
--    图书名 varchar(100),
--    定价 decimal(10,2),
--    价格评价 varchar(10)
--)

--DECLARE book_cursor CURSOR FOR
--SELECT 图书名, 定价 FROM book2257

--OPEN book_cursor
--FETCH NEXT FROM book_cursor INTO @图书名, @定价

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SET @价格评价 = CASE 
--        WHEN @定价 > 45 THEN '高'
--        WHEN @定价 > 30 THEN '较高'
--        WHEN @定价 > 15 THEN '一般'
--        ELSE '低'
--    END
--    INSERT INTO #BookPriceEvaluation VALUES (@图书名, @定价, @价格评价)

--    FETCH NEXT FROM book_cursor INTO @图书名, @定价
--END

--CLOSE book_cursor
--DEALLOCATE book_cursor

--SELECT * FROM #BookPriceEvaluation
--ORDER BY 
--    CASE 价格评价
--        WHEN '高' THEN 4
--        WHEN '较高' THEN 3
--        WHEN '一般' THEN 2
--        ELSE 1
--    END DESC,
--    定价 DESC

--DROP TABLE #BookPriceEvaluation

--04
CREATE TABLE #PublisherBorrowRate (
    出版社 varchar(100),
    总图书数量 int,
    被借阅数量 int,
    借出率 decimal(5,2)
)

DECLARE @出版社 varchar(100)
DECLARE @总图书数量 int
DECLARE @被借阅数量 int
DECLARE @借出率 decimal(5,2)

DECLARE publisher_cursor CURSOR FOR
SELECT DISTINCT 出版社 FROM book2257

OPEN publisher_cursor
FETCH NEXT FROM publisher_cursor INTO @出版社

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @总图书数量 = COUNT(*) 
    FROM book2257 
    WHERE 出版社 = @出版社

    SELECT @被借阅数量 = COUNT(DISTINCT b.图书编号)
    FROM book2257 b
    JOIN borrow2257 br ON b.图书编号 = br.图书编号
    WHERE b.出版社 = @出版社

    IF @总图书数量 > 0
        SET @借出率 = (@被借阅数量 * 100.0) / @总图书数量
    ELSE
        SET @借出率 = 0

    INSERT INTO #PublisherBorrowRate 
    VALUES (@出版社, @总图书数量, @被借阅数量, @借出率)

    FETCH NEXT FROM publisher_cursor INTO @出版社
END

CLOSE publisher_cursor
DEALLOCATE publisher_cursor

SELECT 
    出版社,
    总图书数量 AS '总图书数',
    被借阅数量 AS '被借阅数',
    CONVERT(varchar, 借出率) + '%' AS '借出率'
FROM #PublisherBorrowRate
ORDER BY 借出率 DESC

DROP TABLE #PublisherBorrowRate