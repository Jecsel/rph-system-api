class CreateDispositions < ActiveRecord::Migration[6.1]
  def change
    create_table :dispositions do |t|
      t.string        :name
      t.timestamps
    end
  end
end
