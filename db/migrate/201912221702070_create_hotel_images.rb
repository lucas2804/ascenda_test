class CreateHotelImages < ActiveRecord::Migration[5.2]
  def change
    create_table :hotel_images do |t|
      t.string :link
      t.string :description
      t.integer :hotel_id, index: true
      t.integer :category, index: true
      t.timestamps
    end
  end
end
