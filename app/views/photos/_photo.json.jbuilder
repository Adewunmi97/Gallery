json.extract! photo, :id, :title, :description, :tags, :created_at, :updated_at
json.url photo_url(photo, format: :json)
