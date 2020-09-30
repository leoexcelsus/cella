# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_30_201911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "industry_rules", force: :cascade do |t|
    t.bigint "rule_id", null: false
    t.bigint "industry_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["industry_id"], name: "index_industry_rules_on_industry_id"
    t.index ["rule_id"], name: "index_industry_rules_on_rule_id"
  end

  create_table "polygons", force: :cascade do |t|
    t.string "name"
    t.string "source"
    t.geography "geography", limit: {:srid=>4326, :type=>"multi_polygon", :geographic=>true}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rules", force: :cascade do |t|
    t.string "jurisdiction"
    t.string "issuer"
    t.string "category"
    t.string "number"
    t.date "pub_date"
    t.date "ed_date"
    t.text "long_title"
    t.string "hyperlink"
    t.string "source"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_rules_on_user_id"
  end

  create_table "spatial_domains", force: :cascade do |t|
    t.bigint "polygon_id", null: false
    t.bigint "rule_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["polygon_id"], name: "index_spatial_domains_on_polygon_id"
    t.index ["rule_id"], name: "index_spatial_domains_on_rule_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "industry_rules", "industries"
  add_foreign_key "industry_rules", "rules"
  add_foreign_key "rules", "users"
  add_foreign_key "spatial_domains", "polygons"
  add_foreign_key "spatial_domains", "rules"
end
