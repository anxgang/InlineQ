class AddNumbersCountToStore < ActiveRecord::Migration
  def change
    add_column :stores, :numbers_count, :integer, default: 0

    Store.pluck(:id).each do |i|
      Store.reset_counters(i, :numbers)
    end

  end
end
