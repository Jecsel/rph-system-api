class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.bigint            :user_id, foreign_key: true
      t.string            :surname
      t.string            :first_name
      t.string            :middle_name
      t.date              :dob
      t.integer           :age
      t.text              :birth_place
      t.bigint            :gender_id,foreign_key: true
      t.bigint            :civil_status_id, foreign_key: true
      t.string            :occupation
      t.string            :religion
      t.string            :nationality
      t.string            :cp_no
      t.string            :employed_by
      t.string            :person_to_notify
      t.text              :person_to_notify_address
      t.string            :person_to_notify_no
      t.string            :person_to_notify_cp_relationship       
      t.timestamps
    end
  end
end
