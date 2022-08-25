# (in lib/recipe_repository.rb)
require_relative "./recipes"

class RecipeRepository
  def all
    sql = "SELECT id, names, cooking_time, rating FROM recipes;"
     result_set = DatabaseConnection.exec_params(sql, [])

 recipes = []

 result_set.each do |food|
   recipe = Recipe.new
   recipe.id = food["id"]
   recipe.names = food["names"]
   recipe.cooking_time = food["cooking_time"]
   recipe.rating = food["rating"]

   recipes << recipe
  end

    # puts recipes.length
    return recipes
  end

  def find(id)
    sql = 'SELECT id, names, cooking_time, rating FROM recipes WHERE id = $1;'
        sql_params = [id]
                
        result_set = DatabaseConnection.exec_params(sql, sql_params)
        record = result_set[0]
                
        recipe = Recipe.new
        recipe.id = record['id']
        recipe.names = record['names']
        recipe.cooking_time = record['cooking_time']
        recipe.rating = record['rating']
                
        return recipe
  end
end