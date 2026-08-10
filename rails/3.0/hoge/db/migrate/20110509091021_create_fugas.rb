class CreateFugas < ActiveRecord::Migration
  def self.up
    create_table :fugas do |t|
      t.string :fuga_name
      t.integer :fuga_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fugas
  end
end
