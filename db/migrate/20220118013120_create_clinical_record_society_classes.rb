class CreateClinicalRecordSocietyClasses < ActiveRecord::Migration[6.1]
  def change
    create_table :clinical_record_society_classes do |t|
      t.references        :clinical_record, foreign_key: true
      t.references        :society_class, foreign_key: true
      t.boolean           :is_selected
      t.timestamps
    end
  end
end
