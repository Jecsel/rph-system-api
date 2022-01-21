class CreateClinicalRecordLocalServices < ActiveRecord::Migration[6.1]
  def change
    create_table :clinical_record_local_services do |t|
      t.references        :clinical_record, foreign_key: true
      t.references        :local_service, foreign_key: true
      t.text              :desc
      t.boolean           :is_selected
      t.timestamps
    end
  end
end
