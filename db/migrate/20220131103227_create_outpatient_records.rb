class CreateOutpatientRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :outpatient_records do |t|
      t.bigint            :patient_id, foreign_key: true
      t.bigint            :physician_id, foreign_key: true
      t.bigint            :clinic_id, foreign_key: true
      t.bigint            :clinic_service_id, foreign_key: true
      t.bigint            :clinical_record_id, foreign_key: true
      t.string            :payees_person_to_notify
      t.string            :referred_by
      t.string            :relations_to_patient
      t.string            :note_to_allergies
      t.string            :is_release
      t.string            :noi
      t.string            :poi
      t.string            :doi
      t.string            :toi
      t.string            :assailant
      t.string            :nearest_kin
      t.string            :patient_brought_victim
      t.string            :address

      t.timestamps
    end
  end
end
