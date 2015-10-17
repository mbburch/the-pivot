require 'rails_helper'

feature "user can visit a store" do
  scenario "as a guest user" do
    user   = User.create(username: "alice",
                        password: "password",
                        full_name: "Alice Jones",
                        address: "1500 Blake St., Denver, CO 80205")
    store = Store.create(title: "Adam", user_id: user.id)
            Item.create(title: "Bike Bus",
            description: "We'll bring our shop to you.",
            price: 100,
            avatar: open("https://s3.amazonaws.com/mb-the-pivot/Hilltop_Bicycles_Summit_NJ.JPG"),
            category: Category.create(name: "Transportation"),
            store_id: store.id)

    visit stores_path
    expect(page).to have_content("Adam")
    click_on "Adam"
    expect(current_path).to eq(store_path(store))
    expect(page).to have_content("We'll bring our shop to you.")
  end
end