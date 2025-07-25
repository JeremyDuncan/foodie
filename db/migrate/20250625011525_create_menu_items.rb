class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
