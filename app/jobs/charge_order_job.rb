class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, pay_id_params)
    order.charge!(pay_id_params)
  end
end
