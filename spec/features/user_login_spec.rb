require 'rails_helper'

RSpec.feature "Visitor adds product to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.new(
      first_name: "Jesse",
      last_name: "LaPointe",
      email: "test@email.com",
      password: "password1",
      password_confirmation: "password1"
    )
    @user.save
  end

  scenario "They see cart quantity display correct amount" do
    # ACT
    visit login_path

    # DEBUG / VERIFY
    fill_in 'email', with: 'test@email.com'
    fill_in 'password', with: 'password1'
    click_button('Submit')
    save_screenshot
    expect(page).to have_text 'Jesse'
  end

end
