class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.string :title
      t.text :description
      t.integer :rate
      t.reference :users
      t.reference :order_items

      t.timestamps
    end
  end
end
