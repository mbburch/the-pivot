class Seed
  def initialize
    generate_instructors_accounts
    generate_stores
    generate_categories
    generate_loans
    generate_users
    generate_orders
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

  def generate_loans
    1.upto(500) do |i|
      loan = Loan.create!(
        title:       "#{Faker::Commerce.product_name} #{i}",
        description: Faker::Lorem.paragraph,
        price:       Faker::Commerce.price,
        # avatar:      open("http://lorempixel.com/320/150"),
        category_id: assign_category(i),
        store_id:    Store.find(Random.new.rand(1..10))
        )
      puts "Loan #{i}: #{loan.title} created!"
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
      add_loan(order)
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
        add_loan(order)
        puts "Order #{i}: Order for #{user.name} created!"
      end
    end
  end

  private

  def add_loan(order)
    10.times do |i|
      loan = Loan.find(Random.new.rand(1..500))
      # order_items.load_id = loan.id
      puts "#{i}: Added loan #{loan.title} to order #{order.id}."
    end
  end
end

Seed.new
