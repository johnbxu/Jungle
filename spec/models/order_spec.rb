require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.create!(
        name: 'test1',
        quantity: 4,
        description: 'first test product',
        price: 122.12,
        category: Category.new

      )
      @product2 = Product.create!(
        name: 'test2',
        quantity: 2,
        description: 'second test product',
        price: 224.54,
        category: Category.new

      )
      @product3 = Product.create!(
        name: 'test3',
        quantity: 7,
        description: 'third test product',
        price: 57657.12,
        category: Category.new

      )
      # Setup at least one product that will NOT be in the order
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: '123@123.123',
        total_cents: 123,
        stripe_charge_id: 1,
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 2,
      )
      @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * 3,
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      @order.line_items.each do |entry|
        entry.product.quantity -= entry[:quantity]
        entry.product.save!
      end
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to equal 2
      expect(@product2.quantity).to equal 0
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      @order = Order.new(
        email: '123@123.123',
        total_cents: 123,
        stripe_charge_id: 1,
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 2,
      )
      @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * 3,
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      @order.line_items.each do |entry|
        entry.product.quantity -= entry[:quantity]
        entry.product.save!
      end
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product3.quantity).to equal 7
    end
  end
end
