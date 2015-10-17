require "rails_helper"

feature "visitor viewing loans" do
  include_context("features")

  scenario "can view loans" do
    visit "/"
    within(".nav-wrapper") do
      expect(page).to have_content("Items")
    end
    within(".items") do
      expect(page).to have_content("test title")
      expect(page).to have_content("test description")
      expect(page).to have_content("$50.00")
    end
  end
end
