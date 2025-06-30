class MenuItem < ApplicationRecord
  belongs_to :restaurant

  has_many :images, as: :imageable, inverse_of: :imageable, dependent: :destroy
  has_many :food_images,  -> { where(category: :food) },
           class_name: "Image", as: :imageable

  has_many :reviews, as: :reviewable, dependent: :destroy

  has_many :hearts, dependent: :destroy
  has_many :hearted_users, through: :hearts, source: :user
end
