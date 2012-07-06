ActiveAdmin.register Item do
  CONDITIONS = ::Item::CONDITIONS.invert
  actions :index, :show, :edit, :destroy

  filter :title
  filter :brand
  filter :segment
  filter :category

  scope :all
  scope :unsold do |items|
    items.where(sold: false)
  end
  scope :sold do |items|
    items.where(sold: true)
  end

  index do
    column :id
    column "Seller", :user
    column :title
    column :brand
    column :brand_suggestion
    column :condition do |item|
      CONDITIONS[item.condition]
    end
    column :size
    column :sold

    default_actions
  end

  sidebar "Photos", :only => :show do
      table_for item.photos do |p|
        p.column("Photo") { |photo| image_tag photo.image_url(:thumbnail) }
        p.column() do |photo|
            link_to("Edit", edit_admin_photo_path(photo)) +
            " " +
            link_to("Delete", admin_photo_path(photo), method: :delete, confirm: "Are you sure you want to delete this photo?")
        end
      end
  end

  sidebar "More uploaded by this user", :only => :show do
    table_for Item.where(:user_id => item.user_id) do |i|
      i.column("Item") { |item| link_to item.title, admin_item_path(item) }
    end
  end
end
