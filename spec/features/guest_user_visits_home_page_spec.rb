require 'rails_helper'

feature "user visits home page" do
  include_context('features')

  scenario "as a guest user" do
    item = Item.create!(title: "First Item",
                       description: "test description",
                       category: category)
    item2 = Item.create!(title: "Second Item",
                        description: "other test description",
                        category: other_category)
    Auction.create!(starting_price: 20, item_id: item.id)
    visit '/'
    expect(page).to have_content("BidDay")
    expect(page).to have_content("First Item")
    expect(page).to_not have_content("Second Item")
    expect(current_path).to eq(root_path)
  end
end
