Create database CourseprocessingSystem;

CREATE TABLE `CourseprocessingSystem`.`department`(

	  `dept_id`      INT NOT NULL,
    `dept_name`	   VARCHAR(100) NOT NULL,

	  PRIMARY KEY (`dept_id`)
  );

	CREATE TABLE `CourseprocessingSystem`.`student`(

    `student_id` 		INT NOT NULL,
    `student_name`  VARCHAR(100) NOT NULL,
    `major` 		  	VARCHAR(100) NOT NULL,
    `level` 	      VARCHAR(100) NOT NULL,
    `age` 	      	INT NOT NULL,

     PRIMARY KEY (`student_id`)
   );


CREATE TABLE `CourseprocessingSystem`.`professor`(

  	`prof_id` 	INT NOT NULL,
    `prof_name`   	VARCHAR(100) NOT NULL,
    `dept_id`       INT NOT NULL,

    PRIMARY KEY (`prof_id`)
  );


  CREATE TABLE `CourseprocessingSystem`.`course`(

    `course_code` 		VARCHAR(100) NOT NULL,
    `name` 		  	    VARCHAR(100) NOT NULL,

     PRIMARY KEY (`course_code`)
   );


   CREATE TABLE `CourseprocessingSystem`.`semester_course`(

     `course_code` 		VARCHAR(100) NOT NULL,
     `quarter` 	    	VARCHAR(100) NOT NULL,
     `year` 	      	INT NOT NULL,
     `prof_id` 	      	INT NOT NULL,

		 PRIMARY KEY (`course_code`,`quarter`,`year`)
    );


    CREATE TABLE `CourseprocessingSystem`.`enrolled`(

      `student_id` 		INT NOT NULL,
      `course_code` 	    VARCHAR(100) NOT NULL,
      `quarter` 	      	VARCHAR(100) NOT NULL,
      `year` 	      	INT NOT NULL,
      `enrolled_at`    date not null,

			PRIMARY KEY (`student_id`,`course_code`,`quarter`,`year`)
     );


ALTER TABLE professor
ADD CONSTRAINT foreign_key1 FOREIGN KEY (dept_id) REFERENCES department(dept_id);



ALTER TABLE semester_course
ADD CONSTRAINT foreign_key3 FOREIGN KEY (prof_id) REFERENCES professor(prof_id);


ALTER TABLE semester_course
ADD CONSTRAINT foreign_key4 FOREIGN KEY (course_code) REFERENCES course(course_code);



ALTER TABLE enrolled
ADD CONSTRAINT foreign_key2 FOREIGN KEY (student_id) REFERENCES student(student_id);



ALTER TABLE enrolled
ADD FOREIGN KEY (course_code,quarter,year) REFERENCES semester_course(course_code,quarter,year);



/*
ALTER TABLE enrolled
ADD CONSTRAINT foreign_key4 FOREIGN KEY (course_code) REFERENCES course(course_code);



ALTER TABLE enrolled
ADD CONSTRAINT foreign_key5 FOREIGN KEY (quarter) REFERENCES semester_course(quarter);


ALTER TABLE enrolled
ADD CONSTRAINT foreign_key6 FOREIGN KEY (year) REFERENCES semester_course(year);
*/
