require "rails_helper"

feature "User places a bid" do
  include_context "features"

  scenario "higher than the starting price" do
    log_in_as("alice", "password")
    visit "/auctions"
    click_link("test title")
    fill_in "bid[amount]", with: 500
    click_button("Place Bid")
    expect(current_path).to eq item_path(item)
    expect(page).to have_content("Starting Price: $15")
  end


  scenario "tries to place a bid lower than the current highest bid" do
    log_in_as("alice", "password")
    visit "/auctions"
    click_link("test title")
    fill_in "bid[amount]", with: 5
    click_button("Place Bid")

    within(".alert.alert-warning") do
      expect(page).to have_content("Your bid is invalid. Please try again!")
    end

    expect(current_path).to eq item_path(item)
    expect(page).to have_content("Starting Price: $15")
  end

  scenario "tries to place a negative bid" do
    log_in_as("alice", "password")
    visit "/auctions"
    click_link("test title")
    fill_in "bid[amount]", with: -100
    click_button("Place Bid")

    within(".alert.alert-warning") do
      expect(page).to have_content("Your bid is invalid. Please try again!")
    end

    expect(current_path).to eq item_path(item)
    expect(page).to have_content("Starting Price: $15")
  end
end