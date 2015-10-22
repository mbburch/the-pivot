shared_context "features" do

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

  let!(:other_seller) do
    User.create(username: "bob",
                password: "password",
                full_name: "Bob Jones",
                address: "1500 Blake St., Denver, CO 80205",
                email: "bob@example.com",
                role: 2)
  end

  let!(:category) do
    Category.create(name: "Test Category")
  end

  let!(:other_category) do
    Category.create(name: "Other Category")
  end

  let!(:third_category) do
    Category.create(name: "Third Category")
  end

  let!(:item) do
    Item.create(title: "test title",
                description: "test description",
                store: store1,
                category: category)
  end

  let!(:other_item) do
    Item.create(title: "other test title",
                description: "other test description",
                store: store2,
                category: other_category)
  end

  let!(:third_item) do
    Item.create(title: "third test title",
                description: "third test description",
                category: third_category)
  end

  let!(:bidless_auction) do
    Auction.create(item: item, starting_price: 15, status: "open")
  end

  let!(:auction) do
    auction = Auction.create(item: other_item, starting_price: 15)
  end



  let!(:store1) do
    Store.create( title: "hats hats hats",
                  description: "Never leave your head uncovered.",
                  user: seller)
 end

 let!(:store2) do
   Store.create( title: "handmade wallets",
                 description: "Put your money here.",
                 user: seller)
 end

  let!(:auction_one) do
    Auction.create(starting_price: 175,
                   item_id: third_item.id,
                   starting_time: DateTime.now - 4.days,
                   ending_time: DateTime.now + 4.days)
  end

  let!(:auction_two) do
    Auction.create(starting_price: 89,
                   item_id: third_item.id,
                   starting_time: DateTime.now + 2.days,
                   ending_time: DateTime.now + 4.days)
  end

  let!(:ended_auction) do
    Auction.create(starting_price: 50,
                   item_id: third_item.id,
                   starting_time: DateTime.now - 4.days,
                   ending_time: DateTime.now - 2.days)
  end

  let!(:bid) do
    Bid.create(amount: 20, auction: auction, user: user)
  end

  let!(:low_bid) do
    Bid.create(amount: 200,
               user_id: user.id,
               auction: auction_one)
  end

  let!(:higher_bid) do
    Bid.create(amount: 201,
               user_id: user.id,
               auction: auction_one)
  end

  let!(:winning_bid) do
    Bid.create(amount: 400,
               user_id: user_two.id)
  end

  let!(:order) do
    Order.create(user_id: user.id,
                 card_number: "1234",
                 card_expiration: "09/10",
                 total_cost: 100.50,
                 status: "Ordered")
  end

  def log_in_as(username, password)
    visit "/"
    click_link("Log In")
    fill_in "user[username]", with: username
    fill_in "user[password]", with: password
    click_button "Log In"
  end
end
