class CreateClinicalRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :clinical_records do |t|
      t.references              :patient, index: true, foreign_key: {to_table: :users}
      t.references              :attending_physician, index: true, foreign_key: {to_table: :users}
      t.references              :prepared_by, index: true, foreign_key: {to_table: :users}
      t.string                  :fiscal_year
      t.string                  :hospital_no
      t.references              :building, foreign_key: true
      t.datetime                :admitted_datetime
      t.string                  :transferred_from
      t.text                    :admitting_diagnosis
      t.text                    :final_diagnosis
      t.text                    :management_operations
      t.timestamps
    end
  end
end

