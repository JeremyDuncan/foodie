class Restaurant < ApplicationRecord
  has_many :images,
           as: :imageable,
           inverse_of: :imageable,
           dependent: :destroy

  has_many :restaurant_images,
           -> { where(category: :restaurant) },
           class_name: "Image",
           as: :imageable,
           inverse_of: :imageable,
           dependent: :destroy

  has_many :menu_images,
           -> { where(category: :menu) },
           class_name: "Image",
           as: :imageable,
           inverse_of: :imageable,
           dependent: :destroy

  has_many :reviews,
           as: :reviewable,
           dependent: :destroy
end
