ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1

  content do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span "Welcome to Active Admin. This is the default dashboard page."
    #     small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #   end
    # end


    # Here is an example of a simple dashboard with columns and panels.

    # Seller stats:
    current_seller_count = Item.pluck(:user_id).uniq.size
    new_items_uploaded   = Item.where(created_at: (Time.now.utc - (Time.now.utc.midnight - 1.week.ago)).midnight..Time.now.utc.end_of_day).size

    new_registrations    = User.where(created_at: (Time.now.utc - (Time.now.utc.midnight - 1.week.ago)).midnight..Time.now.utc.end_of_day).size

    columns do
      column do
        panel "Key Metrics" do
          ul do
            li "# of sellers: #{current_seller_count}"
            li "# of items uploaded: #{new_items_uploaded}"
            li "# of sellers w/ sales"
            li "revenue per seller"
          end

          ul do
            # li "# of monthly (weekly) uniques"
            li "# of monthly (weekly) registered: #{new_registrations}"
            li "# of items bought"
            li "# of items viewed per seller"
          end
        end
        # panel "Recent Items" do
        #   ul do
        #     Item.recent(5).map do |item|
        #       li link_to(item.title, admin_item_path(item))
        #     end
        #   end
        # end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end
