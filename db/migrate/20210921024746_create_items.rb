class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.text :name
      t.string :image_id
      t.text :caption
      t.integer :customer_id
      t.integer :favorite_id

      t.timestamps
    end
  end
end
