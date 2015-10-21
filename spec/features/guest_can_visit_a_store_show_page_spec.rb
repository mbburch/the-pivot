require 'rails_helper'

feature "user can visit a store" do
  scenario "as a guest user" do
    user   = User.create(username: "alice",
                        password: "password",
                        full_name: "Alice Jones",
                        address: "1500 Blake St., Denver, CO 80205",
                        email: "alice@example.com")
    store = Store.create(title: "Adam", description: "We sell everything", user_id: user.id)
    item  = Item.create(title: "Bike Bus",
            description: "We'll bring our shop to you.",
            avatar: open("https://s3.amazonaws.com/mb-the-pivot/Hilltop_Bicycles_Summit_NJ.JPG"),
            category: Category.create(name: "Transportation"),
            store_id: store.id)
    Auction.create(item_id: item.id, starting_price: 15,
           starting_time: DateTime.now - 4.days,
             ending_time: DateTime.now + 4.days)

    visit stores_path
    expect(page).to have_content("Adam")
    expect(page).to have_content("We sell everything")
    click_on "Adam"
    expect(page).to have_content("We'll bring our shop to you.")
    expect(current_path).to eq(store_auctions_path(store.slug))
  end
end
