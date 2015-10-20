require "rails_helper"

feature "User creating item" do
  include_context "features"

  xscenario "without image succeeds while logged in as admin" do
    log_in_as("admin", "password")

    click_link("View Items")
    click_link("Create Item")
    fill_in "item[title]", with: "Test item"
    fill_in "item[description]", with: "Coming to a theater near you!"
    fill_in "item[price]", with: 50
    select "Test Category", from: "item[category_id]"
    click_button("Create Item")

    expect(current_path).to eq("/admin/items")
    expect(page).to have_content("Test item")
    expect(page).to have_content("Coming to a theater near you!")
    expect(page).to have_content("$50.00")
  end

  xscenario "fails with incorrect attributes" do
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: "admin"
    fill_in "user[password]", with: "password"
    click_button "Log In"

    click_link("View Items")
    click_link("Create Item")
    fill_in "item[description]", with: "Coming to a theater near you!"
    fill_in "item[price]", with: 50
    select "Test Category", from: "item[category_id]"
    click_button("Create Item")

    expect(current_path).to eq("/admin/items/new")
    expect(page).to have_content("Title can't be blank")
  end
end
