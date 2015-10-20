require "rails_helper"

feature "guest can navigate to the auction show page" do
  include_context("features")

  scenario "as a guest user" do
    item = Item.find_by(title: "test title")
    Auction.create(starting_price: 50,
                   item_id: item.id)

    visit "/auctions"
    click_on "test title"
    expect(current_path).to eq(item_path(item))
    expect(page).to have_content("test description")
    expect(page).to have_content("Current Bid: $")
    expect(page).to have_selector(:link_or_button, "Join to Bid")
    expect(page).to_not have_content("other test description")
  end
end