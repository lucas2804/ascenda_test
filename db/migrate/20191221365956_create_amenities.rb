class CreateAmenities < ActiveRecord::Migration[5.2]
  def change
    create_table :amenities do |t|
      t.string :name
      t.integer :category, index: true

      t.timestamps
    end
  end
end
