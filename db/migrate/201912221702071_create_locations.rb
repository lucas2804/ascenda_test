class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lng
      t.string :address
      t.string :city
      t.string :country
      t.string :postal_code

      t.timestamps
    end
  end
end
