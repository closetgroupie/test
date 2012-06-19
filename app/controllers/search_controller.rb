class SearchController < ApplicationController
  def index
    @query = params[:q]
    if @query.present?
      search = Tire.search ['users', 'items'] do |search|
        search.query do |query|
          query.string @query
        end
      end
      @results = search.results.group_by { |o| o._index }
    else
      @results = {}
    end
  end
end
