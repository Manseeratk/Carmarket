class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
  before_action :authenticate_user!
  include OrdersHelper

  # GET /orders or /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1 or /orders/1.json
  def show; end

  # GET /orders/new
  def new
    @order = Order.new
    if current_user.cart.present?
      @cart_items = current_user.cart.cart_items
    else
      redirect_to root_path
    end
  end

  # GET /orders/1/edit
  def edit; end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.line_items = []
    @order.status = "unpaid"
    @order.gst_rate = Province.find_by(name: @order.province).gst_rate
    @order.pst_rate = Province.find_by(name: @order.province).pst_rate
    @order.hst_rate = Province.find_by(name: @order.province).hst_rate
    @order.total = grand_total(current_user.cart, @order)

    current_user.cart.cart_items.each do |cart_item|
      car = Car.find(cart_item[:car_id])
      quantity = cart_item[:quantity].to_i

      @order.line_items << { car:, quantity: }
    end
    @order.user = current_user
    respond_to do |format|
      if @order.save
        current_user.cart.cart_items.destroy_all
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def payment
    customer = Stripe::Customer.create({
                                         email:  params[:stripeEmail],
                                         source: params[:stripeToken]
                                       })

    charge = Stripe::Charge.create({
                                     customer:    customer.id,
                                     amount:      500,
                                     description: "Description of your product",
                                     currency:    "usd"
                                   })
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:customer_name, :shipping_address, :phone_no, :line_items,
                                  :province)
  end
end
