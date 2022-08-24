User_Accounts Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

_In this template, we'll use an example table `students`_

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email_address, username) VALUES ('AnakinSkywalker@gmail.com', 'TheChosenOne');
INSERT INTO user_accounts (email_address, username) VALUES ('HyruleHelper@gmail.com', 'ElfBoyLink');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql

```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)
class UserAccount
end

# Repository class
# (in lib/user_account_repository.rb)
class UserAccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)

class UserAccount

  # Replace the attributes by your own columns.
  attr_accessor :id, :email_address, :username
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

_You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed._

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: user_accounts

# Repository class
# (in lib/user_account_repository.rb)

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts;
    # Returns an array of UserAccount objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts WHERE id = $1;
    # Returns a single UserAccount object.
  end

  # Insert a new user_account record
  # Takes a UserAccount object in argument
  def create(user_account)
    # Executes the SQL query:
    # INSERT INTO user_accounts (email_address, username) VALUES ($1, $2);
    # Does not need to return anything as only creates record
  end

  # Deletes an user_account record
  # Given its id
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM user_accounts WHERE id = $1;
    # Does not need to return anything as only creates record
  end

  # Updates an artist record
  # Takes an Artist object with updated fields
   def update(user_account)
      # Executes SQL query:
      # UPDATE user_accounts SET email_address = $1, username = $2 WHERE id = $3;
      # Returns nothing as only updates record
   end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# completed this as part of pair-programming this afternoon

# 1
# Get all user accounts
repo = UserAccountRepository.new

users = repo.all

users.length # =>  2

users[0].id # =>  1
users[0].email_address # =>  'AnakinSkywalker@gmail.com'
users[0].username # =>  'TheChosenOne'

# 2
# Get a single user account
repo = UserAccountRepository.new

users = repo.find(1)

users.id # =>  1
users.email_address # =>  'AnakinSkywalker@gmail.com'
users.username # =>  'TheChosenOne'

users = repo.find(2)

users.id # =>  2
users.email_address # =>  'HyruleHelper@gmail.com'
users.username # =>  'ElfBoyLink'

# 3
# Create a new user account
# Creation of new user account:
repo = UserAccountRepository.new
user = UserAccount.new

user.email_address # => 'EyesUpGuardian@hotmail.com'
user.username  # => 'Destiny2Destroyer'

repo.create(user) # => nil

# Checking of new user account:
users = repo.all

last_user = users.last
last_user.email_address # => 'EyesUpGuardian@hotmail.com'
last_user.username  # => 'Destiny2Destroyer'

# 4
# Delete a single user account
repo = UserAccountRepository.new
id_to_delete = 1

repo.delete(id_to_delete)

all_users = repo.all
all_users.length # => 1
all_users.first.id # => '2'

# 5
# Update a single user account
repo = UserAccountRepository.new
user = repo.find(1)

user.email_address = 'AnakinSkywalker@gmail.com'
user.username = 'TheChosenOne'

repo.update(user)

updated_artist.email_address.to eq "DarthVader@gmail.com"
updated_artist.username.to eq "MyNewEmpire"
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
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
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
