class AddPayIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :pay, foreign_key: true
  end
end
