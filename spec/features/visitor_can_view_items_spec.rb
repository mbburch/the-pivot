require "rails_helper"

feature "visitor viewing items" do
  include_context("features")
    scenario "can view items" do
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
    within(".nav-wrapper") do
      expect(page).to have_content("Items")
    end
    expect(page).to have_content("First Item")
    expect(page).to have_content("test description")
    expect(page).to have_content("$20.00")
  end

  scenario "can search for auctions" do
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

    expect(page).to have_content("First Item")
    expect(page).to have_content("Second Item")

    fill_in "search", with: "First"
    click_button "search-button"

    expect(page).to have_content("First Item")
    expect(page).not_to have_content("Second Item")

  end
end
