USE School

SELECT student.����, course.�γ���, score.���� 
FROM student, course, score 
WHERE student.ѧ��= score.ѧ�� AND course.�γ̺�= score.�γ̺� 
ORDER BY student.ѧ��, course.�γ̺� 

SELECT course.�γ���,AVG(score.����) AS'ƽ����'
FROM course, score 
WHERE course.�γ̺�= score.�γ̺� AND score.���� IS NOT NULL 
GROUP BY course.�γ��� 
 
SELECT course.�γ���,AVG(score.����) AS 'ƽ����' 
FROM course, score 
WHERE course.�γ̺�= score.�γ̺� AND score.���� IS NOT NULL 
GROUP BY course.�γ��� 
HAVING AVG(score.����)>80 

SELECT student.ѧ��, student.����,AVG(score.����) 
FROM student, score 
WHERE student.ѧ��= score.ѧ�� AND score.���� IS NOT NULL AND student.���='1001' 
GROUP BY student.ѧ��, student.���� 
ORDER BY AVG(score.����) DESC 
 
SELECT a.���,a.����, score.�γ̺�, score.���� 
FROM student a, score 
WHERE a.ѧ��= score.ѧ�� AND score.����= 
(SELECT MAX(score.����) 
FROM student b, score 
WHERE b.ѧ��= score.ѧ�� AND b.���=a.���) 

SELECT Course.�γ���,Teacher.���� FROM(Course JOIN Teacher ON Course.�ον�ʦ���=Teacher.���)

SELECT Teacher.����,Course.�γ��� FROM (Course JOIN Teacher ON Course.�ον�ʦ���=Teacher.���) WHERE Teacher.ְ��='����'

SELECT Teacher.����,COUNT(Course.�γ̺�) AS '�ڿ���Ŀ'FROM Teacher LEFT JOIN Course ON Teacher.���=Course.�ον�ʦ���  GROUP BY Teacher.����