class CreateBikes < ActiveRecord::Migration[7.2]
  def change
    create_table :bikes do |t|
      t.string :name, null: false
      t.boolean :available, null: false, default: true

      t.timestamps
    end
  end
end
