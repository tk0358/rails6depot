require 'ostruct'
class Pago
  def self.make_payment(order_id:, 
                        payment_method:, 
                        payment_details:)
    case payment_method
    when :check
      Rails.logger.info "Processing check: " +
        payment_details.fetch(:routing).to_s + "/" +
        payment_details.fetch(:account).to_s
    when :credit_card
      Rails.logger.info "Processing credit_card: " +
        payment_details.fetch(:cc_num).to_s + "/" +
        payment_details.fetch(:expiration_month).to_s + "/" +
        payment_details.fetch(:expiration_year).to_s
      cc_digits = payment_details.fetch(:cc_num).to_s.length
      if cc_digits < 14 || cc_digits > 16
        Rails.logger.error "Your number is #{payment_details.fetch(:cc_num)}. The number of digits in your credit card is wrong."
        return OpenStruct.new(succeeded?: false, error: 'The number of digits in your credit card is wrong.')
      end
    when :po
      Rails.logger.info "Processing purchase order: " +
        payment_details.fetch(:po_num).to_s
    else
      raise "Unknown payment_method #{payment_method}"
    end
    sleep 3 unless Rails.env.test?
    Rails.logger.info "Done Processing Payment"
    OpenStruct.new(succeeded?: true)
  end
end