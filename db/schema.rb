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

ActiveRecord::Schema.define(version: 2020_03_22_133211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.string "patient"
    t.string "subsample_label"
    t.bigint "fish_slice_id", null: false
    t.date "start_date"
    t.integer "genomico_exam_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fish_slice_id"], name: "index_exams_on_fish_slice_id"
  end

  create_table "fish_slices", force: :cascade do |t|
    t.integer "responsible_id"
    t.string "responsible_login"
    t.date "date"
    t.integer "subsample_id"
    t.string "subsample_label"
    t.integer "probe"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "genomico_exam_id"
  end

  create_table "scanned_cells", force: :cascade do |t|
    t.bigint "scanning_image_id", null: false
    t.integer "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["scanning_image_id"], name: "index_scanned_cells_on_scanning_image_id"
  end

  create_table "scanning_images", force: :cascade do |t|
    t.bigint "scanning_id", null: false
    t.integer "total_nucleus_found"
    t.integer "valid_nucleus_found"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "process_status"
    t.datetime "start_processing_at"
    t.datetime "finish_processing_at"
    t.integer "analysis_status"
    t.index ["scanning_id"], name: "index_scanning_images_on_scanning_id"
  end

  create_table "scannings", force: :cascade do |t|
    t.bigint "fish_slice_id", null: false
    t.integer "responsible_id"
    t.string "responsible_login"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "process_status"
    t.index ["fish_slice_id"], name: "index_scannings_on_fish_slice_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "scanned_cells", "scanning_images"
  add_foreign_key "scanning_images", "scannings"
  add_foreign_key "scannings", "fish_slices"
end
