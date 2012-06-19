class RelationshipsController < ApplicationController
  # TODO: Refactor to something nicer
  def index
    @user = params.has_key?(:id) ? User.find(params[:id]) : current_user
    if @user
      @relationship_type = params.fetch(:relationship_type, :followings)
      @closets = get_closets_for_relationship(@user, @relationship_type)
    else
      # TODO: How should this really be handled?
      # raise ActionController::RoutingError.new('Not Found')
      return redirect_to root_url
    end
  end

  def create
    target = User.find(params[:id])
    following = current_user.relationships.first_or_initialize({
      target_id: target.id
    })
    if following.save
      redirect_to :back
    end
  end

  def destroy
    target = User.find(params[:id])
    following = current_user.relationships.find_by_target_id(target)
    following.destroy
    redirect_to :back
  end

  private
    def get_closets_for_relationship(user, relationship_type)
      if relationship_type == :groupies
        Closet.following(user)
      else
        Closet.followed_by(user)
      end
    end
end
