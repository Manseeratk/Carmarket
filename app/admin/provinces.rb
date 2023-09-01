ActiveAdmin.register Province do
  permit_params :name, :tax_rate, :gst_rate, :pst_rate, :hst_rate
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :tax_rate, :gst_rate, :pst_rate, :hst_rate]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
