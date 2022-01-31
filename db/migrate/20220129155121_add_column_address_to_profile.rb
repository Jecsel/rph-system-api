class AddColumnAddressToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :address, :text
  end
end
