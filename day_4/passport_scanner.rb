class DocumentField
  attr_reader :name

  def initialize(name:, value:)
    @name = name
    @value = value
  end

  def valid?
    true
  end
end

class BirthYear < DocumentField
  def valid?
    @value.to_i.between?(1920, 2002)
  end
end

class IssueYear < DocumentField
  def valid?
    @value.to_i.between?(2010, 2020)
  end
end

class ExpirationYear < DocumentField
  def valid?
    @value.to_i.between?(2020, 2030)
  end
end

class Height < DocumentField
  def initialize(name:, value:)
    @name = name
    @unit = value[-2 .. -1]
    @value = value.to_i
  end

  def valid?
    return @value.between?(150,193) if @unit == "cm"
    @value.between?(59,76)
  end
end

class HairColor < DocumentField
  def valid?
    is_hex?
  end

  def is_hex?
    @value =~ /#[a-fA-F0-9]{6}$/i
  end
end

class EyeColor < DocumentField
  def valid?
    available_eye_colors = %w(amb blu brn gry grn hzl oth)
    available_eye_colors.include?(@value)
  end
end

class PassportId < DocumentField
  def valid?
    exactly_9_digits?
  end

  def exactly_9_digits?
    @value =~ /^\d{9}$/
  end
end

class Document
  def initialize(fields:)
    @fields = fields
  end

  def valid?
    false
  end
end

class Passport < Document
  def valid?
    @fields.all?(&:valid?)
  end
end

class NorthPoleCredentials < Document
  def valid?
    @fields.all?(&:valid?)
  end
end


class DocumentParser
  PASSPORT_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"].sort
  NORTH_POLE_CREDENTIAL_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].sort

  attr_reader :raw_documents


  def initialize(raw_documents)
    @raw_documents = raw_documents
  end

  def call
    extract_documents.map do |raw_document|
      document_fields = extract_fields(raw_document)
      field_names = document_fields.map(&:name).sort

      if passport_fields?(field_names)
        Passport.new(fields: document_fields)
      elsif north_pole_credentials_fields?(field_names)
        NorthPoleCredentials.new(fields: document_fields)
      else
        Document.new(fields: document_fields)
      end
    end
  end

  private

  def north_pole_credentials_fields?(field_names)
    field_names == NORTH_POLE_CREDENTIAL_FIELDS
  end

  def passport_fields?(field_names)
    field_names == PASSPORT_FIELDS
  end

  def extract_fields(raw_document)
    document_fields = raw_document.split(" ").map { |document_fields| document_fields.split(":") }
    document_fields.map do |key, value|
      field_type =
        case key
          when "byr"
            BirthYear
          when "iyr"
            IssueYear
          when "eyr"
            ExpirationYear
          when "hgt"
            Height
          when "hcl"
            HairColor
          when "ecl"
            EyeColor
          when "pid"
            PassportId
          else
            DocumentField
        end
      field_type.new(name: key, value: value)
    end
  end

  def extract_documents
    raw_documents.split("\n\n").map { |passport| passport.gsub("\n", " ") }
  end
end


class PassportScanner
  def scan(raw_passports)
    documents = DocumentParser.new(raw_passports).call
    valid_documents = reject_invalid(documents)
    valid_passports_count(valid_documents)
  end

  def valid_passports_count(documents)
    documents.count
  end

  def reject_invalid(documents)
    documents.select(&:valid?)
  end
end

# pp PassportScanner.new.scan(File.read("input.txt"))
