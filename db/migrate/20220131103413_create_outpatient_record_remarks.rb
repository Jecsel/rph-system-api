class CreateOutpatientRecordRemarks < ActiveRecord::Migration[6.1]
  def change
    create_table :outpatient_record_remarks do |t|
      t.bigint              :outpatient_record_id, foreign_key: true
      t.bigint              :doctor_on_duty_id, foreign_key: true
      t.date                :record_date
      t.string              :time_of_arrival
      t.string              :time_of_discharge
      t.text                :diagnosis
      t.string              :service_of_treatment
      t.string              :doctor_on_duty
      t.text                :remarks
      t.timestamps
    end
  end
end
