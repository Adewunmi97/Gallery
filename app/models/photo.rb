class Photo < ApplicationRecord
  validates :title, presence: true
  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
