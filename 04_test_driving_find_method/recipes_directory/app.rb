# file: app.rb

require_relative "lib/database_connection"
require_relative "lib/recipe_repository"

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

# Print out each record from the result set for all:
recipe_repository = RecipeRepository.new
recipe_repository.all.each { |recipe| p "#{recipe.names}: #{recipe.cooking_time} mins - #{recipe.rating} stars in difficulty" }

# Print out a single record from the result set for find:
recipe = recipe_repository.find(3)
puts "#{recipe.names}: #{recipe.cooking_time} mins - #{recipe.rating} stars in difficulty"



