require "rails_helper"

feature "visitor viewing items" do
  include_context("features")

  scenario "can view items" do
    visit "/"
    within(".nav-wrapper") do
      expect(page).to have_content("Items")
    end
    expect(page).to have_content("test title")
    expect(page).to have_content("test description")
    expect(page).to have_content("$50.00")
  end
end
