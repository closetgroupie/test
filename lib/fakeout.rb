require 'ffaker'

module Fakeout
  class Builder

    FAKEABLE = %w(User)

    attr_accessor :report

    def initialize
      self.report = Reporter.new
      clean!
    end

    def users(count = 1, options = {})
      1.upto(count) do
        user = User.new({
          :name                  => Faker::Name.name,
          :email                 => random_unique_email,
          :password              => "test1234",
          :password_confirmation => "test1234"
        })
        user.save
      end

      self.report.increment(:users, count)
    end

    # cleans all faked data away
    def clean!
      FAKEABLE.map(&:constantize).map(&:destroy_all)
    end


    private

    def pick_random(model)
      ids = ActiveRecord::Base.connection.select_all("SELECT id FROM #{model.to_s.tableize}")
      model.find(ids[rand(ids.length)]['id'].to_i) if ids
    end

    def random_unique_email
      Faker::Internet.email.gsub('@', "+#{User.count}@")
    end
  end


  class Reporter < Hash
    def initialize
      super(0)
    end

    def increment(fakeable, number = 1)
      self[fakeable.to_sym] ||= 0
      self[fakeable.to_sym] += number
    end

    def to_s
      report = ""
      each do |fakeable, count|
        report << "#{fakeable.to_s.classify.pluralize} (#{count})\n" if count > 0
      end
      report
    end
  end
end
