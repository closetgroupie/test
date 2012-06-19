require 'active_support'
require 'active_support/inflector/transliterate'

["Women", "Girls", "Boys", "Baby Girls", "Baby Boys"].each do |segment|
  Segment.where(name: segment).first_or_create(slug: segment.parameterize)
end

women = Segment.find_by_name("Women")
# Categories for Women
['Maternity', 'Jewelry', 'Accessories', 'Jeans', 'Handbags', 'Outfits', 'Skirts', 'Outerwear & Jackets', 'Other', 'Pants', 'Shoes', 'Shirts & Tops', 'Dresses & Rompers', 'Shorts', 'Sweaters'].each do |category|
  women.categories.where(name: category).first_or_create(slug: category.parameterize)
  # Category.where(name: category, segment_id: women.id).first_or_create(slug: category.parameterize)
end

# Brands for Women
['DKNY', 'L.A.M.B.', 'Anna Sui', 'Bally', 'Bebe', 'Burberry', 'Anthropologie', 'Zara', 'Ann Taylor Loft', 'Banana Republic ', 'Alice + Olivia', 'BCBG Max Azria', 'Ann Taylor', 'Juicy Couture  ', 'Free People', 'Armani', 'Tibi', 'Marc Jacobs', 'Gap', 'J Brand', 'H&M', 'Diane Von Furstenberg', 'Ralph Lauren', 'Catherine Malandrino'].each do |brand|
  women.brands.where(name: brand).first_or_create(slug: brand.parameterize)
end

