class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.float :rent
      t.float :investment

      t.timestamps
    end
  end
end
