class ApplicationController < ActionController::API
  def format_revenue(amount)
    '%.2f' % (amount.to_f / 100)
  end
end
