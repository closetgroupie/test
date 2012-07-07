require 'fakeout'

desc "Fakeout data"
task :fake => :environment do
  raise RuntimeError, "*** Do not run this in production. ***" if Rails.env.production?
  faker = Fakeout::Builder.new

  # fake users
  faker.users(9)
  # faker.users(1, { :email => 'matt@test.com' }, true)

  # fake products
  # faker.products(12)
  # faker.products(4, { :price => 0 })

  # report
  puts "Faked!\n#{faker.report}"
end
