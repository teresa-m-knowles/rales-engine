class TotalSerializer
  include FastJsonapi::ObjectSerializer

  attribute :total_revenue
  set_id :id
end
