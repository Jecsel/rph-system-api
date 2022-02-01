class CreateOutpatientClinicServices < ActiveRecord::Migration[6.1]
  def change
    create_table :outpatient_clinic_services do |t|
      t.bigint              :outpatient_record_id, foreign_key: true
      t.bigint              :clinic_service_id, foreign_key: true
      t.boolean             :is_true
      t.timestamps
    end
  end
end
