require 'rails_helper'

feature "seller can view store items" do

  scenario "can see their own dashboard" do
    user  = User.create(username: "alice",
                        password: "password",
                        full_name: "Alice Jones",
                        address: "1500 Blake St., Denver, CO 80205",
                        email: "alice@example.com",
                        role: 2)

    store_one = Store.create( title: "hats hats hats",
                              description: "Never leave your head uncovered.",
                              user_id: user.id)
    store_two = Store.create( title: "handmade wallets",
                              description: "Put your money here.",
                              user_id: user.id)

    visit root_path
    click_link("Log In")
    fill_in 'user[username]', with: "alice"
    fill_in 'user[password]', with: "password"
    within('#log-in') do
      click_button('Log In')
    end

    expect(current_path).to eq seller_dashboard_path(user.username)
    expect(page).to have_link("Hats Hats Hats")
    expect(page).to have_link("Handmade Wallets")


    within(".hats-hats-hats") do
      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")
    end
    expect(page).to have_link("Add New Store")
  end

  scenario "a seller cant see other sellers page" do
    user  = User.new(username: "alice",
                        password: "password",
                        full_name: "Alice Jones",
                        address: "1500 Blake St., Denver, CO 80205",
                        email: "alice@example.com",
                        role: 2)

    other_seller = User.new(username: "bob",
                               password: "password",
                               full_name: "Bob Jones",
                               address: "1500 Blake St., Denver, CO 80205",
                               email: "bob@example.com",
                               role: 2)

    visit root_path
    click_link("Log In")
    fill_in 'user[username]', with: "bob"
    fill_in 'user[password]', with: "password"
    within('#log-in') do
      click_button('Log In')
    end
    visit '/alice/dashboard'
    expect(current_path).to eq('/bob/dashboard')
  end

  scenario "a visitor cannot access any seller dashboard" do
    visit '/alice/dashboard'
    expect(current_path).to eq('/')
  end

end
