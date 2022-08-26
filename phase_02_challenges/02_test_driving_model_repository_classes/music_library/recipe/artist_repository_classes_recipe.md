Artists Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table
   If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: students

Columns:
id | name | cohort_name

2. Create Test SQL seeds
   Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds\_{table_name}.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_name) VALUES ('David', 'April 2022');
INSERT INTO students (name, cohort_name) VALUES ('Anna', 'May 2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your*database_name < seeds*{table_name}.sql
```

3. Define the class names
   Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artist.rb)
class Artist
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end
```

4. Implement the Model class
   Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Student
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cohort_name
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:

# student = Student.new
# student.name = 'Jo'
# student.name
```

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
   Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE

# Table name: artists
# Repository class

# (in lib/artist_repository.rb)
class ArtistRepository

# Selecting all records
# No arguments
   def all
   # Executes the SQL query: # SELECT id, name, genre FROM artists;
   # Returns an array of Artist objects.
   end

# Gets a single record by its ID
# One argument: the id (number)
   def find(id)
   # Executes the SQL query: # SELECT id, name, genre FROM artists WHERE id = $2;
   # Returns a single Artist object.
   end

# Insert a new artist record
# Takes an Artist object in argument
   def create(artist)
      # Executes SQL query:
      # INSERT INTO artists (name, genre) VALUES ($1, $2);
      # Does not need to return anything as only creates record
   end

# Deletes an artist record
# Given its id
   def delete(id)
      # Executes SQL query:
      # DELETE FROM artists WHERE id = $1;
      # Does not need to return anything as only deletes record
   end

# Updates an artist record
# Takes an Artist object with updated fields
   def update(artist)
      # Executes SQL query:
      # UPDATE artists SET name = $1, genre = $2 WHERE id = $3;
      # Returns nothing as only updates record
   end
end

# Selects an artist record along with associated album records
# given artist ID

def find_with_albums(id)
#    SELECT
# 	artists.id AS "id",
# 	artists.name AS "name",
# 	artists.genre AS "genre",
# 	albums.id AS "album_id",
# 	albums.title AS "title",
# 	albums.release_year AS "release_year"
# FROM
# 	artists
# 	JOIN albums ON albums.artist_id = artists.id
# WHERE
# 	artists.id = $1;

# Returns an Artist Object with the array of Album objects
end
```

6. Write Test Examples
   Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all artists
repo = ArtistRepository.new
artists = repo.all
artists.length # => 2

artists.id # => 1
artists.name # => 'Blink-182'
artists.genre # => 'Alternative'

# 2
# Get a single artist
repo = ArtistRepository.new
artists = repo.find(1)

artists.name # => 'Blink-182'
artists.genre # => 'Alternative'

# 3
# Get another single artist
repo = ArtistRepository.new
artists = repo.find(2)

artists.name # => 'Toto'
artists.genre # => 'Pop'

# 4
# Create a new artist
repo = ArtistRepository.new

artist = Artist.new
artist.name # => 'The Cure'
artist.genre # => 'Alternative'

repo.create(artist) # => nil

artists = repo.all

last_artist = artists.last
last_artist.name # => 'The Cure'
last_artist.genre # => 'Alternative'

# 5
# Delete an artist
repo = ArtistRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_artists = repo.all
all_artists.length # => 1
all_artists.first.id # => '2'

# 6
# Updates an artist when given an id
repo = ArtistRepository.new

artist = repo.find(1)

artist.name = 'Something else'
artist.genre = 'New genre'

repo.update(artist)

updated_artist.name.to eq "Something else"
updated_artist.genre.to eq "New genre"

# 7
# Finds artist with associated albums, given id
repo = ArtistRepository.new

artist = repo.find_with_albums(1)

artist.name # => 'Pixies'
artist.genre # => 'Alternative'
artist.albums.length # => '2'
artist.albums.first.title # => 'Bossanova'


```

Encode this example as a test.

7. Reload the SQL seeds before each test run
   Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
seed_sql = File.read('spec/seeds_students.sql')
connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
connection.exec(seed_sql)
end

describe StudentRepository do
before(:each) do
reset_students_table
end

# (your tests will go here).

end 8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

```

```

```

```

```

```

```

```

```

```
