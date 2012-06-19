require 'singleton'

class RedisConnection
  include Singleton
  attr_accessor :connection

  def initialize
    @connection = Redis.new(:driver => :hiredis)
  end
end

REDIS = RedisConnection.instance.connection
