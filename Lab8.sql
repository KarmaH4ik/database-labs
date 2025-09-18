CREATE TABLE gradeScale (
	grade_id SERIAL PRIMARY KEY,
	grade VARCHAR(5) NOT NULL,
	student_id INT REFERENCES students(student_id) ON DELETE CASCADE
);

INSERT INTO gradeScale (grade) VALUES ('A'), ('B'), ('C'), ('D'), ('F')


SELECT * FROM gradeScale;
select * from students;

create table student_grades (
	student_id INT references students(student_id) ON DELETE CASCADE, 
	grade_id INT references gradeScale(grade_id) ON DELETE CASCADE,
	PRIMARY KEY (student_id, grade_id)
);

INSERT INTO student_grades (student_id, grade_id) 
VALUES (1,5), (2,2), (3,4)

SELECT 
    c.grade_id,
    c.grade,
    array_agg(sc.student_id) AS student_grades
FROM 
    gradeScale c
LEFT JOIN 
    student_grades sc
ON 
    c.grade_id = sc.grading_id
GROUP BY 
    c.grade_id, c.grade;