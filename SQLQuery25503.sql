USE Library2257

--ALTER TABLE student2257
--ADD CONSTRAINT CK_student2257_�Ա� CHECK (�Ա� IN ('��', 'Ů'));

--ALTER TABLE student2257
--ADD CONSTRAINT DF_student2257_�Ա� DEFAULT '��' FOR �Ա�;

--ALTER TABLE student2257
--ADD CONSTRAINT FK_student2257_��� 
--FOREIGN KEY (���) REFERENCES depart2257(���);

--ALTER TABLE borrow2257
--ADD CONSTRAINT PK_borrow2257 PRIMARY KEY (ѧ��, ͼ����);

---- ɾ��student����Ա���Լ��
--ALTER TABLE student2257
--DROP CONSTRAINT CK_student2257_�Ա�;

---- ɾ��student���Ա��Ĭ��ֵԼ��
--ALTER TABLE student2257
--DROP CONSTRAINT DF_student2257_�Ա�;

---- ɾ��student��İ�����Լ��
--ALTER TABLE student2257
--DROP CONSTRAINT FK_student2257_���;

---- ɾ��borrow�������Լ��
--ALTER TABLE borrow2257
--DROP CONSTRAINT PK_borrow2257;


--BEGIN TRANSACTION;

--SELECT * FROM depart2257;

--INSERT INTO depart2257 (���, ϵ��) VALUES ('601', '�����ϵ');
--INSERT INTO depart2257 (���, ϵ��) VALUES ('602', '��ѧϵ');

--SELECT * FROM depart2257;

--ROLLBACK TRANSACTION;

--SELECT * FROM depart2257;



--BEGIN TRANSACTION;
--SELECT * FROM depart2257;


--INSERT INTO depart2257 (���, ϵ��) VALUES ('701', 'Ӣ��ϵ');
--SAVE TRANSACTION SavePoint1;

--INSERT INTO depart2257 (���, ϵ��) VALUES ('703', '����ϵ');
--INSERT INTO depart2257 (���, ϵ��) VALUES ('704', '��ʷϵ');

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

-- ���Ժ���
SELECT dbo.Sum(10) AS '1��10�ĺ�';  -- Ӧ����55
SELECT dbo.Sum(100) AS '1��100�ĺ�'; -- Ӧ����5050

GO
CREATE FUNCTION dbo.nbook2 (@ϵ�� VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT s.ѧ��, s.����, s.���, b.ͼ����, br.��������
    FROM student2257 s
    JOIN depart2257 d ON s.��� = d.���
    JOIN borrow2257 br ON s.ѧ�� = br.ѧ��
    JOIN book2257 b ON br.ͼ���� = b.ͼ����
    WHERE d.ϵ�� = @ϵ��
);
GO

-- ���Ժ���
SELECT * FROM dbo.nbook2('�����ϵ');
SELECT * FROM dbo.nbook2('���ӹ���ϵ');

GO
CREATE FUNCTION dbo.pbook ()
RETURNS @result TABLE (ϵ�� VARCHAR(50), ƽ���۸� DECIMAL(10,2))
AS
BEGIN
    INSERT INTO @result
    SELECT d.ϵ��, AVG(b.����) AS ƽ���۸�
    FROM depart2257 d
    JOIN student2257 s ON d.��� = s.���
    JOIN borrow2257 br ON s.ѧ�� = br.ѧ��
    JOIN book2257 b ON br.ͼ���� = b.ͼ����
    GROUP BY d.ϵ��;
    
    RETURN;
END;
GO
-- ���Ժ���
SELECT * FROM dbo.pbook();

GO
CREATE PROCEDURE dbo.sp_BookTypeCount
AS
BEGIN
    SELECT ������, COUNT(*) AS ͼ������
    FROM book2257
    GROUP BY ������
    ORDER BY ͼ������ DESC;
END;
GO

-- ���Դ洢����
EXEC dbo.sp_BookTypeCount;

GO
CREATE PROCEDURE dbo.sp_FindStudentByBook2
    @bookName VARCHAR(100)
AS
BEGIN
    SELECT s.ѧ��, s.����, s.���, b.ͼ����
    FROM student2257 s
    JOIN borrow2257 br ON s.ѧ�� = br.ѧ��
    JOIN book2257 b ON br.ͼ���� = b.ͼ����
    WHERE b.ͼ���� LIKE '%' + @bookName + '%';
END;
GO

-- ���Դ洢����
EXEC dbo.sp_FindStudentByBook2 '���ݽṹ';  -- ��ѯ��������"���ݿ�"�Ľ���ѧ��
EXEC dbo.sp_FindStudentByBook2 '����ϵͳ';   -- ��ѯ��������"���"�Ľ���ѧ��