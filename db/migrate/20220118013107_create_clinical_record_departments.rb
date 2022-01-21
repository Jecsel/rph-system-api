class CreateClinicalRecordDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :clinical_record_departments do |t|
      t.references        :clinical_record, foreign_key: true
      t.references        :department, foreign_key: true
      t.boolean           :is_selected
      t.timestamps
    end
  end
end
