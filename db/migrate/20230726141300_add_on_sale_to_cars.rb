class AddOnSaleToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :on_sale, :boolean
  end
end
