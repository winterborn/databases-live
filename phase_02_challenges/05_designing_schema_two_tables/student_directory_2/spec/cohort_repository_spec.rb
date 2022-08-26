require "cohort_repository"

RSpec.describe CohortRepository do
  def reset_cohorts_table
    seed_sql = File.read("spec/seeds_sd_2.sql")
    connection =
      PG.connect({ host: "127.0.0.1", dbname: "student_directory_2" })
    connection.exec(seed_sql)
  end

  describe CohortRepository do
    before(:each) { reset_cohorts_table }

    context "#all method" do
      it "returns a cohorts" do
        repo = CohortRepository.new
        cohort = repo.all
        expect(cohort.length).to eq (2)
        expect(cohort.first.id).to eq (1)
        expect(cohort.first.name).to eq ("Summer")
        expect(cohort.first.start_date).to eq ("2022-06-01 00:00:00")
      end
    end

    context "#find method" do
      it "returns Summer as the first cohort" do
        repo = CohortRepository.new
        cohorts = repo.find(1)

        expect(cohorts.name).to eq "Summer"
        expect(cohorts.start_date).to eq "2022-06-01 00:00:00"
      end

      it "returns Autumn as the second cohort" do
        repo = CohortRepository.new
        cohorts = repo.find(2)

        expect(cohorts.name).to eq "Autumn"
        expect(cohorts.start_date).to eq "2022-09-01 00:00:00"
      end
    end

    context "#find_with_students method" do
      it "finds cohorts with associated students" do
        repo = CohortRepository.new

        cohort = repo.find_with_students(1)

        expect(cohort.name).to eq "Summer"
        expect(cohort.start_date).to eq "2022-06-01 00:00:00"
        expect(cohort.students.first.name).to eq "Phil"
        expect(cohort.students.last.name).to eq "Kat"
      end
    end
  end
end
