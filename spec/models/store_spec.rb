require 'rails_helper'

RSpec.describe Store, type: :model do

  it "is valid" do
    user  = User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205")
    store = Store.create(name: "Adam", user_id: user.id)
    expect(store).to be_valid
  end

  it "is invalid if store name already exists" do
    user =  User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205")
    store1 = Store.create(name: "Mimi", user_id: user.id)
    store2 = Store.create(name: "mimi", user_id: user.id)

    expect(store1).to be_valid
    expect(store2).to_not be_valid
  end

  it "must belong to a user" do
    user =  User.create(username: "alice",
            password: "password",
            full_name: "Alice Jones",
            address: "1500 Blake St., Denver, CO 80205")
    store = Store.create(name: "Mimi", user_id: user.id)
    store.user_id = nil
    expect(store).to_not be_valid
  end
end