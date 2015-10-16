category1 = Category.create(name: "Crafts")
category2 = Category.create(name: "Agriculture")
category3 = Category.create(name: "Transportation")

Item.create(title: "Urban Bees",
            description: "Buy local Denver honey.",
            price: 50,
            avatar: open("https://s3.amazonaws.com/mb-the-pivot/Fork-Beekeeping.jpg"),
            category: category2)

Item.create(title: "Kitten Mittens",
            description: "Keep your kittens cozy. These mittens are handcrafted by a Capitol Hill artisan who anticipates being able to repay the item within 6 months of starting her business. She already has a proven customer base.",
            price: 25,
            avatar: open("https://s3.amazonaws.com/mb-the-pivot/3_Kittens_Playing_in_the_Garden.jpg"),
            category: category1)

Order.create(user_id: 1,
             status: "Ordered",
             card_number: "1234123412341234",
             card_expiration: "08/20",
             total_cost: 50)

OrderItem.create(item_id: 1, order_id: 1, quantity: 3)
OrderItem.create(item_id: 2, order_id: 1, quantity: 1)
OrderItem.create(item_id: 3, order_id: 1, quantity: 2)

User.create(username: "admin",
            password: "password",
            full_name: "Admin Adminerstein",
            address: "123 Admin Blvd, Admintown, AD",
            role: 2)

user = User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205")

store = Store.create(title: "Adam", user_id: user.id)
Store.create(title: "Bob's Big Boys", user_id: user.id)
Store.create(title: "Bob's Big Dogs", user_id: user.id)

item = Item.create(title: "Bike Bus",
            description: "We'll bring our shop to you.",
            price: 100,
            avatar: open("https://s3.amazonaws.com/mb-the-pivot/Hilltop_Bicycles_Summit_NJ.JPG"),
            category: category3,
            store_id: store.id)