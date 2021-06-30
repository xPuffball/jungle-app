require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "product is saved when all fields are present" do
      @category = Category.create(name: 'Test')
      @product = Product.new(
        name: "Name of Product", 
        price: 40.00, 
        category: @category, 
        quantity: 5
      )
      @product.save
      expect(@product).to be_valid
    end

    it "should fail when name is not valid" do
      @category = Category.create(name: 'Test')
      @product = Product.new(
        name: nil, 
        price: 40.00, 
        category: @category, 
        quantity: 5
      )
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "should fail when price is not valid" do
      @category = Category.create(name: 'Test')
      @product = Product.new(
        name: "Name of Product", 
        price: nil, 
        category: @category, 
        quantity: 5
      )
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end

    it "should fail when quantity is not valid" do
      @category = Category.create(name: 'Test')
      @product = Product.new(
        name: "Name of Product", 
        price: 40.00, 
        category: @category, 
        quantity: nil
      )
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "should fail when category is not valid" do
      @product = Product.new(
        name: "Name of Product", 
        price: 40.00, 
        category: nil, 
        quantity: 5
      )
      @product.save
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end