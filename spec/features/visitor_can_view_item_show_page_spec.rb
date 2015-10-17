require "rails_helper"

feature "visitor can navigate to the item show page" do
  include_context("features")

  scenario "without being logged in" do
    visit "/items"
    click_on "test title"
    expect(current_path).to eq(item_path(item))
    expect(page).to have_content("test description")
    expect(page).to have_content("Current Bid: $50.00")
    expect(page).to have_selector(:link_or_button, "Place Bid")
    expect(page).to_not have_content("other test description")
  end
end
