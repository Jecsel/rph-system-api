class CreateClinicalRecordResults < ActiveRecord::Migration[6.1]
  def change
    create_table :clinical_record_results do |t|
      t.references        :clinical_record, foreign_key: true
      t.references        :result, foreign_key: true
      t.boolean           :is_selected
      t.timestamps
    end
  end
end
