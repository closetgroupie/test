class ShopController < ApplicationController
  BATCH_SIZE = 200

  def index
    count = Item.count(:id)
    start = count > BATCH_SIZE ? rand(count - BATCH_SIZE) : 0
    @items = Item.offset(start).limit(BATCH_SIZE).to_a.shuffle![0..39]
    @segments = get_segments()
  end

  def show
    if params[:segment].present?
      @segment = params[:segment].to_s.downcase
      segment_slugs = slugs_for_id(@segment)
      category_slug = params[:category].presence
      sizes = params[:sizes].presence || []

      segments = Segment.where(:slug => segment_slugs).pluck(:id)

      @categories = Category.includes(:sizes).where(:segment_id => segments)
      @category = @categories.find { |c| c.slug == category_slug }
      # TODO: There has to be a better way...
      @sizes    = @category.sizes.select { |s| sizes.include?(s.id.to_s) } if @category
      @items = Item.includes(:photos, :size, :category).filter_by(segments, @category, sizes).page params[:page]
      # @items = Item.includes(:photos, :size, :category)
      # if @category.present?
      #   @items = @items.by_segments(segments).by_category(@category)
      # else
      #   @items = @items.by_segments(segments)
      # end
      # @items.page params[:page]
    end
  end

  def shop_by_segment
    @segments = get_segments()
    @segment = @segments.find(params[:id])
    # TODO: Pagination
    @items = @segment.items
    render :index
  end

  def shop_by_segment_category
    # TODO: Offsets/pagination for when we have a lot of items
    @segments = get_segments()
    @segment = @segments.find(params[:segment_id])
    @category = @segment.categories.find(params[:id])
    @items = @category.items
    render :index
  end
  
  private
    def slugs_for_id(slug)
      if slug == "babies"
        ["baby-girls", "baby-boys"]
      else
        slug
      end
    end

    def get_segments
      Segment.includes(:categories)
    end
end
