require 'rails_helper'

RSpec.feature "Visitor clicks on an Add button", type: :feature, js: true do
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

  end


  scenario "They see the cart being updated" do
    # ACT
    @product = Product.find(1)
    visit root_path
    click_on('Add', match: :first)

    # DEBUG / VERIFY
    save_screenshot

    within('.navbar') { expect(page).to have_content('(1)') }
  end

end
