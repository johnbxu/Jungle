require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should be valid with valid parameters' do
      @product = Product.new(name: 'some name', price: 123, quantity: 123, category: Category.new)
      expect(@product).to be_valid
    end

    it 'should be invalid without a name' do
      @product = Product.new(price: 123, quantity: 123, category: Category.new)
      expect(@product).to be_invalid
    end

    it 'should be invalid without a price' do
      @product = Product.new(name: 'some name', quantity: 123, category: Category.new)
      expect(@product).to be_invalid
    end

    it 'should be invalid without a quantity' do
      @product = Product.new(name: 'some name', price: 123, category: Category.new)
      expect(@product).to be_invalid
    end

    it 'should be invalid without a category' do
      @product = Product.new(name: 'some name', price: 123, quantity: 123, category: nil)
      expect(@product).to be_invalid
    end


  end




end
