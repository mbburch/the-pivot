require "rails_helper"

feature "Admin viewing items" do
  include_context "features"

  scenario "can edit items" do
    other_category = Category.create(name: "other category")
    log_in_as("admin", "password")
    visit "/admin/items"
    first(".caption").click_link("Edit")
    expect(current_path).to eq("/admin/items/#{item.id}/edit")
    fill_in "item[title]", with: "other test"
    fill_in "item[description]", with: "other test description"
    fill_in "item[price]", with: "60"
    fill_in "item[status]", with: "Active"
    select "other category", from: "item[category_id]"
    click_on("Submit")
    expect(current_path).to eq(item_path(item))
    expect(page).to have_content("other test")
    expect(page).to have_content("other test description")
    visit "/categories/#{other_category.id}"
    expect(page).to have_content("other test")
  end

  scenario "can not edit items with invalid input" do
    log_in_as("admin", "password")
    visit "/admin/items"
    first(".caption").click_link("Edit")
    fill_in "item[title]", with: ""
    fill_in "item[price]", with: "-2"
    click_on("Submit")
    expect(current_path).to eq("/admin/items/#{item.id}/edit")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Price must be greater than 0")
  end
end
