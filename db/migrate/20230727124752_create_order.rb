class CreateOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :shipping_address
      t.string :phone_no
      t.boolean :status
      t.text :line_items
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.timestamps
    end
  end
end
