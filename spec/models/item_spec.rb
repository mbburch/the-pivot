require "rails_helper"

RSpec.describe Item, type: :model do
  include_context "features"

  it "is valid" do
    expect(item).to be_valid
  end

  it "is invalid without a title" do
    item.title = nil
    expect(item).to_not be_valid
  end

  it "is invalid without a description" do
    item.description = nil
    expect(item).to_not be_valid
  end

  it "must have a unique name" do
    item.save
    new_item = Item.new(title: "test title",
                        description: "test description")
    expect(new_item).to_not be_valid
  end

  it "must belong to a category" do
    item.category = nil
    expect(item).to_not be_valid
  end
end
