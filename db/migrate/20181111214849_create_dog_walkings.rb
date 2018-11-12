class CreateDogWalkings < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walkings, id: :uuid do |t|
      t.integer :status, default: 0
      t.datetime :schedule_date
      t.float :price
      t.float :duration
      t.decimal :latitude, { precision: 10, scale: 6 }
      t.decimal :longitude, { precision: 10, scale: 6 }
      t.integer :pets
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
