module Api
  class Iphone < Grape::API
    mount Authentication
    mount Items
  end
end
