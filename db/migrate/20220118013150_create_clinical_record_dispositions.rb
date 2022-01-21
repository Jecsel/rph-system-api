class CreateClinicalRecordDispositions < ActiveRecord::Migration[6.1]
  def change
    create_table :clinical_record_dispositions do |t|
      t.references        :clinical_record, foreign_key: true
      t.references        :disposition, foreign_key: true
      t.text              :desc
      t.boolean           :is_selected
      t.timestamps
    end
  end
end
