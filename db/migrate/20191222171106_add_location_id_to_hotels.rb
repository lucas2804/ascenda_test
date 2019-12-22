class AddLocationIdToHotels < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :location_id, :integer
  end
end
