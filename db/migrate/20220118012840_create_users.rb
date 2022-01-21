class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string            :username
      t.string            :password
      t.string            :user_token
      t.references        :user_type, foreign_key: true
      t.references        :user_role, foreign_key: true
      t.boolean           :is_active
      t.timestamps
    end
  end
end
