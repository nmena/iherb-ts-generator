# Primarily exists to serialize field data for a Target Schema JSON format.
require 'pry'
class Field
 	
  NUMBER_INDICATORS = ['unit_upc', 'case_upc', 'vendor_item_number_sku', 'case_count']
  COLUMN_LETTERS = ('A'..'Z').to_a
  MAIN_SHEET_NAME = "Sheet1"
  
  attr_accessor :name

  def initialize(name:)
    @name = name.titleize 
  end

  def serialize(index)
    {
      external_id: external_id,
      name: clean_name,
      data_type: data_type,
      html_description: nil,
      field_group_external_id: nil,
      required: false,
      classifier: false,
      "column(s)" => column(index),
      applicable_scope: [],
      requirements: [],
      field_values: []
    }
  end
	
  

  private


  def external_id
    external_id = name_id_format
  end
	

  def is_a_number?
    NUMBER_INDICATORS.include?(external_id)
  end

  def data_type
    if is_a_number?
      "number"
    else
      "string"
    end   
  end

  def name_id_format
    # 1st gsub: it will replace all special characters with underscore.
    # 2nd gsub: re-check the substituted characters if it has two or more occurences of underscore  and replace it with just one.
    # Chomp: remove another excess underscore at the end of the string.
	
    @name.downcase.gsub(/[^\w\d_]/, '_').
                   gsub(/_{2,}/, "_").
                   chomp("_")
  end

  def clean_name
      @name
  end

  def column(index)
    "[F. Item Recap.xlsx]'#{MAIN_SHEET_NAME}'!#{COLUMN_LETTERS[index]}"
  end

end

