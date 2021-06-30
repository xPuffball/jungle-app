require 'rails_helper'

RSpec.feature "Visitor adds product to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see cart quantity display correct amount" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    first('.product').click_button('Add')
    save_screenshot
    expect(page).to have_text 'My Cart (1)' 
  end

end
