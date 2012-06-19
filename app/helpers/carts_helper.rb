module CartsHelper
  def items_in_closet(closet)
    @items.select {|i| i.closet_id == closet.id }
  end
end
