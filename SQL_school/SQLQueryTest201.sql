USE School
----12��
--DECLARE @course_id varchar(20) 
--DECLARE @course_name varchar(50)
--DECLARE @avg_score decimal(5,2)

--DECLARE course_cursor CURSOR FOR
--SELECT c.�γ̺�, c.�γ���
--FROM Course c

--OPEN course_cursor

--FETCH NEXT FROM course_cursor INTO @course_id, @course_name

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SELECT @avg_score = AVG(CAST(���� AS decimal(5,2)))
--    FROM Score
--    WHERE �γ̺� = @course_id
    
--    PRINT  '�γ���: ' + @course_name + ', ƽ����: ' + CAST(ISNULL(@avg_score, 0) AS varchar(10))
   
--   FETCH NEXT FROM course_cursor INTO @course_id, @course_name
--END

--CLOSE course_cursor
--DEALLOCATE course_cursor


----13��
--DECLARE @ѧ�� varchar(20)
--DECLARE @�γ̺� varchar(20)
--DECLARE @���� int
--DECLARE @�ȼ� char(1)

--DECLARE score_cursor CURSOR FOR
--SELECT ѧ��, �γ̺�, ���� FROM Score

--OPEN score_cursor

--CREATE TABLE #Result (
--    ѧ�� varchar(20),
--    �γ̺� varchar(20),
--    �ȼ� char(1)
--)

--FETCH NEXT FROM score_cursor INTO @ѧ��, @�γ̺�, @����
--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SET @�ȼ� = CASE 
--        WHEN @���� >= 90 THEN 'A'
--        WHEN @���� >= 80 THEN 'B'
--        WHEN @���� >= 70 THEN 'C'
--        WHEN @���� >= 60 THEN 'D'
--        ELSE 'E'
--    END
--    PRINT 'ѧ��: ' + @ѧ�� + ', �γ̺�: ' + @�γ̺� + ', �ȼ�: ' + @�ȼ�
--    INSERT INTO #Result VALUES (@ѧ��, @�γ̺�, @�ȼ�)
--    FETCH NEXT FROM score_cursor INTO @ѧ��, @�γ̺�, @����
--END
--CLOSE score_cursor
--DEALLOCATE score_cursor

--SELECT * FROM #Result
--DROP TABLE #Result


----14��
--DECLARE @��� varchar(20)
--DECLARE @�γ̺� varchar(20)
--DECLARE @�γ��� varchar(100)
--DECLARE @ƽ���� decimal(10,2)

--DECLARE class_course_cursor CURSOR FOR
--SELECT DISTINCT s.���, c.�γ̺�, c.�γ���
--FROM Student s
--JOIN Score sc ON s.ѧ�� = sc.ѧ��
--JOIN Course c ON sc.�γ̺� = c.�γ̺�
--ORDER BY s.���, c.�γ̺�

--CREATE TABLE #ClassCourseAvg (
--    ��� varchar(20),
--    �γ̺� varchar(20),
--    �γ��� varchar(100),
--    ƽ���� decimal(10,2)
--)

--OPEN class_course_cursor
--FETCH NEXT FROM class_course_cursor INTO @���, @�γ̺�, @�γ���

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SELECT @ƽ���� = AVG(CAST(sc.���� AS decimal(10,2)))
--    FROM Student s
--    JOIN Score sc ON s.ѧ�� = sc.ѧ��
--    WHERE s.��� = @��� AND sc.�γ̺� = @�γ̺�

--    INSERT INTO #ClassCourseAvg VALUES (@���, @�γ̺�, @�γ���, @ƽ����)

--    FETCH NEXT FROM class_course_cursor INTO @���, @�γ̺�, @�γ���
--END

--CLOSE class_course_cursor
--DEALLOCATE class_course_cursor

--SELECT ���, �γ̺�, �γ���, ƽ����
--FROM #ClassCourseAvg
--ORDER BY ���, �γ̺�

--DROP TABLE #ClassCourseAvg

USE Library2257
----01
--CREATE TABLE #PublisherRatio (
--    ������ varchar(100),
--    ͼ������ int,
--    ͼ����� decimal(5,2),
--    �����ȼ� varchar(10)
--)
--DECLARE @������ varchar(100)
--DECLARE @ͼ������ int
--DECLARE @������ int
--DECLARE @ͼ����� decimal(10,2)
--DECLARE @�����ȼ� varchar(10)

--SELECT @������ = COUNT(*) FROM book2257

--DECLARE publisher_cursor CURSOR FOR
--SELECT ������, COUNT(*) 
--FROM book2257
--GROUP BY ������

--OPEN publisher_cursor
--FETCH NEXT FROM publisher_cursor INTO @������, @ͼ������

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SET @ͼ����� = (@ͼ������ * 100.0) / @������
--    SET @�����ȼ� = CASE 
--        WHEN @ͼ����� > 50 THEN '�ܸ�'
--        WHEN @ͼ����� > 30 THEN '�ϸ�'
--        WHEN @ͼ����� > 10 THEN 'һ��'
--        ELSE '����'
--    END

--    INSERT INTO #PublisherRatio VALUES (@������, @ͼ������, @ͼ�����, @�����ȼ�)

--    FETCH NEXT FROM publisher_cursor INTO @������, @ͼ������
--END

