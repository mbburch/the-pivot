require "rails_helper"

feature "Seller can edit auction items" do
  include_context "features"

  scenario "successful if no current bids" do
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_on store1.title
    expect(current_path).to eq("/seller/hats-hats-hats/auctions")
    first(".caption").click_link("Edit")
    fill_in ""
    fill_in "item[title]", with: "updated title"
    fill_in "item[description]", with: "updated description"
    select "other category", from: "item[category_id]"
    click_on("Submit")
    expect(current_path).to eq(item_path(item))
    expect(page).to have_content("other test")
    expect(page).to have_content("other test description")
    visit "/categories/#{other_category.id}"
    expect(page).to have_content("other test")
    expect(page).to have_content("You have successfully edited Updated Title.")
  end

  scenario "can not edit auction items with current bids" do
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_on store2.title
    expect(current_path).to eq("/seller/handmade-wallets/auctions")
    second(".caption").click_link("Edit")
    fill_in "item[title]", with: "updated title two"
    fill_in "item[description]", with: "updated description two"
    select "category", from: "item[category_id]"
    click_on("Submit")
    expect(current_path).to eq("/seller/items/#{item.id}/edit")
    expect(page).to have_content("You may not edit an auction with a current bid.")
  end
end
