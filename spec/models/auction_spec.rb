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
    expect(auction.status).to eq("open")
    auction.ending_time = Time.now - 1.minute
    expect(auction.status).to eq("ended")
  end

  it "knows the final bid amount when ended" do
    auction.bids << bid
    expect(bid.status).to eq("Winning Bid")

    auction.bids << higher_bid
    expect(higher_bid.status).to eq("Winning Bid")

    auction.ending_time = Time.now - 1.minute
    expect(auction.status).to eq("ended")

    expect(auction.highest_bid).to eq(201)
  end

  it "knows the winning user of the auction" do
    expect(auction.status).to eq("open")
    auction.bids << bid
    auction.bids << higher_bid
    auction.bids << winning_bid

    auction.ending_time = Time.now - 1.minute
    expect(auction.status).to eq("ended")
    expect(auction.highest_bid).to eq(400)
    expect(auction.winner).to eq(user_two)
  end
end
