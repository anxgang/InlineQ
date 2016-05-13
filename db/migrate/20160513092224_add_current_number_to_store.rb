class AddCurrentNumberToStore < ActiveRecord::Migration
  def change
    add_column :stores, :current_number, :integer, default: 0
  end
end
