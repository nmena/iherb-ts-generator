require 'roo'
require_relative 'field'

class TemplateParser

  TS_NAME = "iHerb"
  MAIN_SHEET_NAME = "Sheet1"
  TS_EXTERNAL_ID = "iHerb"
  FILE_NAME = "F. Item Recap.xlsx"

  attr_accessor :fields

  def initialize(template_file_path:)
    @template = Roo::Excelx.new(template_file_path)
    @fields = []
  end

  def metadata
    [
      {
        external_id: TS_EXTERNAL_ID,
        name: TS_NAME
      }
    ]
  end

  def workbooks
    [
      {
        "File Name" => FILE_NAME,
        "sheets" => [
          {
            "Sheet (Tab) Name" => MAIN_SHEET_NAME,
            "Starting Row" => 4,
            "Applicable Scopes" => []
          }
        ]
      }
    ]
  end

   def generate
    parse_template
    serialize_fields
  end

  private

  def parse_template
    main_sheet = @template.sheets.first
    @field_names = @template.sheet(main_sheet).row(3)
  end

  def serialize_fields
    @field_names.each_with_index do |field, index|
      target_schema_field = Field.new(name: field)
      @fields << target_schema_field.serialize(index)
    end
  end

end

