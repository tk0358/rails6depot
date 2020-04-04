class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :pay

  validates :name, :address, :email, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end  
end
