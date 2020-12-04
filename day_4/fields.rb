class GenericField
  attr_reader :name

  def initialize(name:, value:)
    @name = name
    @value = value
  end

  def self.symbol
    "generic"
  end

  def valid?
    true
  end
end

class BirthYear < GenericField
  def self.symbol
    "byr"
  end

  def valid?
    @value.to_i.between?(1920, 2002)
  end
end

class IssueYear < GenericField
  def self.symbol
    "iyr"
  end

  def valid?
    @value.to_i.between?(2010, 2020)
  end
end

class ExpirationYear < GenericField
  def self.symbol
    "eyr"
  end

  def valid?
    @value.to_i.between?(2020, 2030)
  end
end

class Height < GenericField
  def self.symbol
    "hgt"
  end

  def initialize(name:, value:)
    @name = name
    @unit = value[-2 .. -1]
    @value = value.to_i
  end

  def valid?
    return @value.between?(150, 193) if @unit == "cm"
    @value.between?(59, 76)
  end
end

class HairColor < GenericField
  def self.symbol
    "hcl"
  end

  def valid?
    is_hex?
  end

  def is_hex?
    @value =~ /#[a-fA-F0-9]{6}$/i
  end
end

class EyeColor < GenericField
  def self.symbol
    "ecl"
  end

  def valid?
    available_eye_colors = %w(amb blu brn gry grn hzl oth)
    available_eye_colors.include?(@value)
  end
end

class PassportId < GenericField
  def self.symbol
    "pid"
  end

  def valid?
    exactly_9_digits?
  end

  def exactly_9_digits?
    @value =~ /^\d{9}$/
  end
end
