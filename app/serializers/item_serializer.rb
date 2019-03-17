class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id, :created_at, :updated_at

  attribute :unit_price do |object|
    '%.2f' % (object.unit_price.to_f / 100).to_s
  end


end
