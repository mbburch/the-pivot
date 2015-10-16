require 'rails_helper'

feature "user attempts to bid" do
  include_context('features')

  scenario "as a guest user" do
    item = Item.first
    visit item_path(item)
    expect(current_path).to eq(item_path(item))
    expect(page).to have_content("Current Bid")
    expect(page).to have_selector(:link_or_button, "Place Bid")
    fill_in "bid[amount]", with: 5
    click_on "Place Bid"
    expect(current_path).to eq login_path
    message = "Please Login or Create an Account to Place a Bid"
    expect(page).to have_content(message)
  end
end