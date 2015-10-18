require "rails_helper"

feature "Admin editing profile" do
  include_context "features"

  scenario "succeeds with valid attributes" do
    log_in_as("admin", "password")
    visit "/"
    click_link "Admin"
    click_link "Edit My Profile"
    fill_in "admin[username]", with: "test username"
    fill_in "admin[password]", with: "test password"
    fill_in "admin[full_name]", with: "test full name"
    fill_in "admin[address]", with: "987 test address"
    fill_in "admin[email]", with: "testmail@email.com"
    click_on "Save Admin"

    expect(current_path).to eq("/admin/dashboard")
    expect(page).to have_content("Hello, TEST USERNAME!")
  end

  scenario "fails with invalid attributes" do
    log_in_as("admin", "password")
    visit "/"
    click_link "Admin"
    click_link "Edit My Profile"
    fill_in "admin[username]", with: "alice"
    fill_in "admin[password]", with: "password"
    fill_in "admin[full_name]", with: "test full name"
    fill_in "admin[address]", with: "987 test address"
    click_on "Save Admin"

    expect(current_path).to eq("/admin/edit")
    expect(page).to have_content("Username has already been taken")
  end
end
