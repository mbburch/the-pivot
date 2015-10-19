require 'rails_helper'

feature "a regsitered seller" do
  scenario "can create a new store" do
    user  = User.create(username: "alice",
                        password: "password",
                       full_name: "Alice Jones",
                         address: "1500 Blake St., Denver, CO 80205",
                           email: "alice@example.com",
                            role: 2)

    visit root_path
    click_link("Log In")
    fill_in 'user[username]', with: "alice"
    fill_in 'user[password]', with: "password"
    within('#log-in') do
      click_button('Log In')
    end

    click_link("Add New Store")
    expect(current_path).to eq(new_store_path)
    fill_in 'store[title]', with: "Boot City"
    fill_in 'store[description]', with: "Boots all day err' day"
    click_button("Create Store")

    expect(current_path).to eq("/alice/dashboard")
    expect(page).to have_content("Boot City")
  end

  scenario "can update an existing store" do
    user  = User.create(username: "alice",
                        password: "password",
                       full_name: "Alice Jones",
                         address: "1500 Blake St., Denver, CO 80205",
                           email: "alice@example.com",
                            role: 2)

    store_one = Store.create( title: "hats hats hats",
                        description: "Never leave your head uncovered.",
                            user_id: user.id)

    visit root_path
    click_link("Log In")
    fill_in 'user[username]', with: "alice"
    fill_in 'user[password]', with: "password"
    within('#log-in') do
      click_button('Log In')
    end

    within(".hats-hats-hats") do
      click_link("Edit")
    end

    fill_in 'store[title]', with: "pants pants pants"
    fill_in 'store[description]', with: "Great pants for the whole family!"
    click_button("Edit Store")

    expect(current_path).to eq("/alice/dashboard")
    expect(page).to have_content("Pants Pants Pants")
  end

  scenario "can delete an existing store" do
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

    within(".hats-hats-hats") do
      click_link("Delete")
    end

    expect(current_path).to eq("/alice/dashboard")
    expect(page).to_not have_content("Hats Hats Hats")
  end

end
