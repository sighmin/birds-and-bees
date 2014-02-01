require 'spec_helper'

include Ants

describe Grid do
  SIZE = 5
  let(:grid) { Grid.build(SIZE, SIZE){|x,y| nil} }

  it "exposes additional helper methods" do
    expect(grid).to respond_to(:[], :[]=, :set, :sample, :sample_position, :size, :to_s, :sample_nil_position)
  end

  describe "methods" do
    let(:grid) do
      Grid.build(SIZE, SIZE){|x,y| (x == 0 && y == 0) ? "circular" : nil}
    end

    it "#[] provides circular indexing" do
      out_of_bounds = {x: SIZE, y: SIZE}
      expect { grid[out_of_bounds[:x], out_of_bounds[:y]] }.to_not raise_error
      expect(grid[out_of_bounds[:x], out_of_bounds[:y]]).to eq("circular")
    end

    it "#[]= is mutable" do
      expect { grid[0,0] = "a new item" }.to_not raise_error
      expect { grid.set({x: 0, y: 0}, "a new item") }.to_not raise_error
    end

    it "#get returns the value at the position" do
      expect(grid.get({x: 0, y: 0})).to eq("circular")
    end

    it "#set assigns the value at the position" do
      position = {x: SIZE-1, y: SIZE-1}
      grid.set(position, "botright")
      expect(grid.get(position)).to eq("botright")
    end

    it "#size returns width of the square matrix" do
      expect(grid.square?).to eq(true)
      expect(grid.size).to eq(SIZE)
    end

    it "#sample, #sample_position, #sample_nil_position work" do
      expect(grid.sample_position).to include(:x, :y)
      expect(grid.sample_position[:x]).to be >= 0
      expect(grid.sample_position[:x]).to be < SIZE
      expect(grid.sample_position[:y]).to be >= 0
      expect(grid.sample_position[:y]).to be < SIZE
      expect { grid.sample }.to_not raise_error
      expect(grid.get(grid.sample_nil_position)).to be_nil
    end

    it "#place assigns the values of the positional objects in the array" do
      pos1, pos2 = {x:0,y:SIZE-1}, {x:SIZE-1,y:0}
      item1, item2 = Ants::Colony::Item.new(pos1), Ants::Colony::Item.new(pos2)
      items = []
      items << item1
      items << item2
      grid.place(items)
      expect(grid.get(pos1)).to be(item1)
      expect(grid.get(pos2)).to be(item2)
    end

    it "#to_s prints a pretty grid" do
      grid = Grid.build(2,2){|x,y| nil }
      grid[0,0] = Ants::Colony::Item.new
      grid[1,1] = Ants::Colony::Ant.new(nil, {x:1, y:1})
      expect(grid.to_s).to eq("O . \n. x \n")
    end
  end
end
