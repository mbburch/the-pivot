require 'rails_helper'

feature "user can visit stores index" do
  scenario "as a guest user" do
    user  = User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205")
    store1 = Store.create(title: "Adam", user_id: user.id)
    store2 = Store.create(title: "Bob's Big Boys", user_id: user.id)
    store3 = Store.create(title: "Bob's Big Dogs", user_id: user.id)

    visit root_path
    expect(page).to have_content("Browse Stores")
    click_on "Browse Stores"
    expect(current_path).to eq stores_path
    expect(page).to have_content("Bob's big dogs")
  end
end