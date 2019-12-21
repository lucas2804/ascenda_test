class CreateHotelsAmenities < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels_amenities do |t|
      t.integer :hotel_id, index: true
      t.integer :amenity_id, index: true

      t.timestamps
    end
  end
end
