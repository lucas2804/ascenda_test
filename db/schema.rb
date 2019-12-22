# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 201912221702070) do

  create_table "amenities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_amenities_on_category"
  end

  create_table "booking_conditions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "hotel_id"
    t.text "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_booking_conditions_on_hotel_id"
  end

  create_table "hotel_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "link"
    t.string "description"
    t.integer "hotel_id"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_hotel_images_on_category"
    t.index ["hotel_id"], name: "index_hotel_images_on_hotel_id"
  end

  create_table "hotels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "destination_id"
    t.string "hotel_id"
    t.string "name"
    t.string "city"
    t.string "country"
    t.string "address"
    t.text "description"
    t.text "detail"
    t.text "info"
    t.float "longitude"
    t.float "latitude"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_hotels_on_destination_id"
    t.index ["hotel_id"], name: "index_hotels_on_hotel_id"
  end

  create_table "hotels_amenities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "hotel_id"
    t.integer "amenity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_hotels_amenities_on_amenity_id"
    t.index ["hotel_id"], name: "index_hotels_amenities_on_hotel_id"
  end

end
