module Api
  class Iphone
    class Items < Grape::API
      format :json

      helpers do
        include Helpers::Errors
        include Helpers::Authentication
      end

      before { authenticate! }

      get :items do
        present @current_user.items , :with => Entities::ListItem
      end

      get 'items/:id' do
        item = @current_user.items.where( :id => params[ :id ] ).first
        json_error!( 'No item with given `id`!' , 404 ) unless item
        present item , :with => Entities::DetailedItem
      end
    end
  end
end
