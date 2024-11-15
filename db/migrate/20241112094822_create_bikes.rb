class CreateBikes < ActiveRecord::Migration[7.2]
  def change
    create_table :bikes do |t|
      t.string :name, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :bikes, :active
  end
end
