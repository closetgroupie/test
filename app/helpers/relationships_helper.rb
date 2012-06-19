module RelationshipsHelper
  def linked_relationship_heading_for(user, relationship_type)
    if relationship_type == :groupies
      raw("Who follows #{profile_link(user)}?")
    else
      raw("Who #{profile_link(user)} is following:")
    end
  end

  private
    def profile_link(user)
      link_to user.name, profile_path(user)
    end
end
