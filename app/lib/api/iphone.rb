module Api
  class Iphone < Grape::API
    mount Authentication
  end
end
