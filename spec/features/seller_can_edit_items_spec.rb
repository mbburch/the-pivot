require "rails_helper"

feature "Seller can edit auction items" do
  include_context "features"

  scenario "successful if no current bids" do
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_on store1.title

    expect(store1.items.flat_map(&:auctions)).to_not be_empty
    expect(store2.items.flat_map(&:auctions)).to_not be_empty

    expect(current_path).to eq("/seller/hats-hats-hats/auctions")
    first(".caption").click_link("Edit Item Info")
    fill_in "item[title]", with: "updated title"
    fill_in "item[description]", with: "updated description"
    select "Other Category", from: "item[category_id]"
    click_on("Edit Item")
    expect(current_path).to eq("/seller/items/#{item.id}")
    expect(page).to have_content("updated title")
    expect(page).to have_content("updated description")
    expect(page).to have_content("updated title was successfully edited.")
  end

  scenario "fails with missing info" do
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_on store1.title

    expect(store1.items.flat_map(&:auctions)).to_not be_empty
    expect(store2.items.flat_map(&:auctions)).to_not be_empty

    expect(current_path).to eq("/seller/hats-hats-hats/auctions")
    first(".caption").click_link("Edit Item Info")
    fill_in "item[title]", with: ""
    fill_in "item[description]", with: "updated description"
    select "Other Category", from: "item[category_id]"
    click_on("Edit Item")
    expect(current_path).to eq("/seller/items/#{item.id}/edit")
    expect(page).to_not have_content("updated title")
    expect(page).to_not have_content("updated description")
    expect(page).to have_content("Title can't be blank")
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
