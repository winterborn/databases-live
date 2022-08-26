require_relative "./cohort"
require_relative "./student"

class CohortRepository
  def all
    sql = "SELECT id, name, start_date FROM cohorts ORDER BY id;"
    result_set = DatabaseConnection.exec_params(sql, [])

    cohorts = []

    result_set.each do |record|
      cohort = Cohort.new
      cohort.id = record["id"].to_i
      cohort.name = record["name"]
      cohort.start_date = record["start_date"]

      cohorts << cohort
    end

    return cohorts
  end

  def find(id)
    sql = "SELECT id, name, start_date FROM cohorts WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    cohort = Cohort.new
    cohort.id = record["id"]
    cohort.name = record["name"]
    cohort.start_date = record["start_date"]

    return cohort
  end

  def find_with_students(cohort_id)
    sql =
      'SELECT
      cohorts.id AS "id",
      cohorts.name AS "name",
      cohorts.start_date AS "start_date",
      students.id AS "student_id",
      students.name AS "student_name"
    FROM
      cohorts
      JOIN students ON students.cohort_id = cohorts.id
    WHERE
      cohorts.id = $1;'
    sql_params = [cohort_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    first_record = result_set[0]

    cohort = record_to_cohort_object(first_record)

    result_set.each do |record|
      cohort.students << record_to_student_object(record)
    end

    return cohort
  end

  private

  def record_to_cohort_object(first_record)
    cohort = Cohort.new
    cohort.id = first_record["id"]
    cohort.name = first_record["name"]
    cohort.start_date = first_record["start_date"]
    cohort.students = []

    return cohort
  end

  def record_to_student_object(record)
    student = Student.new
    student.id = record["student_id"]
    student.name = record["student_name"]

    return student
  end
end
