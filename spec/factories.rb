require 'digest/md5'

# This class helps automate the tedium of creating test items/users/etc
# to use it, call FactoryGirl.build/create :item/:photo, etc. It relies on
# spec/images/bush*.jpg and on a valid Paypal Developer account with associated
# test_addresses
FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "TestUser #{n}" }
    sequence(:email) {|n| "#{Digest::MD5.hexdigest(SecureRandom.uuid + n.to_s)}@tspike.com"}
    # Replace this with your Paypal Sandbox e-mails
    paypal_email do
      test_addresses = ['cg3_1340825492_per@tspike.com',
                        'tres_1340733278_per@tspike.com',
                        'tres_1340733201_per@tspike.com',
                        'cg4_1340983790_per@tspike.com',
                        'cg5_1340983874_per@tspike.com']
                       
      test_addresses[rand(0...test_addresses.size)]
    end
    password "12345678"
  end

  factory :photo do
    image { File.open(File.join(Rails.root, 'spec', 'images', "bush#{rand(1...4)}.jpg")) }
  end

  factory :closet do
    user
    sequence(:name) {|n| "Closet #{n}"}
  end

  factory :item do
    segment_id 5
    category_id 68
    condition 5
    sequence(:title) {|n| "TestItem #{n}"}
    price 4
    shipping_cost 2
    photos  {|photos| [FactoryGirl.build(:photo)] }

    user
    closet
  end

end
