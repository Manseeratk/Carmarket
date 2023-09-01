class CreateCartTable < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.timestamps
    end
  end
end
