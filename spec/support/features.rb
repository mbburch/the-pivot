shared_context "features" do
  let!(:admin) do
    User.create(username: "admin",
                password: "password",
                full_name: "Admin Adminerstein",
                address: "123 Admin Blvd, Admintown, USA",
                email: "user1@example.com",
                role: 1)
  end

  let!(:seller) do
    seller = User.create(username: "seller",
                         password: "password",
                         full_name: "Seller McSellerson",
                         address: "123 Buy Blvd, Shoptown, USA",
                         email: "seller@example.com",
                         role: 2)
  end

  let!(:user) do
    user = User.create(username: "alice",
                       password: "password",
                       full_name: "Alice Smith",
                       address: "123 Main St. Anytown, USA",
                       email: "user2@example.com",
                       role: 0)
  end

  let!(:category) do
    Category.create(name: "Test Category")
  end

  let!(:other_category) do
    Category.create(name: "Other Category")
  end

  let!(:item) do
    item = Item.create(title: "test title",
                       description: "test description",
                       store_id: store1.id,
                       category: category)
  end

  let!(:other_item) do
    other_item = Item.create(title: "other test title",
                             description: "other test description",
                             store_id: store2.id,
                             category: other_category)
  end

  let!(:auction) do
    auction = Auction.create(item_id: other_item.id, starting_price: 15)
  end

  let!(:bid) do
    Bid.create(amount: 20, auction_id: auction.id, user_id: user.id)
  end

  let!(:store1) do
    store1 = Store.create( title: "hats hats hats",
                          description: "Never leave your head uncovered.",
                          user_id: seller.id)
  end

  let!(:store2) do
    store2 = Store.create( title: "handmade wallets",
                           description: "Put your money here.",
                           user_id: seller.id)
  end

  let!(:order) do
    order = Order.create(user_id: user.id,
                         card_number: "1234",
                         card_expiration: "09/10",
                         total_cost: 100.50,
                         status: "Ordered")
  end

  let!(:order_item) do
    OrderItem.create(item_id: item.id,
                     quantity: 1,
                     order_id: order.id)
  end

  def log_in_as(username, password)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: username
    fill_in "user[password]", with: password
    click_button "Log In"
  end
end
