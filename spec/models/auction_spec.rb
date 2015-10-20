require 'rails_helper'

RSpec.describe Auction, type: :model do
  auction = Auction.new(starting_price: 100, item_id: 2)

  it "is valid" do
    expect(auction).to be_valid
  end

  it "is invalid with a negative price" do
    auction.starting_price = -10
    expect(auction).to_not be_valid
  end

  it "is invalid with no amount" do
    auction.starting_price = nil
    expect(auction).to_not be_valid
  end
end