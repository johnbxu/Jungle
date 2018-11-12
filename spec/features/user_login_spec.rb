require 'rails_helper'

RSpec.feature "Visitor clicks on log in button", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::HitchhikersGuideToTheGalaxy.character,
        description: Faker::HitchhikersGuideToTheGalaxy.quote,
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 5.99
      )
    end

    User.create!(
      first_name: 'test',
      last_name: 'tester',
      email: 'test@test.test',
      password: 'testtest',
      password_confirmation: 'testtest'
    )

  end


  scenario "They see the cart being updated" do
    # ACT
    visit root_path
    click_on('Login')
    find('#login').click

    fill_in 'email', with: 'test@test.test'
    fill_in 'password', with: 'testtest'
    click_on 'Submit'


    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_content('Logout')
    # within('.navbar') { expect(page).to have_content('Logout') }
  end

end
