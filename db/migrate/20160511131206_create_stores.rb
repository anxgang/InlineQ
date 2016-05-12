class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.text :content
      t.string :tel
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
