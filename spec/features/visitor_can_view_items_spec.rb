require "rails_helper"

feature "visitor viewing auctions" do
  include_context("features")

  scenario "can view auctions" do
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
      expect(page).to have_content("Auctions")
    end
    within(".items") do
      expect(page).to have_content("First Item")
      expect(page).to have_content("Second Item")
      expect(page).to have_content("Current Bid")
    end
  end
end
