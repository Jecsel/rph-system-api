class AddColumnIsActiveToClinicalRecord < ActiveRecord::Migration[6.1]
  def change
    add_column :clinical_records, :is_active, :boolean, :default=>true
  end
end
