class AddExistingProductsToLocale < ActiveRecord::Migration[6.0]
  def up
    Product.all.each do |product|
      product.locale = "en"
      product.save
    end
  end

  def down
    Product.all.each do |product|
      product.locale = nil
      product.save
    end
  end
end
