require "recipe_repository"

RSpec.describe RecipeRepository do
    def reset_recipes_table
        seed_sql = File.read('spec/seeds_recipes.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes' })
        connection.exec(seed_sql)
      end
      
      describe RecipeRepository do
        before(:each) do
          reset_recipes_table
        end
    end

    it "Gets all recipes" do
        repo = RecipeRepository.new
        recipes = repo.all
        expect(recipes.length).to eq 2
        expect(recipes[0].id).to eq "1"
        expect(recipes[0].names).to eq "Pasta"
        expect(recipes[0].cooking_time).to eq "15"
        expect(recipes[0].rating).to eq "2"

        recipes = repo.all
        expect(recipes.length).to eq 2
        expect(recipes[1].id).to eq "2"
        expect(recipes[1].names).to eq "Sunday Roast"
        expect(recipes[1].cooking_time).to eq "120"
        expect(recipes[1].rating).to eq "3"
    end

    it "finds a specific recipe based on id" do
        repo = RecipeRepository.new
        recipes = repo.find(1)
        expect(recipes.names).to eq "Pasta"
        expect(recipes.cooking_time).to eq "15"
        expect(recipes.rating).to eq "2"

        recipes = repo.find(2)
        expect(recipes.names).to eq "Sunday Roast"
        expect(recipes.cooking_time).to eq "120"
        expect(recipes.rating).to eq "3"
    end
end