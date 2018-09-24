class JsonSerializer::Rental < JsonSerializer::Base
  require_relative "action"

  def as_json
    {
      id: @object.id,
      actions: @object.actions.map { |a| JsonSerializer::Action.new(a).as_json }
    }
  end
end
