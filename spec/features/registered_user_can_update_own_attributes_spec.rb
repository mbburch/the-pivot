require "rails_helper"

feature "User editing profile" do
  include_context "features"

  scenario "succeeds with valid attributes" do
    log_in_as("alice", "password")
    visit "/dashboard"
    click_on "Edit My Profile"
    fill_in "user[username]", with: "test username"
    fill_in "user[password]", with: "test password"
    fill_in "user[full_name]", with: "test full name"
    fill_in "user[address]", with: "987 test address"
    fill_in "user[email]", with: "testmail@email.com"
    click_on "Save My Profile"

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("Hello, TEST USERNAME!")
  end

  scenario "fails with invalid attributes" do
    log_in_as("alice", "password")
    visit "/dashboard"
    click_on "Edit My Profile"
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "test password"
    fill_in "user[full_name]", with: "test full name"
    fill_in "user[address]", with: "987 test address"
    fill_in "user[email]", with: "testmail@email.com"
    click_on "Save My Profile"

    expect(current_path).to eq("/edit")
    expect(page).to have_content("Username has already been taken")
  end
end
