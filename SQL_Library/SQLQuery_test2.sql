USE Library2257
SELECT COUNT(*) AS'ͼ��Ʒ������Ŀ'FROM (SELECT DISTINCT ͼ���� FROM book2257) AS distinct_book

SELECT ͼ���� ,COUNT(*) AS 'ͼ����Ŀ' FROM book2257  GROUP BY ͼ����

SELECT ��� ,COUNT(*) AS 'ѧ����' FROM student2257 GROUP BY ���

SELECT ϵ��,COUNT(*) AS 'ѧ����' FROM student2257 JOIN depart2257 ON student2257.���=depart2257.��� GROUP BY ϵ��

SELECT student2257.ѧ��,student2257.����,borrow2257.��������,book2257.ͼ���� FROM borrow2257 JOIN student2257 ON borrow2257.ѧ��=student2257.ѧ�� JOIN book2257 ON borrow2257.ͼ����=book2257.ͼ����  

SELECT student2257.ѧ��,student2257.���� FROM borrow2257 JOIN student2257 ON borrow2257.ѧ��=student2257.ѧ��

SELECT ѧ�� ,COUNT(*) AS '������Ŀ' FROM borrow2257 GROUP BY ѧ��

SELECT student2257.����,student2257.ѧ��,COUNT (borrow2257.ͼ����) AS'������Ŀ' FROM student2257 JOIN  borrow2257 ON borrow2257.ѧ��=student2257.ѧ�� 
GROUP BY student2257.ѧ��,student2257.����	HAVING COUNT (borrow2257.ͼ����)>=2 

SELECT student2257.ѧ��,student2257.����,student2257.��� FROM 
(student2257 JOIN borrow2257 ON student2257.ѧ��=borrow2257.ѧ�� JOIN book2257 ON book2257.ͼ����=borrow2257.ͼ����) WHERE book2257.ͼ����='����ϵͳ'

SELECT student2257.���, COUNT(book2257.ͼ����) AS '��������'
FROM (student2257 JOIN borrow2257  ON student2257.ѧ�� = borrow2257.ѧ�� JOIN book2257 ON borrow2257.ͼ����=book2257.ͼ����)
GROUP BY student2257.���;

SELECT LEFT(book2257.ͼ����, 3) AS ͼ�����, AVG(����) AS ƽ���۸�
FROM book2257
GROUP BY LEFT(ͼ����, 3);

SELECT LEFT(ͼ����, 3) AS ͼ�����, AVG(����) AS ƽ���۸�
FROM book2257
GROUP BY LEFT(ͼ����, 3)
HAVING AVG(����) > 30;

SELECT LEFT(ͼ����, 3) AS ͼ�����, 
       AVG(����) AS ƽ���۸�, 
       MAX(����) AS ��߼۸�
FROM book2257
GROUP BY LEFT(ͼ����, 3);SSS

--SELECT book2257.ͼ����, book2257.ͼ����, student2257.ѧ��, student2257.����
--FROM borrow2257
--JOIN student2257 ON borrow2257.ѧ�� = student2257.ѧ��
--JOIN book2257  ON borrow2257.ͼ���� = book2257.ͼ����
--WHERE borrow2257.�������� + INTERVAL '45' DAY < CURRENT_DATE;

SELECT ͼ����, ͼ����, ����
FROM book2257
WHERE ͼ���� LIKE '%����%';

SELECT ͼ����, ����
FROM book2257
WHERE ���� = (SELECT MAX(����) FROM book2257);

-- ��ѯ���н����ˡ�C������ơ�һ���ѧ����ѧ��������
SELECT DISTINCT student2257.ѧ��, student2257.����
FROM student2257
JOIN borrow2257 ON student2257.ѧ�� = borrow2257.ѧ��
JOIN book2257 ON borrow2257.ͼ���� = book2257.ͼ����
WHERE book2257.ͼ���� = 'C �������';

-- ��ѯ���н����ˡ�C������ơ���û�н��ġ�Cϰ���𡱵�ѧ��ѧ�ź�����
SELECT DISTINCT student2257.ѧ��, student2257.����
FROM student2257
JOIN borrow2257  ON student2257.ѧ�� = borrow2257.ѧ��
JOIN book2257  ON borrow2257.ͼ���� = book2257.ͼ����
WHERE book2257.ͼ���� = 'C �������'
AND student2257.ѧ�� NOT IN (
    SELECT DISTINCT student2257.ѧ��
    FROM student2257
    JOIN borrow2257  ON student2257.ѧ�� = borrow2257.ѧ��
    JOIN book2257 ON borrow2257.ͼ���� = book2257.ͼ����
    WHERE book2257.ͼ���� = 'C ϰ����');

SELECT ѧ��, ����
FROM student2257
WHERE ѧ�� NOT IN (SELECT DISTINCT ѧ�� FROM borrow2257);

SELECT d.ϵ��, COUNT(b.ͼ����) AS ͼ������
FROM depart2257 d
JOIN student2257 s ON d.��� = s.���
JOIN borrow2257 b ON s.ѧ�� = b.ѧ��
GROUP BY d.ϵ��;

SELECT ������, COUNT(ͼ����) AS ͼ������
FROM book2257
GROUP BY ������;

SELECT ������, 
       ROUND(COUNT(ͼ����) * 100.0 / (SELECT COUNT(*) FROM book2257), 1) AS ͼ��ռ��
FROM book2257
GROUP BY ������;

SELECT b.������, COUNT(br.ͼ����) AS ����ͼ����Ŀ
FROM book2257 b
JOIN borrow2257 br ON b.ͼ���� = br.ͼ����
GROUP BY b.������;

