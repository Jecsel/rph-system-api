class AddColumnIsOnlineToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :is_online, :boolean, :default => true
  end
end
