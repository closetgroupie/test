module Api
  class Iphone
    class Items < Grape::API
      format :json

      helpers do
        include Helpers::Errors
        include Helpers::Authentication

        def fetch_item!
          @item = @current_user.items.where( :id => params[ :id ] ).first
          json_error!( 'No item with given `id`!' , 404 ) unless @item
        end
      end

      before do
        authenticate!
        fetch_item! if params[:id].present?
      end

      get :items do
        present @current_user.items , :with => Entities::ListItem
      end

      get 'items/:id' do
        present @item , :with => Entities::DetailedItem
      end

      put 'items/:id' do
        @item.safe_update(params)
        @item.save if @item.changed?
        json_error!( @item.errors.messages , 422 ) if @item.errors.any?
        present @item , :with => Entities::DetailedItem
      end

      delete 'items/:id' do
        if @item.destroy
          status(204)
        else
          json_error!( "Unable to delete item" , 422 )
        end
      end
    end
  end
end
