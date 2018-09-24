class DrivyManager
  attr_accessor :input_filename, :output_filename, :input_parsed_content, :rentals

  def initialize(input_filename:, output_filename:)
    @input_filename = input_filename
    @output_filenane = output_filename
    @rentals = []
  end

  def call
    open_and_parse_input
    build_models
    write_output
  end

  private

  # read and parse input json file
  def open_and_parse_input
    @input_parsed_content = JSON.parse(File.read(@input_filename))
  end

  # build records from parsed content
  def build_models
    cars = build_records(@input_parsed_content, :car)

    @input_parsed_content['rentals'].each do |r|
      record_params = r.dup.reject { |k,v| k == 'car_id' }
      record_params.merge!(car: cars.select { |c| c.id == r['car_id'] }.first)
      @rentals << Rental.new(record_params)
    end
  end

  # write json serialization to output.json
  def write_output
    File.open(@output_filenane,'w') do |f|
      f.write(JSON.pretty_generate(JsonSerializer::Rentals.new(@rentals).as_json) + "\n")
    end
  end

  def build_records(h, model_name)
    h["#{model_name}s"].map { |c|  Object.const_get(model_name.to_s.capitalize).new(c) }
  end
end
