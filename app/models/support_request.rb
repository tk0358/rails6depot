class SupportRequest < ApplicationRecord
  has_rich_text :response

  def orders
    Order.where(email: email).order('created_at desc')
  end
end
