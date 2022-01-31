class AddColumnAddressToClinicalOutpatientProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :clinical_outpatient_profiles, :address, :text
  end
end
