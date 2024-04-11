json.extract! recipe, :id, :name, :servings, :instructions, :image, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
json.image url_for(recipe.image)
