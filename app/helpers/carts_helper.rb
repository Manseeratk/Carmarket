module CartsHelper
    def total_price(cart_item)
        cart_item.quantity  * cart_item.car.price
    end

    def cart_total_price(cart)
        cart.cart_items.to_a.sum { |item| total_price(item) }
    end


end
