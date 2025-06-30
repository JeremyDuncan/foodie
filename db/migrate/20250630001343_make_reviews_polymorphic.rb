class MakeReviewsPolymorphic < ActiveRecord::Migration[8.0]
  def change
    remove_column :reviews, :restaurant_id,    :bigint
    add_column    :reviews, :reviewable_type,  :string, null: false
    add_column    :reviews, :reviewable_id,    :bigint, null: false
    add_index     :reviews, [:reviewable_type, :reviewable_id]
  end
end
