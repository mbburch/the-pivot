require "rails_helper"

feature "Seller editing profile" do
  include_context "features"

  scenario "succeeds with valid attributes" do
    User.create(username: "seller",
                password: "password",
                full_name: "Seller Jones",
                address: "123 Maine St. Anytown, USA",
                email: "seller@example.com",
                role: 2)
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_on "Edit My Profile"
    fill_in "user[username]", with: "newname"
    fill_in "user[password]", with: "test password"
    fill_in "user[full_name]", with: "test full name"
    fill_in "user[address]", with: "987 test seller address"
    fill_in "user[email]", with: "testsellermail@email.com"
    click_on "Save My Profile"
    expect(current_path).to eq("/newname/dashboard")
    expect(page).to have_content("Hello, Newname")
  end

  scenario "fails with invalid attributes" do
    User.create(username: "seller",
                password: "password",
                full_name: "Seller Jones",
                address: "123 Maine St. Anytown, USA",
                email: "seller@example.com",
                role: 2)
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_on "Edit My Profile"
    fill_in "user[username]", with: "alice"
    fill_in "user[password]", with: "test password"
    fill_in "user[full_name]", with: "test full name"
    fill_in "user[address]", with: "987 test seller address"
    fill_in "user[email]", with: "testsellermail@email.com"
    click_on "Save My Profile"

    expect(current_path).to eq("/edit")
    expect(page).to have_content("Username has already been taken")
  end
end