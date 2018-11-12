require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do
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


  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    save_screenshot

    expect(page).to have_css 'article.product', count: 10
  end

end
