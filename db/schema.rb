# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131023192621) do

  create_table "homestead_addresses", force: true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_agent_statuses", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_agents", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "status_id"
    t.integer  "office_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_agents_listings", force: true do |t|
    t.integer "agent_id"
    t.integer "listing_id"
  end

  create_table "homestead_commercial_properties", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_firms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_land_properties", force: true do |t|
    t.decimal  "lot_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_listing_photos", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name"
    t.string   "comment"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_listing_providers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_listing_statuses", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_listings", force: true do |t|
    t.string   "type"
    t.string   "listing_number"
    t.integer  "status_id"
    t.integer  "sub_property_type_id"
    t.decimal  "list_price"
    t.date     "list_date"
    t.integer  "address_id"
    t.text     "remarks"
    t.integer  "office_id"
    t.integer  "provider_id"
    t.integer  "property_id"
    t.integer  "primary_photo_id"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_office_statuses", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_offices", force: true do |t|
    t.string   "name"
    t.integer  "status_id"
    t.integer  "address_id"
    t.integer  "firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_property_types", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_residential_properties", force: true do |t|
    t.integer  "beds"
    t.decimal  "baths"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_states", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homestead_sub_property_types", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "property_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
