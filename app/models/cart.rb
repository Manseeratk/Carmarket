class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  def add_car(car)
    current_item = cart_items.find_by(car_id: car.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(car_id: car.id, quantity: 1)
    end
    current_item
  end

  def remove_car(car)
    current_item = cart_items.find_by(car_id: car.id)
    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end
    current_item
  end
end
