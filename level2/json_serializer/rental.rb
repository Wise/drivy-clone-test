class JsonSerializer::Rental < JsonSerializer::Base
  def as_json
    {
      id: @object.id,
      price: @object.price
    }
  end
end
