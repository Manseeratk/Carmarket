class CarsController < ApplicationController
    def index
        @car_categories = CarCategory.all
        @selected_category = params[:category_id]
        @keyword = params[:keyword]
        @on_sale = params[:on_sale]
        @new = params[:new]
        @recently_updated = params[:recently_updated]
    
        @cars = Car.includes(:car_category).all
    
        # Filter by category
        @cars = @cars.where(car_category_id: @selected_category) if @selected_category.present?
    
        # Filter by keyword
        if @keyword.present?
            @cars = @cars.where('LOWER(name) LIKE ? OR LOWER(description) LIKE ?', "%#{@keyword.downcase}%", "%#{@keyword.downcase}%")
        end
    
        # Filter by on sale
        @cars = @cars.where(on_sale: true) if @on_sale == '1'
    
        # Filter by new (added within the past 3 days)
        @cars = @cars.where('created_at >= ?', 3.days.ago) if @new == '1'
    
        # Filter by recently updated (updated within the past 3 days)
        @cars = @cars.where('updated_at >= ?', 3.days.ago) if @recently_updated == '1'
    
        @cars = @cars.page(params[:page]).per(10) # Display 10 cars per page
    end
    
    def show
    @car = Car.find(params[:id])
    end

    def by_category
        @car_category = CarCategory.find(params[:id])
        @cars = @car_category.cars.page(params[:page]).per(10)
    end
end
