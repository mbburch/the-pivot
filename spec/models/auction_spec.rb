require 'rails_helper'

RSpec.describe Auction, type: :model do
  include_context "features"


 it 'counting' do
   expect(Auction.all.count).to eq(3)
 end

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

  it "is invalid with no item" do
    auction.item_id = nil
    expect(auction).to_not be_valid
  end

  it "has status of open" do
    expect(Auction.open.first.id).to eq(auction.id)
    expect(Auction.open.count).to eq(1)
  end

  it "it knows auction status" do
    expect(auction.status).to eq("open")
    expect(auction_two.status).to eq("scheduled")
    expect(ended_auction.status).to eq("ended")
  end

  it "can be ended" do
    
  end






end
