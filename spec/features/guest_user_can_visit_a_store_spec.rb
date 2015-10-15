require 'rails_helper'

feature "user can visit stores index" do
  include_context('features')

  scenario "as a guest user" do
    store1 = Store.create(name: "Bob's Big Boys", owner: "Bob")
    store2 = Store.create(name: "Bob's Big Dogs", owner: "Bobby")

    visit root_path
    expect(page).to have_content("Browse Stores")
    click_on "Browse Stores"
    expect(current_path).to eq stores_path
    expect(page).to have_content("Bob's Big Dogs")
  end
end