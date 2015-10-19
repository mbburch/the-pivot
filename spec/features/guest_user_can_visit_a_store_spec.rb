require 'rails_helper'

feature "user can visit stores index" do
  scenario "as a guest user" do
    user  = User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205",
            email: "alice@example.com")
    store1 = Store.create(title: "Adam", description: "We sell everything", user_id: user.id)
    store2 = Store.create(title: "Bob's Big Boys", description: "Big boys.", user_id: user.id)
    store3 = Store.create(title: "Bob's Big Dogs", description: "We love big dogs.", user_id: user.id)

    visit root_path
    expect(page).to have_content("Browse Stores")
    click_on "Browse Stores"
    expect(current_path).to eq stores_path
    expect(page).to have_content("Bob's Big Dogs")
  end
end