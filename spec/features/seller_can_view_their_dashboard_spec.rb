require 'rails_helper'

feature "seller can view store items" do
  include_context "features"

  scenario "can see their own dashboard" do
    log_in_as("seller", "password")
    expect(current_path).to eq ("/seller/dashboard")
    expect(page).to have_link("Hats Hats Hats")
    expect(page).to have_link("Handmade Wallets")


    within(".hats-hats-hats") do
      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")
    end
    expect(page).to have_link("Add New Store")
  end

  scenario "a seller cant see other sellers page" do
    log_in_as("bob", "password")
    visit '/seller/dashboard'
    expect(current_path).to eq('/bob/dashboard')
  end

  scenario "a visitor cannot access any seller dashboard" do
    visit '/alice/dashboard'
    expect(current_path).to eq('/')
  end

end
