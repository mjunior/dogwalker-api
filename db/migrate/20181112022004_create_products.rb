class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.integer :duration
      t.float :first_price
      t.float :aditional_price
      t.timestamps
    end

    add_index :products, :duration, unique: true
  end
end
