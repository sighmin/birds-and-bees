require 'spec_helper'

include Ants::Colony

describe UserItem do
  let(:item){ UserItem.new({x: 0, y: 0}, {})}

  it "has helper methods" do
    expect(item).to respond_to(:x, :y, :data, :position, :print)
    expect(Item).to respond_to(:pickup_probability, :drop_probability, :dissimilarity)
  end

  describe "methods" do

    it "#pickup_probability"

    it "#drop_probability"

    describe "protected" do
      it "#dissimilarity returns a measure between user items"
    end
  end
end
