USE Library2257
----(1
--CREATE NONCLUSTERED INDEX IX_Book2257_BookName ON book2257(ͼ����);
--SELECT * FROM book2257;

----(2
--GO
--CREATE NONCLUSTERED INDEX IX_Borrow ON borrow2257 (ѧ��, ͼ����);
--GO
--SELECT * FROM borrow2257;
--GO

----(3
--GO
--CREATE VIEW View_BorrowInfo AS
--SELECT s.����, b.ͼ����
--FROM student2257 s
--JOIN borrow2257 br ON s.ѧ�� = br.ѧ��
--JOIN book2257 b ON br.ͼ���� = b.ͼ����
--WHERE s.��� = '0502';
--GO
--SELECT * FROM View_BorrowInfo;
--GO

----(4
--GO
--CREATE VIEW View_BorrowCount AS
--SELECT s.ѧ��, s.����, COUNT(br.ͼ����) AS ������Ŀ
--FROM student2257 s
--LEFT JOIN borrow2257 br ON s.ѧ�� = br.ѧ��
--GROUP BY s.ѧ��, s.����;
--GO
--SELECT * FROM View_BorrowCount;
--GO

----(5
--DROP INDEX IX_Book2257_BookName ON book2257;
--DROP INDEX IX_Borrow ON book2257;

--DROP VIEW View_BorrowInfo;
--DROP VIEW View_BorrowCount;


DROP INDEX IX_Book2257_BookName ON book2257;
CREATE NONCLUSTERED INDEX IX_Book2257_BookName ON book2257(ͼ����, ����);

DROP INDEX IX_Borrow ON borrow2257;
CREATE NONCLUSTERED INDEX IX_Borrow ON borrow2257 (ѧ��, ͼ����, ��������);

--GO
--ALTER VIEW View_BorrowInfo AS
--SELECT s.ѧ��, s.����, b.ͼ����, b.����, br.��������
--FROM student2257 s
--JOIN borrow2257 br ON s.ѧ�� = br.ѧ��
--JOIN book2257 b ON br.ͼ���� = b.ͼ����
--WHERE s.��� = '0502';
--GO
--SELECT * FROM View_BorrowInfo;
--GO

--GO
--ALTER VIEW View_BorrowCount AS
--SELECT s.ѧ��, s.����, s.���, COUNT(br.ͼ����) AS ������Ŀ, 
--       MAX(br.��������) AS �����������
--FROM student2257 s
--LEFT JOIN borrow2257 br ON s.ѧ�� = br.ѧ��
--GROUP BY s.ѧ��, s.����, s.���;
--GO
--SELECT * FROM View_BorrowCount;
--GO