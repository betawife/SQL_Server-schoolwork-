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
--IF (SELECT COUNT(*)FROM score WHERE ѧ��='108')=0 
--GOTO labell 
--BEGIN 
--PRINT '108ѧ��ѧ����ƽ���ɼ���'
--SELECT @avg=AVG(����)FROM score WHERE ѧ��= '108' AND ���� IS NOT NULL 
--PRINT @avg 
--RETURN 
--END 
--labell: 
--PRINT '108ѧ�ŵ�ѧ���޳ɼ�'

--USE School 
--IF OBJECT_ID('stud','U') IS NULL 
--PRINT ' school���ݿ���û��stud��'
--ELSE 
--SELECT * FROM Student
--GO 

--USE School 
--SELECT student.ѧ��, student.����, score.�γ̺�,
--CASE 
--WHEN ����>=80 THEN 'PASS' 
--WHEN ����<80 THEN 'NO PASS' 
--END AS '�ɼ�'
--FROM student, score 
--WHERE student.ѧ��= score.ѧ�� AND student.���='1003' 
--ORDER BY ѧ��

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
--PRINT '��CATCH��';
--THROW
--PRINT 'OK'
--END CATCH

--USE school
--GO
--DECLARE @fs int
----��������
--DECLARE @n1 int,@n2 int
--SET @n1=0
--SET @n2=0
--DECLARE fs_cursor CURSOR
----�����α�
--FOR SELECT ���� FROM score WHERE ���� IS NOT NULL
--OPEN fs_cursor
----���α�
--FETCH NEXT FROM fs_cursor INTO @fs
----��ȡ��һ������
--WHILE @@FETCH_STATUS = 0
--BEGIN
--IF @fs>=80 SET @n1=@n1+1
--ELSE SET @n2=@n2+1
--FETCH NEXT FROM fs_cursor INTO @fs
----��ȡ��һ������
--END
--CLOSE fs_cursor
----�ر��α�
--DEALLOCATE fs_cursor
----�ͷ��α�
--PRINT '80�������˴Σ�'+CAST(@n1 AS CHAR(3))
--PRINT '�����˴Σ�'+CAST(@n2 AS CHAR(3))
--GO

--USE school
--GO
--SET NOCOUNT ON
---- ��������
--DECLARE @sno int,@sname char(10),@sclass char(10),@savg float
---- �����α�
--DECLARE st_cursor CURSOR
--FOR SELECT student.ѧ��,student.����,student.���,AVG(score.����)
--FROM student,score
--WHERE student.ѧ��=score.ѧ�� AND score.����>0
--GROUP BY student.ѧ��,student.����,student.���
--ORDER BY student.���,student.ѧ��
---- ���α�
--OPEN st_cursor
---- ��ȡ��һ������
--FETCH NEXT FROM st_cursor INTO @sno,@sname,@sclass,@savg
---- ��ӡ�����
--PRINT'ѧ�� ���� ��� ƽ����'
--PRINT'---------------------'
--WHILE @@FETCH_STATUS = 0
--BEGIN
---- ��ӡһ������
--PRINT CAST(@sno AS char(8))+@sname+@sclass +' '+
--CAST(@savg AS char(5))
---- ��ȡ��һ������
--FETCH NEXT FROM st_cursor INTO @sno,@sname,@sclass,@savg
--END
---- �ر��α�
--CLOSE st_cursor
---- �ͷ��α�
--DEALLOCATE st_cursor
--GO

USE school
GO
ALTER TABLE score ADD �ȼ� char(2)
GO
DECLARE st_cursor CURSOR
FOR SELECT ���� FROM score WHERE ���� IS NOT NULL
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
SET �ȼ� = @dj
WHERE CURRENT OF st_cursor
FETCH NEXT FROM st_cursor INTO @fs
END
CLOSE st_cursor
DEALLOCATE st_cursor
GO
SELECT * FROM score ORDER BY ѧ��
ALTER TABLE score DROP COLUMN �ȼ�
