require 'rails_helper'

feature "seller can create an auction" do
  include_context "features"

  scenario "with valid attributes" do
    log_in_as("seller", "password")
    expect(current_path).to eq("/seller/dashboard")
    click_on "Create an Auction"
    expect(current_path).to eq("/seller/auctions/new")

    select "Hats Hats Hats", from: "auction[store_id]"
    select "test title", from: "auction[item_id]"
    fill_in "auction[starting_price]", with: 25
    select "2015", from: "auction[starting_time(1i)]"
    select "October", from: "auction[starting_time(2i)]"
    select "23", from: "auction[starting_time(3i)]"
    select "03 AM", from: "auction[starting_time(4i)]"
    select "30", from: "auction[starting_time(5i)]"

    select "2015", from: "auction[ending_time(1i)]"
    select "October", from: "auction[ending_time(2i)]"
    select "30", from: "auction[ending_time(3i)]"
    select "05 PM", from: "auction[ending_time(4i)]"
    select "00", from: "auction[ending_time(5i)]"

    click_on "Create Auction"
    expect(page).to have_content("Your auction is all set!")
    expect(current_path).to eq("/seller/dashboard")
  end

  scenario "fails with missing attributes" do
    log_in_as("seller", "password")
    expect(current_path).to eq("/seller/dashboard")
    click_on "Create an Auction"
    expect(current_path).to eq("/seller/auctions/new")

    select "Hats Hats Hats", from: "auction[store_id]"
    select "test title", from: "auction[item_id]"
    fill_in "auction[starting_price]", with: ""
    select "2015", from: "auction[starting_time(1i)]"
    select "October", from: "auction[starting_time(2i)]"
    select "23", from: "auction[starting_time(3i)]"
    select "03 AM", from: "auction[starting_time(4i)]"
    select "30", from: "auction[starting_time(5i)]"

    select "2015", from: "auction[ending_time(1i)]"
    select "October", from: "auction[ending_time(2i)]"
    select "30", from: "auction[ending_time(3i)]"
    select "05 PM", from: "auction[ending_time(4i)]"
    select "00", from: "auction[ending_time(5i)]"

    click_on "Create Auction"
    expect(page).to have_content("Starting price is not a number, Starting price can't be blank")
    expect(current_path).to eq("/seller/auctions/new")
  end

  scenario "fails if end date is before start date" do
    log_in_as("seller", "password")
    expect(current_path).to eq("/seller/dashboard")
    click_on "Create an Auction"
    expect(current_path).to eq("/seller/auctions/new")

    select "Hats Hats Hats", from: "auction[store_id]"
    select "test title", from: "auction[item_id]"
    fill_in "auction[starting_price]", with: 26
    select "2015", from: "auction[starting_time(1i)]"
    select "October", from: "auction[starting_time(2i)]"
    select "27", from: "auction[starting_time(3i)]"
    select "03 AM", from: "auction[starting_time(4i)]"
    select "30", from: "auction[starting_time(5i)]"

    select "2015", from: "auction[ending_time(1i)]"
    select "October", from: "auction[ending_time(2i)]"
    select "25", from: "auction[ending_time(3i)]"
    select "05 PM", from: "auction[ending_time(4i)]"
    select "00", from: "auction[ending_time(5i)]"

    click_on "Create Auction"
    expect(page).to have_content("Please make sure you have filled in all of the fields.")
    expect(current_path).to eq("/seller/auctions/new")
  end
end