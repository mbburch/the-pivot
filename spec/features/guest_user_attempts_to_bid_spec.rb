require 'rails_helper'

feature "user cannot place a bid" do
  include_context('features')

  scenario "as a guest user" do
    item = Item.first
    auction = Auction.create(starting_price: 15, item_id: item.id,
                              starting_time: DateTime.now - 4.days,
                                ending_time: DateTime.now + 4.days)
    visit item_path(item)
    expect(current_path).to eq(item_path(item))
    expect(page).to have_content("Current Bid")
    expect(page).to have_selector(:link_or_button, "Join to Bid")
    click_on "Join to Bid"
    expect(current_path).to eq login_path
  end
end
