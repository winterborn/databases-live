require_relative "lib/database_connection"
require_relative "lib/cohort_repository"

# Test outputs
DatabaseConnection.connect("student_directory_2")

# artist_repository = ArtistRepository.new
# album_repository = AlbumRepository.new

# Print all cohort names:
cohort_repo = CohortRepository.new
# cohort_repo.all.each { |cohort| p cohort.name }

# Print all student names associated with cohort(2)
cohort = cohort_repo.find_with_students(2)
puts "#{cohort.name} Cohort:\n #{cohort.start_date}:\n * #{cohort.students.first.name},\n * #{cohort.students.last.name}"
