class CreateImages < ActiveRecord::Migration[7.2]
  def change
    create_table :images do |t|
      t.string :file
      t.references :user, null: false, foreign_key: true
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
