require "rails_helper"

feature "Seller can edit auction items" do
  include_context "features"

  scenario "successful if no current bids" do
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_on store1.title
    expect(current_path).to eq("/seller/hats-hats-hats/auctions")
    save_and_open_page
    first(".caption").click_link("Edit Item Info")
    fill_in "item[title]", with: "updated title"
    fill_in "item[description]", with: "updated description"
    select "Other Category", from: "item[category_id]"
    click_on("Edit Item")
    expect(current_path).to eq("/seller/items/#{item.id}")
    expect(page).to have_content("updated title")
    expect(page).to have_content("updated description")
    visit "/categories/#{other_category.id}"
    expect(page).to have_content("updated title")
    save_and_open_page
    expect(page).to have_content("Updated Title was successfully edited.")
  end

  scenario "can not edit auction items with current bids" do
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_on store2.title
    expect(current_path).to eq("/seller/handmade-wallets/auctions")
    within first(".caption") do
      expect(page).to have_content("Unable to Edit: Active Bid")
      expect(page).to_not have_link("Edit Item")
    end
  end
end
