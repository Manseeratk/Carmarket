class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :description
      t.string :make
      t.string :model
      t.string :variant

      t.timestamps
    end
  end
end
