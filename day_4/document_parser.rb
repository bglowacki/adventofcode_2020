require_relative "fields"
require_relative "documents"


class DocumentParser
  attr_reader :raw_documents

  def initialize(raw_documents)
    @raw_documents = raw_documents
  end

  def parse
    extract_documents.map do |raw_document|
      document_fields = build_fields(raw_document)
      Document.from_fields(document_fields)
    end
  end

  private

  def build_fields(raw_document)
    document_fields = raw_document.split(" ").map { |document_fields| document_fields.split(":") }
    document_fields.map do |key, value|
      field_type = find_field_by_key(key)
      field_type.new(name: key, value: value)
    end
  end

  def find_field_by_key(key)
    Document::POSSIBLE_DOCUMENT_FIELDS.find { |type| type.symbol == key } || GenericField
  end

  def extract_documents
    raw_documents.split("\n\n").map { |passport| passport.gsub("\n", " ") }
  end
end
