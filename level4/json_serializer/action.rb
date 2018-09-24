class JsonSerializer::Action < JsonSerializer::Base
  def as_json
    {
      who: @object.who,
      type: @object.type,
      amount: @object.amount
    }
  end
end
