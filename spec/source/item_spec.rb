require 'spec_helper'

include Ants::Colony

describe Item do
  POSITION = {x: 0, y: 1}
  let(:grid){ Ants::Grid.build(2,2){|x,y| nil } }
  let(:item) do
    the_item = Item.new({x: 0, y: 0}, {})
    grid.place([the_item])
    the_item
  end

  it "has helper methods" do
    expect(item).to respond_to(:x, :y, :data, :position, :position=, :print, :dissimilarity)
  end

  describe "methods" do
    it "#print returns a representative string" do
      expect(item.print).to eq("O")
    end

    it "#position returns items position in a hash" do
      expect(item.position).to eq({x: 0, y: 0})
    end

    it "#position= sets the items postion" do
      pos = {x:1,y:1}
      item.position = pos
      expect(item.position).to eq(pos)
    end
  end

  describe "class methods" do
    it "#dissimilarity raises an error" do
      expect { Item.send(:dissimilarity) }.to raise_error
    end
  end

end
