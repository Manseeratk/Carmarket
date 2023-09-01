ActiveAdmin.register Order do

  permit_params :customer_name, :shipping_address, :phone_no

  form do |f|
    f.inputs do
      f.input :customer_name
      f.input :shipping_address
      f.input :status, as: :select, collection: ['unpaid', 'paid', 'shipped']
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :customer_name
    column :shipping_address
    column :phone_no
    column :gst_rate
    column :pst_rate
    column :hst_rate

    column :line_items do |order|
      # Assuming that the line_items association is defined on the Order model
      line_item_info = order.line_items.map do |line_item|
        "#{line_item[:car].name} (Qty: #{line_item[:quantity]})"
      end
      line_item_info.join("<br>").html_safe
    end
    column :total
    column :status
    actions
  end
  
end
