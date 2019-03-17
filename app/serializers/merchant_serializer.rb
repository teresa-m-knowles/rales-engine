class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  # attribute :revenue do |object|
  #   object.revenue
  # end
end
