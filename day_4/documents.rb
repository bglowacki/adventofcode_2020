class Document
  PASSPORT_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
  NORTH_POLE_CREDENTIAL_FIELDS = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  POSSIBLE_DOCUMENT_FIELDS = [
    BirthYear,
    IssueYear,
    ExpirationYear,
    Height,
    HairColor,
    EyeColor,
    PassportId,
    GenericField
  ]

  def self.passport?(field_names)
    field_names.sort == PASSPORT_FIELDS.sort
  end

  def self.north_pole_credential?(field_names)
    field_names.sort == NORTH_POLE_CREDENTIAL_FIELDS.sort
  end

  def self.from_fields(document_fields)
    field_names = document_fields.map(&:name)
    return Passport.new(fields: document_fields) if passport?(field_names)
    return NorthPoleCredentials.new(fields: document_fields) if north_pole_credential?(field_names)
    self.new(fields: document_fields)
  end

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
