class BasePresenter
  def initialize(object, template, options)
    @object = object
    @template = template
    @options = options
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def placed_at(timezone = Closetgroupie::Application.config.default_timezone)
    @object.created_at.in_time_zone(timezone).to_s(:long_ordinal)
  end


  def h
    @template
  end
end
