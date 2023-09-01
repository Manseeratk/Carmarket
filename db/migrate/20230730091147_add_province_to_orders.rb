class AddProvinceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :province, :string
    add_column :orders, :tax_rate, :float
    add_column :orders, :total, :float
  end
end
