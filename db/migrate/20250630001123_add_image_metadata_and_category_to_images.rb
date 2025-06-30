class AddImageMetadataAndCategoryToImages < ActiveRecord::Migration[8.0]
  def change
    add_column :images, :title,       :string
    add_column :images, :description, :text
    add_column :images, :category,    :integer, default: 0, null: false
    add_index  :images, :category
  end
end
