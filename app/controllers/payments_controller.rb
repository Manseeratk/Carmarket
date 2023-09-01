
class PaymentsController < ApplicationController
    def create
    @order = Order.find(params[:order_id])
    customer = Stripe::Customer.create({
        :email => params[:stripeEmail],
        :source => params[:stripeToken]
    })
    
    charge = Stripe::Charge.create({
        :customer => customer.id,
        :amount => @order.total.to_i * 100 ,
        :description => 'Description of your product',
        :currency => 'usd'
    })

    if charge.paid?
        @order.update(status: "paid")
        flash[:notice] = "Payment is Successful"
        redirect_to order_path(@order)
    end

    rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to order_path(@order)
    end
end