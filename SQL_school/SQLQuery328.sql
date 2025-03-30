USE School

SELECT student.姓名, course.课程名, score.分数 
FROM student, course, score 
WHERE student.学号= score.学号 AND course.课程号= score.课程号 
ORDER BY student.学号, course.课程号 

SELECT course.课程名,AVG(score.分数) AS'平均分'
FROM course, score 
WHERE course.课程号= score.课程号 AND score.分数 IS NOT NULL 
GROUP BY course.课程名 
 
SELECT course.课程名,AVG(score.分数) AS '平均分' 
FROM course, score 
WHERE course.课程号= score.课程号 AND score.分数 IS NOT NULL 
GROUP BY course.课程名 
HAVING AVG(score.分数)>80 

SELECT student.学号, student.姓名,AVG(score.分数) 
FROM student, score 
WHERE student.学号= score.学号 AND score.分数 IS NOT NULL AND student.班号='1001' 
GROUP BY student.学号, student.姓名 
ORDER BY AVG(score.分数) DESC 
 
SELECT a.班号,a.姓名, score.课程号, score.分数 
FROM student a, score 
WHERE a.学号= score.学号 AND score.分数= 
(SELECT MAX(score.分数) 
FROM student b, score 
WHERE b.学号= score.学号 AND b.班号=a.班号) 

SELECT Course.课程名,Teacher.姓名 FROM(Course JOIN Teacher ON Course.任课教师编号=Teacher.编号)

SELECT Teacher.姓名,Course.课程名 FROM (Course JOIN Teacher ON Course.任课教师编号=Teacher.编号) WHERE Teacher.职称='教授'

SELECT Teacher.姓名,COUNT(Course.课程号) AS '授课数目'FROM Teacher LEFT JOIN Course ON Teacher.编号=Course.任课教师编号  GROUP BY Teacher.姓名