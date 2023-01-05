class Cat
  attr_accessor :name, :purr_factor

  def initialize(name, int)
    @name = name
    @purr_factor = int
  end

  def miaow
    "#{name} is miaowing."
  end
end
