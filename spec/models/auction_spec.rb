require 'rails_helper'

RSpec.describe Auction, type: :model do
  include_context "features"


 it 'counting' do
   expect(Auction.all.count).to eq(5)
 end

  it "is valid" do
    expect(auction_one).to be_valid
  end

  it "is invalid with a negative price" do
    auction_one.starting_price = -10
    expect(auction_one).to_not be_valid
  end

  it "is invalid with no amount" do
    auction_one.starting_price = nil
    expect(auction_one).to_not be_valid
  end

  it "is invalid with no item" do
    auction_one.item_id = nil
    expect(auction_one).to_not be_valid
  end

  it "has status of open" do
    expect(Auction.open.first.id).to eq(auction_one.id)
    expect(Auction.open.count).to eq(1)
  end

  it "it knows status" do
    expect(auction_one.update_status).to eq("open")
    expect(auction_two.update_status).to eq("scheduled")
    expect(ended_auction.update_status).to eq("ended")
  end

  it "can be ended" do
    expect(auction_one.update_status).to eq("open")
    auction_one.ending_time = Time.now - 1.minute
    expect(auction_one.update_status).to eq("ended")
  end

  it "knows the final bid amount when ended" do
    auction_one.ending_time = Time.now - 1.minute
    expect(auction_one.update_status).to eq("ended")

    expect(auction_one.highest_bid).to eq(201)
  end

  it "knows the winning user of the auction_one" do
    expect(auction_one.update_status).to eq("open")
    auction_one.bids << bid
    auction_one.bids << higher_bid
    auction_one.bids << winning_bid

    auction_one.ending_time = Time.now - 1.minute
    expect(auction_one.update_status).to eq("ended")
    expect(auction_one.highest_bid).to eq(400)
    expect(auction_one.winner).to eq(user_two)
  end
end
