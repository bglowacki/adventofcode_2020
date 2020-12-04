require_relative "document_parser"

class PassportScanner
  def scan(raw_passports)
    documents = DocumentParser.new(raw_passports).parse
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

pp PassportScanner.new.scan(File.read("input.txt"))
