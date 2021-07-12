/*1*/
SELECT
    student.student_name
FROM
    student
INNER JOIN enrolled ON student.student_id = enrolled.student_id
INNER JOIN semester_course ON enrolled.course_code = semester_course.course_code
INNER JOIN professor ON semester_course.prof_id = professor.prof_id
WHERE
    professor.prof_id = 1 AND student.level = 'SR';


/*2
SELECT
    MAX(age)
FROM
    student
INNER JOIN enrolled ON student.student_id = enrolled.student_id
INNER JOIN semester_course ON enrolled.course_code = semester_course.course_code
INNER JOIN professor ON semester_course.prof_id = professor.prof_id
WHERE
    professor.prof_name = 'Michael Miller' OR student.major = 'Histor';
*/
SELECT
  MAX(age)
FROM
  (
  SELECT
      student.age
  FROM
      professor
  JOIN semester_course ON professor.prof_id = semester_course.prof_id
  JOIN enrolled ON enrolled.course_code = semester_course.course_code
  JOIN student ON student.student_id = enrolled.student_id
  WHERE
      professor.prof_name = ' Michael Miller'
  UNION
SELECT
  student.age
FROM
  student
WHERE
  student.major = 'history'
) AS subquery;


/*3*/
SELECT
    student.student_name,
    course.name
FROM
    student
LEFT JOIN enrolled ON student.student_id = enrolled.student_id
LEFT JOIN course ON course.course_code = enrolled.course_code;


/*4
SELECT
    professor.prof_name
FROM
    professor
LEFT JOIN semester_course ON professor.prof_id = semester_course.prof_id
GROUP BY
    professor.prof_id
HAVING
    COUNT(semester_course.course_code) < 5;
*/
SELECT
    professor.prof_name,
    COUNT(enrolled.student_id)
FROM
    professor
LEFT JOIN semester_course ON professor.prof_id = semester_course.prof_id
LEFT JOIN enrolled ON semester_course.course_code = enrolled.course_code AND enrolled.quarter = semester_course.quarter AND enrolled.year = semester_course.year
GROUP BY
    professor.prof_id
HAVING
    COUNT(enrolled.student_id) < 5;


/*5
SELECT
    DISTINCT student.student_name
FROM
    student
INNER JOIN enrolled ON student.student_id = enrolled.student_id
INNER JOIN semester_course ON enrolled.course_code = semester_course.course_code
INNER JOIN professor ON semester_course.prof_id = professor.prof_id
WHERE
    professor.prof_id = 2;


SELECT
     student.student_name
FROM
    student
NATURAL JOIN enrolled
NATURAL JOIN semester_course
WHERE
    semester_course.prof_id = 2
*/

SELECT DISTINCT
    student.student_name,
    semester_course.prof_id
FROM
    student
JOIN enrolled ON student.student_id = enrolled.student_id
JOIN semester_course ON enrolled.course_code = semester_course.course_code AND enrolled.quarter = semester_course.quarter AND enrolled.year = semester_course.year
WHERE
    semester_course.prof_id = 2;


/*6*/
SELECT
    course.name
FROM
    course
LEFT JOIN semester_course ON course.course_code = semester_course.course_code
LEFT JOIN professor ON professor.prof_id = semester_course.prof_id
LEFT JOIN department ON professor.dept_id = department.dept_id
WHERE
    (
        semester_course.course_code IS NULL
    ) OR department.dept_name = 'Computer Science'



/*7*/
SELECT
   student_name,
   prof_name
FROM
   (
       student
   INNER JOIN enrolled USING(student_id)
   )
INNER JOIN(
       professor
   INNER JOIN semester_course USING(prof_id)
   ) USING(course_code)
WHERE
   student_name LIKE 'M%' AND student.age < 20 AND prof_name LIKE 'M%'
GROUP BY
   student_id,
   prof_name
HAVING
   COUNT(course_code) > 2


/*8
SELECT
    professor.prof_id,
    professor.prof_name
FROM
    professor
INNER JOIN semester_course ON professor.prof_id = semester_course.prof_id
INNER JOIN enrolled ON semester_course.course_code = enrolled.course_code
INNER JOIN course ON semester_course.course_code = course.course_code
INNER JOIN department ON professor.dept_id = department.dept_id
WHERE
    department.dept_id = 1 OR 2 OR 3 OR 4
GROUP BY
    professor.prof_id,
    course.course_code
HAVING
    COUNT(course.course_code) < 2;
*/
SELECT
    professor.prof_id,
    professor.prof_name
FROM
    professor
LEFT JOIN semester_course ON professor.prof_id = semester_course.prof_id
WHERE
    professor.dept_id = '1' OR professor.dept_id = '2' OR professor.dept_id = '3' OR professor.dept_id = '4'
GROUP BY
    professor.prof_id
HAVING
    COUNT(semester_course.course_code) < 2;








/*10*/
CREATE TABLE T1 AS SELECT
    semester_course.prof_id,
    semester_course.course_code,
    COUNT(semester_course.prof_id) AS ccountingg
FROM
    semester_course
GROUP BY
    semester_course.course_code,
    semester_course.prof_id;
CREATE TABLE T2 SELECT
    *
FROM
    T1
WHERE
    T1.ccountingg >= '2';
SELECT
    T2.course_code,
    course.name,
    T2.prof_id,
    professor.prof_name
FROM
    T2
JOIN professor ON T2.prof_id = professor.prof_id
JOIN course ON T2.course_code = course.course_code;


/*11*/
SELECT
    department.dept_name
FROM
    department
JOIN professor ON department.dept_id = professor.dept_id
JOIN semester_course ON professor.prof_id = semester_course.prof_id
GROUP BY
    department.dept_name
HAVING
    COUNT(semester_course.course_code) < 3;