--CLOSE publisher_cursor
--DEALLOCATE publisher_cursor
--SELECT 
--    ������,
--    ͼ������,
--    ͼ�����,
--    �����ȼ�
--FROM #PublisherRatio
--ORDER BY ͼ����� ASC

--DROP TABLE #PublisherRatio

----02
--DECLARE @ϵ�� varchar(50)
--DECLARE @ѧ������ int
--DECLARE @����ѧ���� int
--DECLARE @������� decimal(10,2)
--DECLARE @�����ȼ� varchar(10)

--CREATE TABLE #DeptBorrowStats (
--    ϵ�� varchar(50),
--    ѧ������ int,
--    ����ѧ���� int,
--    ������� decimal(10,2),
--    �����ȼ� varchar(10)
--)

--DECLARE dept_cursor CURSOR FOR
--SELECT DISTINCT d.ϵ�� 
--FROM depart2257 d
--ORDER BY d.ϵ��

--OPEN dept_cursor
--FETCH NEXT FROM dept_cursor INTO @ϵ��

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SELECT @ѧ������ = COUNT(DISTINCT s.ѧ��)
--    FROM student2257 s
--    JOIN depart2257 d ON s.��� = d.���
--    WHERE d.ϵ�� = @ϵ��

--    SELECT @����ѧ���� = COUNT(DISTINCT b.ѧ��)
--    FROM borrow2257 b
--    JOIN student2257 s ON b.ѧ�� = s.ѧ��
--    JOIN depart2257 d ON s.��� = d.���
--    WHERE d.ϵ�� = @ϵ��

--    IF @ѧ������ > 0
--        SET @������� = CAST(@����ѧ���� AS decimal(10,2)) / @ѧ������ * 100
--    ELSE
--        SET @������� = 0

--    SET @�����ȼ� = CASE
--        WHEN @������� > 50 THEN '�ܸ�'
--        WHEN @������� > 30 THEN '�ϸ�'
--        WHEN @������� > 10 THEN 'һ��'
--        ELSE '�ϵ�'
--    END

--    INSERT INTO #DeptBorrowStats 
--    VALUES (@ϵ��, @ѧ������, @����ѧ����, @�������, @�����ȼ�)

--    FETCH NEXT FROM dept_cursor INTO @ϵ��
--END

--CLOSE dept_cursor
--DEALLOCATE dept_cursor

--SELECT ϵ��, ѧ������, ����ѧ����, �������, �����ȼ�
--FROM #DeptBorrowStats
--ORDER BY ������� DESC

--DROP TABLE #DeptBorrowStats

----03
--DECLARE @ͼ���� varchar(100)
--DECLARE @���� decimal(10,2)
--DECLARE @�۸����� varchar(10)

--CREATE TABLE #BookPriceEvaluation (
--    ͼ���� varchar(100),
--    ���� decimal(10,2),
--    �۸����� varchar(10)
--)

--DECLARE book_cursor CURSOR FOR
--SELECT ͼ����, ���� FROM book2257

--OPEN book_cursor
--FETCH NEXT FROM book_cursor INTO @ͼ����, @����

--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SET @�۸����� = CASE 
--        WHEN @���� > 45 THEN '��'
--        WHEN @���� > 30 THEN '�ϸ�'
--        WHEN @���� > 15 THEN 'һ��'
--        ELSE '��'
--    END
--    INSERT INTO #BookPriceEvaluation VALUES (@ͼ����, @����, @�۸�����)

--    FETCH NEXT FROM book_cursor INTO @ͼ����, @����
--END

--CLOSE book_cursor
--DEALLOCATE book_cursor

--SELECT * FROM #BookPriceEvaluation
--ORDER BY 
--    CASE �۸�����
--        WHEN '��' THEN 4
--        WHEN '�ϸ�' THEN 3
--        WHEN 'һ��' THEN 2
--        ELSE 1
--    END DESC,
--    ���� DESC

--DROP TABLE #BookPriceEvaluation

--04
CREATE TABLE #PublisherBorrowRate (
    ������ varchar(100),
    ��ͼ������ int,
    ���������� int,
    ����� decimal(5,2)
)

DECLARE @������ varchar(100)
DECLARE @��ͼ������ int
DECLARE @���������� int
DECLARE @����� decimal(5,2)

DECLARE publisher_cursor CURSOR FOR
SELECT DISTINCT ������ FROM book2257

OPEN publisher_cursor
FETCH NEXT FROM publisher_cursor INTO @������

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @��ͼ������ = COUNT(*) 
    FROM book2257 
    WHERE ������ = @������

    SELECT @���������� = COUNT(DISTINCT b.ͼ����)
    FROM book2257 b
    JOIN borrow2257 br ON b.ͼ���� = br.ͼ����
    WHERE b.������ = @������

    IF @��ͼ������ > 0
        SET @����� = (@���������� * 100.0) / @��ͼ������
    ELSE
        SET @����� = 0

    INSERT INTO #PublisherBorrowRate 
    VALUES (@������, @��ͼ������, @����������, @�����)

    FETCH NEXT FROM publisher_cursor INTO @������
END

CLOSE publisher_cursor
DEALLOCATE publisher_cursor

SELECT 
    ������,
    ��ͼ������ AS '��ͼ����',
    ���������� AS '��������',
    CONVERT(varchar, �����) + '%' AS '�����'
FROM #PublisherBorrowRate
ORDER BY ����� DESC

DROP TABLE #PublisherBorrowRate