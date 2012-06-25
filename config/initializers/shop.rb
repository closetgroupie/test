SHOPPING_SEGMENTS = %w(women girls boys babies baby-boys baby-girls)

CLOSET_GROUPIE_PERCENTAGE = BigDecimal.new("0.05")
CLOSET_GROUPIE_FLAT_FEE   = BigDecimal.new("1")

class SegmentsRestriction
  # proc { |req| SHOPPING_SEGMENTS.include?(req.params[:segment]) }
  def self.matches?(request)
    SHOPPING_SEGMENTS.include?(request.params[:segment].downcase)
  end
end
