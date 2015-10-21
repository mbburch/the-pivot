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
    User.create(username: "seller",
                password: "password",
                full_name: "Seller McSellerson",
                address: "123 Buy Blvd, Shoptown, USA",
                email: "seller@example.com",
                role: 2)
  end

  let!(:user) do
    User.create(username: "alice",
                password: "password",
                full_name: "Alice Smith",
                address: "123 Main St. Anytown, USA",
                email: "user2@example.com",
                role: 0)
  end

  let!(:user_two) do
    User.create(username: "Beth",
                password: "password",
                full_name: "Beth Sanches",
                address: "10 birch rd. Scranton, USA",
                email: "beth2@example.com",
                role: 0)
  end

  let!(:category) do
    Category.create(name: "Test Category")
  end

  let!(:other_category) do
    Category.create(name: "Other Category")
  end

  let!(:third_category) do
    Category.create(name: "third Category")
  end

  let!(:item) do
    Item.create(title: "test title",
                description: "test description",
                category: category)
  end

  let!(:other_item) do
    Item.create(title: "other test title",
                description: "other test description",
                category: other_category)
  end

  let!(:third_item) do
    Item.create(title: "third test title",
                description: "third test description",
                category: third_category)
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

  let!(:auction) do
    Auction.create(starting_price: 175,
                          item_id: item.id,
                    starting_time: DateTime.now - 4.days,
                      ending_time: DateTime.now + 4.days)
  end

  let!(:auction_two) do
    Auction.create(starting_price: 89,
                          item_id: other_item.id,
                    starting_time: DateTime.now + 2.days,
                      ending_time: DateTime.now + 4.days)
  end

  let!(:ended_auction) do
    Auction.create(starting_price: 50,
                          item_id: other_item.id,
                    starting_time: DateTime.now - 4.days,
                      ending_time: DateTime.now - 2.days)
  end

  let!(:bid) do
    Bid.create(amount: 200,
              user_id: user.id)
  end

  let!(:higher_bid) do
    Bid.create(amount: 201 ,
              user_id: user.id)
  end

  let!(:winning_bid) do
    Bid.create(amount: 400 ,
              user_id: user_two.id)
  end

  def log_in_as(username, password)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: username
    fill_in "user[password]", with: password
    click_button "Log In"
  end
end
