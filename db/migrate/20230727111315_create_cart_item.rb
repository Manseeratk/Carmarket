class CreateCartItem < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity
      t.references :cart, null: false, foreign_key: true, type: :bigint
      t.references :car, null: false, foreign_key: true, type: :bigint
      t.timestamps
    end
  end
end
