TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE;
TRUNCATE TABLE students RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, start_date) VALUES ('Summer', '2022/06/01');
INSERT INTO cohorts (name, start_date) VALUES ('Autumn', '2022/09/01');
INSERT INTO students (name, cohort_id) VALUES ('Phil', '1');
INSERT INTO students (name, cohort_id) VALUES ('Kat', '1');
INSERT INTO students (name, cohort_id) VALUES ('Louisa', '2');
INSERT INTO students (name, cohort_id) VALUES ('Will', '2');