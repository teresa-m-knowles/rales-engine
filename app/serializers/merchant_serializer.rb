class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :created_at, :updated_at

  # attribute :revenue do |object|
  #   object.revenue
  # end
end
