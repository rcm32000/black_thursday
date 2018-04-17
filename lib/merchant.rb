require_relative 'element'

# This class defines merchants
class Merchant
  include Element

  def initialize(attributes)
    @attributes = attributes
  end
end
