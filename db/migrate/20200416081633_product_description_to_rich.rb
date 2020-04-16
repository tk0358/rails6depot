class ProductDescriptionToRich < ActiveRecord::Migration[6.0]
  def up
    Product.all.each do |product|
      product.rich_description = product.description
      product.description = nil
      product.save
    end
  end

  def down
    Product.all.each do |product|
      product.description = product.rich_description.to_plain_text
      product.save
    end
  end
end
