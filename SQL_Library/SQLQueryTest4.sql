USE Library2257
----(1
--CREATE NONCLUSTERED INDEX IX_Book2257_BookName ON book2257(图书名);
--SELECT * FROM book2257;

----(2
--GO
--CREATE NONCLUSTERED INDEX IX_Borrow ON borrow2257 (学号, 图书编号);
--GO
--SELECT * FROM borrow2257;
--GO

----(3
--GO
--CREATE VIEW View_BorrowInfo AS
--SELECT s.姓名, b.图书名
--FROM student2257 s
--JOIN borrow2257 br ON s.学号 = br.学号
--JOIN book2257 b ON br.图书编号 = b.图书编号
--WHERE s.班号 = '0502';
--GO
--SELECT * FROM View_BorrowInfo;
--GO

----(4
--GO
--CREATE VIEW View_BorrowCount AS
--SELECT s.学号, s.姓名, COUNT(br.图书编号) AS 借书数目
--FROM student2257 s
--LEFT JOIN borrow2257 br ON s.学号 = br.学号
--GROUP BY s.学号, s.姓名;
--GO
--SELECT * FROM View_BorrowCount;
--GO

----(5
--DROP INDEX IX_Book2257_BookName ON book2257;
--DROP INDEX IX_Borrow ON book2257;

--DROP VIEW View_BorrowInfo;
--DROP VIEW View_BorrowCount;


DROP INDEX IX_Book2257_BookName ON book2257;
CREATE NONCLUSTERED INDEX IX_Book2257_BookName ON book2257(图书名, 作者);

DROP INDEX IX_Borrow ON borrow2257;
CREATE NONCLUSTERED INDEX IX_Borrow ON borrow2257 (学号, 图书编号, 借书日期);

--GO
--ALTER VIEW View_BorrowInfo AS
--SELECT s.学号, s.姓名, b.图书名, b.作者, br.借书日期
--FROM student2257 s
--JOIN borrow2257 br ON s.学号 = br.学号
--JOIN book2257 b ON br.图书编号 = b.图书编号
--WHERE s.班号 = '0502';
--GO
--SELECT * FROM View_BorrowInfo;
--GO

--GO
--ALTER VIEW View_BorrowCount AS
--SELECT s.学号, s.姓名, s.班号, COUNT(br.图书编号) AS 借书数目, 
--       MAX(br.借书日期) AS 最近借书日期
--FROM student2257 s
--LEFT JOIN borrow2257 br ON s.学号 = br.学号
--GROUP BY s.学号, s.姓名, s.班号;
--GO
--SELECT * FROM View_BorrowCount;
--GO