ActiveAdmin.register Car do


  permit_params :name, :description, :make, :model, :variant, :car_category_id, :on_sale, :image

  

  menu label: "Cars"

  index do
      selectable_column
      id_column
      column :name
      column :description
      column :make
      column :model
      column :variant
      column :on_sale
      column :image do |car|
        if car.image.attached?
          image_tag url_for(car.image), width: 100
        else
          "No image"
        end
      end
      column 'Car Category' do |car|
        car.car_category.name
      end
      actions
  end

  form do |f|
    f.inputs "Car Details" do
      f.input :name
      f.input :description
      f.input :make
      f.input :model
      f.input :variant
      f.input :on_sale, as: :boolean
      f.input :image, as: :file
      f.input :car_category_id, as: :select, collection: CarCategory.all.map{|cc| [cc.name, cc.id]}
    end
    f.actions
  end

  filter :name
  filter :make
  filter :model

  controller { actions :all }

end