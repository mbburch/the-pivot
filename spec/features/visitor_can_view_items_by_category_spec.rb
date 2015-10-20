require "rails_helper"

feature "visitor can view items by category" do
  include_context("features")

  scenario "from the navbar menu" do
    category = Category.create!(name: "Wool")
    other_category = Category.create!(name: "Fire")
    item = Item.create!(title: "First Item",
                       description: "test description",
                       category: category)
    item2 = Item.create!(title: "Second Item",
                        description: "other test description",
                        category: other_category)
    Auction.create!(starting_price: 20, item_id: item.id)
    Auction.create!(starting_price: 15, item_id: item2.id)
    visit "/auctions"
    click_on "Categories"
    click_on "Wool"
    expect(current_path).to eq(category_path(category))

    within(".header") do
      expect(page).to have_content("Wool")
    end
    within(".items") do
      expect(page).to have_content("First Item")
      expect(page).to have_content("test description")
      expect(page).to have_content("Current Bid")

      expect(page).to_not have_content("Second Item")
    end
  end

  scenario "from the category index" do
    category = Category.create!(name: "Wool")
    other_category = Category.create!(name: "Fire")
    item = Item.create!(title: "First Item",
                       description: "test description",
                       category: category)
    item2 = Item.create!(title: "Second Item",
                        description: "other test description",
                        category: other_category)
    Auction.create!(starting_price: 20, item_id: item.id)
    Auction.create!(starting_price: 15, item_id: item2.id)
    visit "/categories/#{category.id}"
    within(".header") do
      expect(page).to have_content("Wool")
    end
    within(".items") do
      expect(page).to have_content("First Item")
      expect(page).to have_content("test description")
      expect(page).to have_content("Current Bid")

      expect(page).to_not have_content("other test description")
    end
  end
end
