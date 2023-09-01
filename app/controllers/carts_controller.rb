class CartsController < ApplicationController
  before_action :set_categories
  before_action :authenticate_customer!, except: [:show, :add_item, :remove_item, :delete_item]

  def show
    if current_user.nil?
      session_cart = session[:cart] || {}
      if session_cart.empty?
        redirect_to root_path, alert: 'Your cart is empty'
      else
        @cart = Cart.new(cart_items: cart_items_from_session(session_cart))
      end
    else
      @cart = current_user.cart || current_user.create_cart
      copy_session_cart_to_user_cart(session[:cart], @cart) if session[:cart].present?
    end
  end

  def add_item
    car = Car.find(params[:car_id])
    if current_user.nil?
      session_cart[car.id.to_s] ||= 0
      session_cart[car.id.to_s] += 1
      session[:cart] = session_cart
      redirect_to cart_path, notice: 'Item was successfully added to your cart.'
    else
      @cart = current_user.cart || current_user.create_cart
      @cart_item = @cart.add_car(car)

      if @cart_item.save
        redirect_to cart_path, notice: 'Item was successfully added to your cart.'
      else
        redirect_to cart_path, alert: 'Error adding item from cart.'
      end
    end
  end

  def remove_item
    car = Car.find(params[:car_id])
    if current_user.nil?
      session_cart[car.id.to_s] ||= 0
      session_cart[car.id.to_s] -= 1
      session_cart.delete(car.id.to_s) if session_cart[car.id.to_s] <= 0
      session[:cart] = session_cart
      redirect_to cart_path, notice: 'Item was successfully removed from your cart.'
    else
      @cart = current_user.cart
      @cart_item = @cart.remove_car(car)

      if @cart_item.save
        redirect_to cart_path, notice: 'Item was successfully removed from your cart.'
      else
        redirect_to cart_path
      end
    end
  end

  def delete_item
    car = Car.find(params[:car_id])
    if current_user.nil?
      session_cart.delete(car.id.to_s)
      session[:cart] = session_cart
      redirect_to cart_path
    else
      @cart = current_user.cart
      cart_item = CartItem.find_by(cart_id: @cart.id, car_id: car.id)
      cart_item.destroy if cart_item
      redirect_to cart_path
    end
  end

  private

  def set_categories
    @categories = CarCategory.all
  end

  def session_cart
    session[:cart] ||= {}
  end

  def cart_items_from_session(session_cart)
    Car.where(id: session_cart.keys).map do |car|
      CartItem.new(car: car, quantity: session_cart[car.id.to_s])
    end
  end

  def copy_session_cart_to_user_cart(session_cart, user_cart)
    session_cart.each do |car_id, quantity|
      car = Car.find(car_id)
      cart_item = user_cart.cart_items.find_or_initialize_by(car: car)
      cart_item.quantity = quantity
      cart_item.save
    end
    session.delete(:cart)
  end
end
