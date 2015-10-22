require "rails_helper"

feature "User checks out cart" do
  include_context "features"

  scenario "with valid inputs" do
    log_in_as("alice", "password")
    visit "/auctions"
    click_link("test title")
    fill_in "bid[amount]", with: 500
    click_button("Place Bid")
    expect(current_path).to eq item_path(item)
    expect(page).to have_content("Current Bid: $500")


    bidless_auction.status = "closed"
    bidless_auction.save
    visit "/dashboard"
    click_button("Pay")
    page.find("#cart").click
    expect(current_path).to eq "/cart"
    click_link("Checkout")
    expect(current_path).to eq new_order_path

    within("#payment") do
      fill_in "order[card_number]", with: "1234 1234 1234 1234"
      fill_in "order[card_expiration]", with: "10/20"
      click_button("Submit Order")
    end

    expect(page).to have_content("Items in Cart: 0")
    expect(page).to have_content("Alice Smith")
    expect(page).to have_content("123 Main St. Anytown, USA")
    expect(page).to have_content("Order successful!")
    expect(page).to have_content("$500.00")
    expect(page).to have_content("Status: Ordered")
    expect(page).to have_content("Total: $500.00")
  end

  scenario "visitor must login to checkout" do
    visit root_path
    page.find("#cart").click
    expect(current_path).to eq "/cart"
    click_link("Checkout")
    expect(current_path).to eq login_path

    message = "Please Login or Create an Account to Checkout"
    expect(page).to have_content(message)
  end
end
