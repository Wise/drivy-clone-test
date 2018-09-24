class JsonSerializer::Rental < JsonSerializer::Base
  def as_json
    {
      id: @object.id,
      price: @object.price,
      commission: {
        insurance_fee: @object.insurance_fee,
        assistance_fee: @object.assistance_fee,
        drivy_fee: @object.drivy_fee
      }
    }
  end
end
