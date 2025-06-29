# app/models/restaurant.rb
class Restaurant < ApplicationRecord
  has_many :images,
           as: :imageable,
           dependent: :destroy,
           inverse_of: :imageable

  accepts_nested_attributes_for :images,
                                reject_if: :all_blank,
                                allow_destroy: true
end

