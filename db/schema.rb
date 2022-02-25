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

ActiveRecord::Schema.define(version: 2022_02_25_125151) do

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "buildings", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "civil_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clinic_services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clinical_outpatient_profiles", force: :cascade do |t|
    t.bigint "clinical_record_id"
    t.bigint "user_id"
    t.string "surname"
    t.string "first_name"
    t.string "middle_name"
    t.date "dob"
    t.integer "age"
    t.text "birth_place"
    t.bigint "gender_id"
    t.bigint "civil_status_id"
    t.string "occupation"
    t.string "religion"
    t.string "nationality"
    t.string "cp_no"
    t.string "employed_by"
    t.string "person_to_notify"
    t.text "person_to_notify_address"
    t.string "person_to_notify_no"
    t.string "person_to_notify_cp_relationship"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "address"
    t.index ["clinical_record_id"], name: "index_clinical_outpatient_profiles_on_clinical_record_id"
  end

  create_table "clinical_record_departments", force: :cascade do |t|
    t.bigint "clinical_record_id"
    t.bigint "department_id"
    t.boolean "is_selected"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["clinical_record_id"], name: "index_clinical_record_departments_on_clinical_record_id"
    t.index ["department_id"], name: "index_clinical_record_departments_on_department_id"
  end

  create_table "clinical_record_dispositions", force: :cascade do |t|
    t.bigint "clinical_record_id"
    t.bigint "disposition_id"
    t.text "desc"
    t.boolean "is_selected"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["clinical_record_id"], name: "index_clinical_record_dispositions_on_clinical_record_id"
    t.index ["disposition_id"], name: "index_clinical_record_dispositions_on_disposition_id"
  end

  create_table "clinical_record_local_services", force: :cascade do |t|
    t.bigint "clinical_record_id"
    t.bigint "local_service_id"
    t.text "desc"
    t.boolean "is_selected"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["clinical_record_id"], name: "index_clinical_record_local_services_on_clinical_record_id"
    t.index ["local_service_id"], name: "index_clinical_record_local_services_on_local_service_id"
  end

  create_table "clinical_record_results", force: :cascade do |t|
    t.bigint "clinical_record_id"
    t.bigint "result_id"
    t.boolean "is_selected"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["clinical_record_id"], name: "index_clinical_record_results_on_clinical_record_id"
    t.index ["result_id"], name: "index_clinical_record_results_on_result_id"
  end

  create_table "clinical_record_society_classes", force: :cascade do |t|
    t.bigint "clinical_record_id"
    t.bigint "society_class_id"
    t.boolean "is_selected"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["clinical_record_id"], name: "index_clinical_record_society_classes_on_clinical_record_id"
    t.index ["society_class_id"], name: "index_clinical_record_society_classes_on_society_class_id"
  end

  create_table "clinical_records", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "attending_physician_id"
    t.bigint "prepared_by_id"
    t.string "fiscal_year"
    t.string "hospital_no"
    t.bigint "building_id"
    t.datetime "admitted_datetime"
    t.string "transferred_from"
    t.text "admitting_diagnosis"
    t.text "final_diagnosis"
    t.text "management_operations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attending_physician_id"], name: "index_clinical_records_on_attending_physician_id"
    t.index ["building_id"], name: "index_clinical_records_on_building_id"
    t.index ["patient_id"], name: "index_clinical_records_on_patient_id"
    t.index ["prepared_by_id"], name: "index_clinical_records_on_prepared_by_id"
  end

  create_table "clinics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dispositions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "local_services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "outpatient_clinic_services", force: :cascade do |t|
    t.bigint "outpatient_record_id"
    t.bigint "clinic_service_id"
    t.boolean "is_true"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "outpatient_clinics", force: :cascade do |t|
    t.bigint "outpatient_record_id"
    t.bigint "clinic_id"
    t.boolean "is_true"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "outpatient_record_remarks", force: :cascade do |t|
    t.bigint "outpatient_record_id"
    t.bigint "doctor_on_duty_id"
    t.date "record_date"
    t.string "time_of_arrival"
    t.string "time_of_discharge"
    t.text "diagnosis"
    t.string "service_of_treatment"
    t.string "doctor_on_duty"
    t.text "remarks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "outpatient_records", force: :cascade do |t|
    t.bigint "patient_id"
    t.bigint "physician_id"
    t.bigint "clinic_id"
    t.bigint "clinic_service_id"
    t.bigint "clinical_record_id"
    t.string "payees_person_to_notify"
    t.string "referred_by"
    t.string "relations_to_patient"
    t.string "note_to_allergies"
    t.string "is_release"
    t.string "noi"
    t.string "poi"
    t.string "doi"
    t.string "toi"
    t.string "assailant"
    t.string "nearest_kin"
    t.string "patient_brought_victim"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "surname"
    t.string "first_name"
    t.string "middle_name"
    t.date "dob"
    t.integer "age"
    t.text "birth_place"
    t.bigint "gender_id"
    t.bigint "civil_status_id"
    t.string "occupation"
    t.string "religion"
    t.string "nationality"
    t.string "cp_no"
    t.string "employed_by"
    t.string "person_to_notify"
    t.text "person_to_notify_address"
    t.string "person_to_notify_no"
    t.string "person_to_notify_cp_relationship"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "address"
    t.boolean "is_online", default: true
  end

  create_table "results", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "society_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "user_token"
    t.bigint "user_type_id"
    t.bigint "user_role_id"
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "building_id"
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clinical_outpatient_profiles", "clinical_records"
  add_foreign_key "clinical_record_departments", "clinical_records"
  add_foreign_key "clinical_record_departments", "departments"
  add_foreign_key "clinical_record_dispositions", "clinical_records"
  add_foreign_key "clinical_record_dispositions", "dispositions"
  add_foreign_key "clinical_record_local_services", "clinical_records"
  add_foreign_key "clinical_record_local_services", "local_services"
  add_foreign_key "clinical_record_results", "clinical_records"
  add_foreign_key "clinical_record_results", "results"
  add_foreign_key "clinical_record_society_classes", "clinical_records"
  add_foreign_key "clinical_record_society_classes", "society_classes"
  add_foreign_key "clinical_records", "buildings"
  add_foreign_key "clinical_records", "users", column: "attending_physician_id"
  add_foreign_key "clinical_records", "users", column: "patient_id"
  add_foreign_key "clinical_records", "users", column: "prepared_by_id"
  add_foreign_key "users", "user_roles"
  add_foreign_key "users", "user_types"
end
