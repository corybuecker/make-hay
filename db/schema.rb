# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_04_09_115714) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "processing_statuses", ["unprocessed", "fetched", "parsed", "sent"]

  create_table "links", force: :cascade do |t|
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "url"], name: "index_links_on_user_id_and_url", unique: true
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.binary "raw"
    t.binary "parsed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.enum "processing_status", default: "unprocessed", null: false, enum_type: "processing_statuses"
    t.bigint "link_id", null: false
    t.index ["link_id"], name: "index_pages_on_link_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "identity", default: -> { "gen_random_uuid()" }, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "links", "users", on_delete: :cascade
  add_foreign_key "pages", "links", on_delete: :cascade
end
