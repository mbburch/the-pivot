require "rails_helper"

feature "visitor viewing items" do
  include_context("features")

  scenario "can view items" do
    visit "/items"
    within(".header") do
      expect(page).to have_content("Items")
    end
    within(".items") do
      expect(page).to have_content("test title")
      expect(page).to have_content("test description")
      expect(page).to have_content("$50.00")
    end
  end
end
