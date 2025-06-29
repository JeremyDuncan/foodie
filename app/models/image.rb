class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, inverse_of: :images
  belongs_to :user

  has_one_attached :file

  before_validation :assign_current_user


  private
    def assign_current_user
      self.user ||= Current.user
    end
end
