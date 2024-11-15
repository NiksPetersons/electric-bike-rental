class CreateRentals < ActiveRecord::Migration[7.2]
  def change
    create_table :rentals do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.references :bike, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.boolean :canceled, null: false, default: false

      t.timestamps
    end

    add_index :rentals, :canceled
  end
end
