require 'json'
require 'pry'

require_relative 'template_parser'
require 'active_support/all'

template_file_path = 'resources/templates/F. Item Recap.xlsx'

#### Parse Template
puts "Parsing templates..."
parser = TemplateParser.new(template_file_path: template_file_path)
parser.generate

#### Generate JSON target schema
File.open("outputs/Target Schema - iHerb2.json", 'w') do |file|
 file << JSON.pretty_generate(meta_data: parser.metadata, workbooks: parser.workbooks, automatic_data: [], fields: parser.fields)
end
