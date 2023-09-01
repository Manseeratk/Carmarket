class AddProductCategoryToProducts < ActiveRecord::Migration[7.0]
  def change
    rename_table :product_categories, :car_categories
    add_reference :cars, :car_category, null: false, foreign_key: true
  end
end
