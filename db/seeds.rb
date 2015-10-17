class Seed
  def initialize
    generate_instructors_accounts
    generate_stores
    generate_categories
    generate_items
    generate_users
    # generate_orders
  end

  def generate_instructors_accounts
    josh = User.create(
      username:  "josh",
      password:  "password",
      full_name: "Josh Mejia",
      address:   "1510 Blake St, Denver, CO 80202",
      # email:     "josh@turing.io"
    )

    andrew = User.create(
      username:  "andrew",
      password:  "password",
      full_name: "Andrew Carmer",
      address:   "1510 Blake St, Denver, CO 80202",
      # email:     "andrew@turing.io",
      role:      2
    )

    jorge = User.create(
      username:  "jorge",
      password:  "password",
      full_name: "Jorge Tellez",
      address:   "1510 Blake St, Denver, CO 80202",
      # email:     "jorge@turing.io",
      role:      1
    )
  end

  def generate_stores
    andrew = User.find_by(username: "andrew")
    20.times do |i|
      store = Store.create!(
        title: "#{Faker::Company.name} #{Faker::Company.suffix}",
        user_id: andrew.id
        )
      puts "Store #{i}: #{store.title} created!"
    end
  end

  def generate_categories
    categories = %w(Memorabilia Games Coins Toys Clothing Art Sports Money Household Pets)
    10.times do |i|
      category = Category.create!(
        name: categories[i]
        )
      puts "Category #{i+1}: #{category.name} created!"
    end
  end

  def generate_items
    1.upto(500) do |i|
      item = Item.create!(
        title:       "#{Faker::Commerce.product_name} #{i}",
        description: Faker::Lorem.paragraph,
        price:       Faker::Commerce.price,
        # avatar:      open("http://lorempixel.com/320/150"),
        category_id: assign_category(i),
        store_id:    Store.find(Random.new.rand(1..10))
        )
      puts "Item #{i}: #{item.title} created!"
    end
  end

  def assign_category(num)
    case num
    when 1..50
      category = Category.find(1)
    when 51..100
      category = Category.find(2)
    when 101..150
      category = Category.find(3)
    when 151..200
      category = Category.find(4)
    when 201..250
      category = Category.find(5)
    when 251..300
      category = Category.find(6)
    when 301..350
      category = Category.find(7)
    when 351..400
      category = Category.find(8)
    when 401..450
      category = Category.find(9)
    when 451..500
      category = Category.find(10)
    end
    category.id
  end

  def generate_users
    99.times do |i|
      user = User.create!(
        username:  "#{Faker::Internet.user_name}#{i}",
        password:  "password",
        full_name: Faker::Name.name,
        address:   "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state}, #{Faker::Address.postcode}"
        # email:     Faker::Internet.email
        )
      puts "User #{i}: #{user.username} -  created!"
    end
  end

  def generate_orders
    100.times do |i|
      user  = User.find(Random.new.rand(1..50))
      store = Store.find(Random.new.rand(1..10))
      order = Order.create!(user_id: user.id, store_id: store.id)
      add_item(order)
      puts "Order #{i}: Order for #{user.name} created!"
    end
  end

  def generate_orders
    users  = User.all
    users.each do |user|
      10.times do |i|
        store = Store.find(Random.new.rand(1..10))
        order = Order.create!(
          user_id: user.id,
          card_number: Faker::Business.credit_card_number,
          card_expiration: Faker::Business.credit_card_expiry_date,
          status: %w( Ordered Paid Cancelled Completed).shuffle.sample
          )
        add_item(order)
        puts "Order #{i}: Order for #{user.name} created!"
      end
    end
  end

  private

  def add_item(order)
    10.times do |i|
      item = Item.find(Random.new.rand(1..500))
      # order_items.load_id = item.id
      puts "#{i}: Added item #{item.title} to order #{order.id}."
    end
  end
end

Seed.new

# category1 = Category.create(name: "Crafts")
# category2 = Category.create(name: "Agriculture")
# category3 = Category.create(name: "Transportation")
#
# Item.create(title: "Urban Bees",
#             description: "Buy local Denver honey.",
#             price: 50,
#             avatar: open("https://s3.amazonaws.com/mb-the-pivot/Fork-Beekeeping.jpg"),
#             category: category2)
#
# Item.create(title: "Kitten Mittens",
#             description: "Keep your kittens cozy. These mittens are handcrafted by a Capitol Hill artisan who anticipates being able to repay the item within 6 months of starting her business. She already has a proven customer base.",
#             price: 25,
#             avatar: open("https://s3.amazonaws.com/mb-the-pivot/3_Kittens_Playing_in_the_Garden.jpg"),
#             category: category1)
#
# Order.create(user_id: 1,
#              status: "Ordered",
#              card_number: "1234123412341234",
#              card_expiration: "08/20",
#              total_cost: 50)
#
# OrderItem.create(item_id: 1, order_id: 1, quantity: 3)
# OrderItem.create(item_id: 2, order_id: 1, quantity: 1)
# OrderItem.create(item_id: 3, order_id: 1, quantity: 2)
#
# User.create(username: "admin",
#             password: "password",
#             full_name: "Admin Adminerstein",
#             address: "123 Admin Blvd, Admintown, AD",
#             role: 2)
#
# user = User.create(username: "alice",
#             password: "password",
#             full_name: "Alice Jones",
#             address: "1500 Blake St., Denver, CO 80205")
#
# store = Store.create(title: "Adam", user_id: user.id)
# Store.create(title: "Bob's Big Boys", user_id: user.id)
# Store.create(title: "Bob's Big Dogs", user_id: user.id)
#
# item = Item.create(title: "Bike Bus",
#             description: "We'll bring our shop to you.",
#             price: 100,
#             avatar: open("https://s3.amazonaws.com/mb-the-pivot/Hilltop_Bicycles_Summit_NJ.JPG"),
#             category: category3,
#             store_id: store.id)
