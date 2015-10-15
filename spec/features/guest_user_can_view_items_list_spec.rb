require 'rails_helper'

feature "guest user visits home page" do
  include_context('features')

  scenario "un-registered user" do
    visit '/'
    expect(page).to have_content("BidDay")
    expect(page).to have_content("test title")
    expect(page).to have_content("other test title")
    expect(current_path).to eq(root_path)
  end

end
