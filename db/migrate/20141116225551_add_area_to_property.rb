class AddAreaToProperty < ActiveRecord::Migration
  def change
    add_reference :properties, :area, index: true
  end
end
