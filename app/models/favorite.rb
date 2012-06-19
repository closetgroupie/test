class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  attr_accessible :item_id

  class << self
    def contain_item?(item)
      where(item_id: item.id).any?
    end

    def delete_for_item(item)
      where(item_id: item.id).first.destroy
    end
  end
end
