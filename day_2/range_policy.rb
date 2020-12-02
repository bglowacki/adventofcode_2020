class RangePolicy
  def initialize(policy_string:)
    min_max, @required_char = policy_string.split(" ")
    @min, @max = min_max.split("-").map(&:to_i)
  end


  def valid?(password:)
    password.
      split("").
      select { |char| char == required_char }.
      size.
      between?(min, max)
  end

  private

  attr_reader :required_char, :min, :max
end
