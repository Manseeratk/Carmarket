module OrdersHelper
    include CartsHelper

    def grand_total(cart, order)
        cart_total_price(cart)
        gst_amount = cart_total_price(cart) * order.gst_rate
        pst_amount = cart_total_price(cart) * order.pst_rate
        hst_amount = cart_total_price(cart) * order.hst_rate
        cart_total_price(cart) + gst_amount + pst_amount + hst_amount
    end

    def order_item_total(line_item)
        line_item[:quantity]  * line_item[:car].price
    end

    def order_total(order)
        order.line_items.to_a.sum { |item| order_item_total(item) } * current_user.province.tax_rate
    end
end