class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.integer :destination_id, index: true
      t.string :hotel_id, index: true
      t.string :name
      t.string :city
      t.string :country
      t.string :address
      t.text :description
      t.text :detail
      t.text :info
      t.float :longitude
      t.float :latitude
      t.string :postal_code
      t.timestamps
    end
  end
end
