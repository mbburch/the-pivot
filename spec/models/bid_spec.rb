require 'rails_helper'

RSpec.describe Bid, type: :model do
  bid = Bid.new(amount: 100, user_id: 1)

  it "is valid" do
    expect(bid).to be_valid
  end

  it "is invalid with a negative amount" do
    bid.amount = -10
    expect(bid).to_not be_valid
  end

  it "is invalid with no amount" do
    bid.amount = nil
    expect(bid).to_not be_valid
  end

  it "is invalid with no user" do
    bid.user = nil
    expect(bid).to_not be_valid
  end
end