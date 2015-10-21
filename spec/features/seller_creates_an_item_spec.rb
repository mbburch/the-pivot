require "rails_helper"

feature "User creating item" do
  include_context "features"

  scenario "without image succeeds while logged in as seller" do
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_link("Create an Item")
    fill_in "item[title]", with: "Collector's Item"
    fill_in "item[description]", with: "This is the last one remaining!"
    select "Test Category", from: "item[category_id]"
    click_button("Create Item")
    expect(current_path).to eq("/seller/dashboard")
    expect(page).to have_content("Collector's Item was successfully created.")
  end


  scenario "without image fails with invalid information" do
    log_in_as("seller", "password")
    visit "/seller/dashboard"
    click_link("Create an Item")
    fill_in "item[title]", with: ""
    fill_in "item[description]", with: "This is really the last one remaining!"
    select "Test Category", from: "item[category_id]"
    click_button("Create Item")
    expect(current_path).to eq("/seller/items/new")
    expect(page).to have_content("Please try again. Title can't be blank.")
  end
end
