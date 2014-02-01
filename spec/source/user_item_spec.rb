require 'spec_helper'

include Ants::Colony

describe UserItem do
  let(:item){ UserItem.new({x: 0, y: 0}, {})}

  it "has helper methods" do
    expect(item).to respond_to(:x, :y, :data, :position, :print, :dissimilarity)
  end

  describe "methods" do
    it "measures dissimilarity between user items"
  end

end
