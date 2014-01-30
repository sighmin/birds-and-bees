require 'spec_helper'

include Ants::Colony

describe Item do
  let!(:item){ Item.new({x: 0, y: 0}, {})}

  it "has helper methods" do
    expect(item).to respond_to(:x, :y, :data, :position)
  end

  it "has a similarity to another item"
end
