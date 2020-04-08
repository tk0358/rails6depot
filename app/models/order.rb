require 'pago'

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :pay
  validates :name, :address, :email, presence: true
  validates :pay_id, inclusion: { in: [1, 2, 3], message: "%{value} is invalid"}
  validate :ship_date_must_be_after_created_at

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  def charge!(pay_id_params)
    payment_details = {}
    payment_method = nil

    case pay_id
    when 1
      payment_method = :check
      payment_details[:routing] = pay_id_params[:routing_number]
      payment_details[:account] = pay_id_params[:account_number]
    when 2
      payment_method = :credit_card
      month,year = pay_id_params[:expiration_date].split('/')
      payment_details[:cc_num] = pay_id_params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when 3
      payment_method = :po
      payment_details[:po_num] = pay_id_params[:po_number]
    end

    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )

    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise payment_result.error
    end
  end

  def ship_date_must_be_after_created_at
    if ship_date.present? && ship_date < created_at
      errors.add(:ship_date, "ship date must be after created_at")
    end
  end
end
