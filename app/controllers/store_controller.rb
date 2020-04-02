class StoreController < ApplicationController
  include CurrentCart
  include SetCounter
  before_action :set_cart

  def index
    set_counter
    @products = Product.order(:title)
  end
end
