class Point
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :value
  attr_accessor :next_value

  # To change this template use File | Settings | File Templates.

  def initialize
    @value = :off
  end

end