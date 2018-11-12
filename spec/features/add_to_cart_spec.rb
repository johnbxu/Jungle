require 'rails_helper'

RSpec.feature "Visitor navigates to a single product's page", type: :feature, js: true do
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


  scenario "They see the product's information" do
    # ACT
    @product = Product.find(1)
    visit root_path
    click_on @product.name

    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_css '.products-show'
  end

end
