json.extract! recipe, :id, :name, :description, :expert, :image_ur, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
