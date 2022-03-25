class AddColumnIsActiveToOutpatientRecord < ActiveRecord::Migration[6.1]
  def change
    add_column :outpatient_records, :is_active, :boolean, :default=>true
  end
end
