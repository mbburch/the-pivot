require 'rails_helper'

feature "user can view store items" do
  scenario "unregistered user" do
    user  = User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205",
            role: 2)

    store = Store.create( title: "hats hats hats",
                          user_id: user.id)

    category = Category.create(name: "animal products")

    item = Item.create(title: "Furry Raccoon Hat",
                       description: "Hand made topper from real raccoon fur.",
                       price: 32,
                       category_id: category.id)
    visit '/stores'
    click_on("Hats hats hats")
    expect(current_path).to eq("/stores/#{store.id}")
  end



















  xscenario "as a store seller" do
    user  = User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205",
            role: 2)

    store = Store.create( title: "hats hats hats",
                          user_id: user.id)

    category = Category.create(name: "animal products")

    item = Item.create(title: "Furry Raccoon Hat",
                       description: "Hand made topper from real raccoon fur.",
                       price: 32,
                       category_id: category.id)

    visit root_path
    click_link("Log In")
    fill_in 'user[username]', with: "alice"
    fill_in 'user[password]', with: "password"
    within('#log-in') do
      click_button('Log In')
    end

    expect(current_path).to eq store_dashboard_path
    expect(page).to have_content("Furry Raccoon Hat")
    expect(page).to have_content("Hand made topper from real raccoon fur.")
    expect(page).to have_content("animal products")
  end
end
