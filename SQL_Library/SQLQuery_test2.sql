USE Library2257
SELECT COUNT(*) AS'图书品种总数目'FROM (SELECT DISTINCT 图书名 FROM book2257) AS distinct_book

SELECT 图书名 ,COUNT(*) AS '图书数目' FROM book2257  GROUP BY 图书名

SELECT 班号 ,COUNT(*) AS '学生数' FROM student2257 GROUP BY 班号

SELECT 系名,COUNT(*) AS '学生数' FROM student2257 JOIN depart2257 ON student2257.班号=depart2257.班号 GROUP BY 系名

SELECT student2257.学号,student2257.姓名,borrow2257.借书日期,book2257.图书名 FROM borrow2257 JOIN student2257 ON borrow2257.学号=student2257.学号 JOIN book2257 ON borrow2257.图书编号=book2257.图书编号  

SELECT student2257.学号,student2257.姓名 FROM borrow2257 JOIN student2257 ON borrow2257.学号=student2257.学号

SELECT 学号 ,COUNT(*) AS '借书数目' FROM borrow2257 GROUP BY 学号

SELECT student2257.姓名,student2257.学号,COUNT (borrow2257.图书编号) AS'借书数目' FROM student2257 JOIN  borrow2257 ON borrow2257.学号=student2257.学号 
GROUP BY student2257.学号,student2257.姓名	HAVING COUNT (borrow2257.图书编号)>=2 

SELECT student2257.学号,student2257.姓名,student2257.班号 FROM 
(student2257 JOIN borrow2257 ON student2257.学号=borrow2257.学号 JOIN book2257 ON book2257.图书编号=borrow2257.图书编号) WHERE book2257.图书名='操作系统'

SELECT student2257.班号, COUNT(book2257.图书编号) AS '借书总数'
FROM (student2257 JOIN borrow2257  ON student2257.学号 = borrow2257.学号 JOIN book2257 ON borrow2257.图书编号=book2257.图书编号)
GROUP BY student2257.班号;

SELECT LEFT(book2257.图书编号, 3) AS 图书类别, AVG(定价) AS 平均价格
FROM book2257
GROUP BY LEFT(图书编号, 3);

SELECT LEFT(图书编号, 3) AS 图书类别, AVG(定价) AS 平均价格
FROM book2257
GROUP BY LEFT(图书编号, 3)
HAVING AVG(定价) > 30;

SELECT LEFT(图书编号, 3) AS 图书类别, 
       AVG(定价) AS 平均价格, 
       MAX(定价) AS 最高价格
FROM book2257
GROUP BY LEFT(图书编号, 3);SSS

--SELECT book2257.图书编号, book2257.图书名, student2257.学号, student2257.姓名
--FROM borrow2257
--JOIN student2257 ON borrow2257.学号 = student2257.学号
--JOIN book2257  ON borrow2257.图书编号 = book2257.图书编号
--WHERE borrow2257.借书日期 + INTERVAL '45' DAY < CURRENT_DATE;

SELECT 图书编号, 图书名, 作者
FROM book2257
WHERE 图书名 LIKE '%工程%';

SELECT 图书名, 作者
FROM book2257
WHERE 定价 = (SELECT MAX(定价) FROM book2257);

-- 查询所有借阅了“C程序设计”一书的学生的学号与姓名
SELECT DISTINCT student2257.学号, student2257.姓名
FROM student2257
JOIN borrow2257 ON student2257.学号 = borrow2257.学号
JOIN book2257 ON borrow2257.图书编号 = book2257.图书编号
WHERE book2257.图书名 = 'C 程序设计';

-- 查询所有借阅了“C程序设计”但没有借阅“C习题解答”的学生学号和姓名
SELECT DISTINCT student2257.学号, student2257.姓名
FROM student2257
JOIN borrow2257  ON student2257.学号 = borrow2257.学号
JOIN book2257  ON borrow2257.图书编号 = book2257.图书编号
WHERE book2257.图书名 = 'C 程序设计'
AND student2257.学号 NOT IN (
    SELECT DISTINCT student2257.学号
    FROM student2257
    JOIN borrow2257  ON student2257.学号 = borrow2257.学号
    JOIN book2257 ON borrow2257.图书编号 = book2257.图书编号
    WHERE book2257.图书名 = 'C 习题解答');

SELECT 学号, 姓名
FROM student2257
WHERE 学号 NOT IN (SELECT DISTINCT 学号 FROM borrow2257);

SELECT d.系名, COUNT(b.图书编号) AS 图书总数
FROM depart2257 d
JOIN student2257 s ON d.班号 = s.班号
JOIN borrow2257 b ON s.学号 = b.学号
GROUP BY d.系名;

SELECT 出版社, COUNT(图书编号) AS 图书总数
FROM book2257
GROUP BY 出版社;

SELECT 出版社, 
       ROUND(COUNT(图书编号) * 100.0 / (SELECT COUNT(*) FROM book2257), 1) AS 图书占比
FROM book2257
GROUP BY 出版社;

SELECT b.出版社, COUNT(br.图书编号) AS 被借图书数目
FROM book2257 b
JOIN borrow2257 br ON b.图书编号 = br.图书编号
GROUP BY b.出版社;

