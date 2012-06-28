ActiveAdmin.register User do
  actions :index, :show #, :edit, :delete

  scope :all, default: true
  scope :sellers do |users|
    users.includes(:items).where("items.user_id = users.id")
  end

  index do
    column :id
    column :email
    column :paypal_email
    column :location
  end

  show do
    attributes_table do
      row :id
      row :email
      row :paypal_email
      row :location
    end

    active_admin_comments
  end

  filter :email
end
