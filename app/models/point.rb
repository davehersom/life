class Point
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :value
  attr_accessor :next_value

  validates :value, :inclusion => {:in => %w(on off), :message => 'Value must be :on or :off' }

  def initialize
    @value = :off
  end

end