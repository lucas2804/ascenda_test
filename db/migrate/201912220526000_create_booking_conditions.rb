class CreateBookingConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_conditions do |t|
      t.integer :hotel_id, index: true
      t.text :condition

      t.timestamps
    end
  end
end
